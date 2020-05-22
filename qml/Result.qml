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

/*
 *  Label with results of the current game: draw, win, or a round number
 */
ResultForm {
    // round number
    property int round: 0
    // won player
    property string winPlayer

    id: result

    states: [
        State {
            name: "win"
            PropertyChanges { target: result; color: "green"; text: qsTr("%1 WINS").arg(winPlayer) }
        },
        State {
            name: "draw"
            PropertyChanges { target: result; color: "darkCyan"; text: qsTr("DRAW") }
        },
        State {
            name: "newround"
            PropertyChanges { target: result; color: "black"; text: qsTr("Round: %1").arg(round) }
        }
    ]

    /************ FUNCTIONS ************/

    function setWin(player) {
        winPlayer = player
        state = "win"
    }

    function setDraw() {
        state = "draw"
    }

    function newRound() {
        round++;
        state = "newround"
    }
}
