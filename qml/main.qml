/*  This file is part of Noughts and Crosses (https://github.com/smoked-herring/noughts-crosses)

    Copyright (c) 2020 Dmitry Baryshev <dmitrymq@gmail.com>

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
*/

import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "."

Window {
    // delay before another round
    readonly property int restartInterval: 1700 // in milliseconds

    property QtObject currentPlayer
    property QtObject anotherPlayer

    visible: true
    minimumWidth: 600
    minimumHeight: 320
    title: qsTr("Noughts and Crosses")

    // the players and the board
    RowLayout {
        anchors.fill: parent

        Player {
            id: player1
            name: qsTr("Luna")
            symbol: CellState.x
        }

        // horizontal spacer
        Item {
            Layout.fillWidth: true
        }

        ColumnLayout {
            Result {
                id: result
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                Layout.fillWidth: true
            }

            // game board with 9 cells. Controls the game process by switching the app states
            Board {
                id: board

                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                onCellClicked: {
                    if(stateHandler.state === "player1Turn")
                        stateHandler.state = "player2Turn"
                    else
                        stateHandler.state = "player1Turn"
                }

                onDraw: {
                    console.log("Draw")
                    stateHandler.state = "draw"
                }

                onVictory: {
                    console.log("Victory " + currentPlayer.name)
                    stateHandler.state = "win"
                }
            }
        }

        // horizontal spacer
        Item {
            Layout.fillWidth: true
        }

        Player {
            id: player2
            name: qsTr("Ginny")
            symbol: CellState.o
        }
    }

    // delayed initialization
    Timer {
        interval: 0
        running: true
        repeat: false
        onTriggered: reset()
    }

    // timer to restart the game when we have a draw/win
    Timer {
        id: timerRestart
        interval: restartInterval
        running: false
        repeat: false
        onTriggered: reset()
    }

    // state handler
    Item {
        id: stateHandler
        visible: false

        states: [
            State {
                name: "player1Turn"
                StateChangeScript {
                    script: {
                        currentPlayer = player1
                        anotherPlayer = player2
                        nextTurn()
                    }
                }
            },
            State {
                name: "player2Turn"
                StateChangeScript {
                    script: {
                        currentPlayer = player2
                        anotherPlayer = player1
                        nextTurn()
                    }
                }
            },
            // display a 'win' message and start another round
            State {
                name: "win"
                StateChangeScript {
                    script: {
                        result.setWin(currentPlayer.name)
                        currentPlayer.setWin(true)
                        anotherPlayer.setWin(false)
                        postPoneRestart()
                    }
                }
            },
            // display a 'draw' message and start another round
            State {
                name: "draw"
                StateChangeScript {
                    script: {
                        result.setDraw()
                        postPoneRestart()
                    }
                }
            }
        ]
    }

    /************ FUNCTIONS ************/

    /*
     *  Cleans up the UI and schedules another round.
     */
    function postPoneRestart() {
        board.setAcceptInput(false)
        currentPlayer.yourTurn(false)
        anotherPlayer.yourTurn(false)
        timerRestart.start()
    }

    function nextTurn() {
        board.setNextSymbolForCells(currentPlayer.symbol)
        currentPlayer.yourTurn(true)
        anotherPlayer.yourTurn(false)
    }

    /*
     *  Starts another round.
     */
    function reset() {
        result.newRound()

        board.reset()

        player1.reset()
        player2.reset()

        stateHandler.state = "player1Turn"
    }
}
