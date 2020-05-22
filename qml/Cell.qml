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
import QtQuick.Layouts 1.3

import "."

/*
 *  Represents a single cell. Paints 'x' or 'o' as well as a winning result. Winning result
 *  is painted with an green background
 */
CellForm {
    // the next symbol ('x' or 'o') that will be painted when the cell accepts a mouse click
    property string nextState
    // flag to paint a winning cell
    property bool resolved
    // flag to enable/disable mouse clicks
    property bool acceptInput: true
    // scale factor & animation duration of winning cells
    readonly property real winningScaleFactor: 1.2
    readonly property int winningScaleDuration: 150

    signal clicked(int x, int y)

    id: cell

    states: [
        State {
            name: CellState.unset
            PropertyChanges {
                target: image
                source: ""
            }
        },
        State {
            name: CellState.x
            PropertyChanges {
                target: image
                source: "qrc:/images/x.png"
            }
        },
        State {
            name: CellState.o
            PropertyChanges {
                target: image
                source: "qrc:/images/o.png"
            }
        }
    ]

    /*
     *  When a current player wins, we animate the winning cells with this animator
     */
    SequentialAnimation {
        id: animator
        loops: 1
        PropertyAnimation {
            target: cell
            properties: "scale"
            from: 1.0
            to: winningScaleFactor
            duration: winningScaleDuration
        }
        PropertyAnimation {
            target: cell
            properties: "scale"
            from: winningScaleFactor
            to: 1.0
            duration: winningScaleDuration
        }
    }

    state: CellState.unset

    MouseArea {
        anchors.fill: parent

        onClicked: {
            if (!acceptInput)
                return

            console.log("Clicked " + cell.Layout.row + "," + cell.Layout.column + ", next state: " + nextState)

            // ignore the already filled cell
            if(cell.state !== CellState.unset) {
                console.log("Current state is " + cell.state + ", will not change it")
                return
            }

            // accept the symbol and inform the board about the click
            cell.state = nextState
            cell.clicked(cell.Layout.row, cell.Layout.column)
        }
    }

    /************ FUNCTIONS ************/

    /*
     *  Resets the cell for another round: resets its background, clears 'x' or 'o',
     *  stops the animation, resets the zoom etc.
     */
    function reset() {
        state = CellState.unset
        resolved = false
        color = "transparent"
        animator.stop()
        scale = 1
    }

    function setAcceptInput(accept) {
        acceptInput = accept
    }

    function setNextState(symbol) {
        if(state === CellState.unset)
            nextState = symbol
    }

    function setResolved(isResolved) {
        resolved = isResolved
    }

    /*
     *  Draws the cell background and animates the winning result
     */
    function drawResolvedState() {
        color = resolved ? "#7700FF00" : "transparent"

        if(resolved)
            animator.start()
    }
}
