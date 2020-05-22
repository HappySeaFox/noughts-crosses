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

Item {
    width: 160
    height: 160
    readonly property alias grid: grid

    Grid {
        id: grid
        anchors.fill: parent
        rows: 3
        columns: 3
        spacing: 2

        Cell {
            Layout.row: 0
            Layout.column: 0
        }
        Cell {
            Layout.row: 0
            Layout.column: 1
        }
        Cell {
            Layout.row: 0
            Layout.column: 2
        }

        Cell {
            Layout.row: 1
            Layout.column: 0
        }
        Cell {
            Layout.row: 1
            Layout.column: 1
        }
        Cell {
            Layout.row: 1
            Layout.column: 2
        }

        Cell {
            Layout.row: 2
            Layout.column: 0
        }
        Cell {
            Layout.row: 2
            Layout.column: 1
        }
        Cell {
            Layout.row: 2
            Layout.column: 2
        }
    }
}
