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

import QtQuick 2.4

PlayerForm {
    property int scoreCounter: 0

    id: player

    // display the initial score (0)
    Component.onCompleted: {
        updateScore()
    }

    states: [
        State {
            name: "idle"
            PropertyChanges { target: player; avatar: "qrc:/images/faces/idle.png" }
            PropertyChanges { target: player; color: "transparent" }
            StateChangeScript {
                script: {
                    updateScore()
                }
            }
        },
        State {
            name: "win"
            PropertyChanges { target: player; avatar: "qrc:/images/faces/smile.png" }
            PropertyChanges { target: player; color: "#7700FF00" }
            StateChangeScript {
                script: {
                    scoreCounter++
                    updateScore()
                }
            }
        },
        State {
            name: "fail"
            PropertyChanges { target: player; avatar: "qrc:/images/faces/sad.png" }
            PropertyChanges { target: player; color: "transparent" }
        }
    ]

    state: "idle"

    /************ FUNCTIONS ************/

    function yourTurn(turn) {
        message = turn ? qsTr("YOUR TURN") : ""
    }

    function updateScore() {
        score = scoreCounter
    }

    function reset() {
        state = "idle"
    }

    function setWin(win) {
        state = win ? "win" : "fail"
    }
}
