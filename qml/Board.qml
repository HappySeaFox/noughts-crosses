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
 *  Game board with 9 cells (Cell.qml). Controls the game process.
 *  When a player wins, it blocks mouse events and paints the winning cells.
 */
BoardForm {
    // cell cache for a fast access to cells by the x,y coordinates
    property var cellCache

    signal cellClicked
    signal victory
    signal draw

    id: board

    /************ HANDLERS ************/

    // initialize the cache & the component
    Component.onCompleted: {
        console.log("Init board")

        var gridChildren = grid.children

        if (!gridChildren)
            return

        cellCache = new Array(grid.rows)

        for (var i = 0; i < cellCache.length; i++) {
            cellCache[i] = new Array(grid.columns)
        }

        for (i = 0; i < gridChildren.length; i++) {
            var child = gridChildren[i]

            child.clicked.connect(onClicked)
            cellCache[child.Layout.row][child.Layout.column] = child
        }

        // recalculate the minimum component size
        minimumWidth
                = minimumHeight
                = Layout.preferredWidth
                = Layout.preferredHeight
                = cellCache[0].length * cellCache[0][0].width + grid.spacing * (cellCache[0].length - 1)
    }

    /*
     *  Cell (row,column) has been clicked. Check for a win/draw
     */
    function onClicked(row, column) {
        if(checkVictory(row, column))
            board.victory()
        else if(checkDraw())
            board.draw()
        else
            // tell the app about this regular click
            board.cellClicked()
    }


    /************ FUNCTIONS ************/

    function cellsRows() {
        return board.cellCache
    }

    function cellsRow(i) {
        return board.cellCache[i]
    }

    function cell(i, j) {
        return board.cellCache[i][j]
    }

    /*
     *  check*() functions check the currenly clicked cell for a victory
     *  of the current player and marks the required cells (in a row, a column, or a diagonal)
     *  for the further result painting. If the current player wins, we use these markers to
     *  paint the winning row/column/diagonal in Cell.qml (see drawResolvedState()).
     *  check*() functions return 'true' if the current player wins.
     */

    /*
     *         column
     *            ↓
     *         |o| | |
     *  row -> |x|x|x| <- checks this row and marks its cells
     *         | | |o|
     */
    function checkVictoryRow(row, column) {
        resetResolvedStates()

        console.log("Check victory row")

        var lastSymbol = cell(row, 0).state

        for(var i = 0; i < cellsRow(row).length; i++)
        {
            if(lastSymbol !== cell(row, i).state)
                return false

            // mark this cell as a possible result in a horizontal direction
            cell(row, i).setResolved(true)
        }

        return true
    }

    /*
     *         column
     *            ↓
     *         |o|x| |
     *  row -> | |x| |
     *         | |x|o|
     *            ↑
     *    checks this column
     *    and marks its cells
     */
    function checkVictoryColumn(row, column) {
        resetResolvedStates()

        console.log("Check victory column")

        var lastSymbol = cell(0, column).state

        for(var i = 0; i < cellsRows().length; i++)
        {
            if(lastSymbol !== cell(i, column).state)
                return false

            // mark this cell as a possible result in a vertical direction
            cell(i, column).setResolved(true)
        }

        return true
    }

    /*
     *  checks this diagonal
     *  and marks its cells
     *        ↘
     *         |x|o| |
     *         | |x| |
     *         | |o|x|
     *
     */
    function checkVictoryTopLeftBottomRight(row, column) {
        if(row !== column)
            return false

        console.log("Check diagonal 1")

        resetResolvedStates()

        var lastSymbol = cell(0, 0).state

        for(var i = 0, j = 0; i < cellsRows().length; i++, j++)
        {
            if(cell(i, j).state === CellState.unset)
                return false

            if(lastSymbol !== cell(i, j).state)
                return false

            // mark this cell as a possible result in a diagonal direction
            cell(i, j).setResolved(true)
        }

        return true
    }

    /*
     *        checks this diagonal
     *        and marks its cells
     *                ↙
     *         | |o|x|
     *         | |x| |
     *         |x|o| |
     *
     */
    function checkVictoryTopRightBottomLeft(row, column) {
        if(row !== column)
            return false

        console.log("Check diagonal 2")

        resetResolvedStates()

        var lastSymbol = cell(0, cellsRow(0).length-1).state

        for(var i = 0, j = cellsRow(0).length-1; j >= 0; i++, j--)
        {
            if(cell(i, j).state === CellState.unset)
                return false

            if(lastSymbol !== cell(i, j).state)
                return false

            // mark this cell as a possible result in a diagonal direction
            cell(i, j).setResolved(true)
        }

        return true
    }

    /*
     *  Checks if nobody wins. Returns 'true' if we need to restart the game, e.g. when no
     *  free cells left and nobody wins.
     */
    function checkDraw() {
        for(var i = 0; i < cellsRows().length; i++)
        {
            for(var j = 0; j < cellsRow(i).length; j++)
            {
                // there are free cells, so the game is not over
                if(cell(i, j).state === CellState.unset)
                    return false
            }
        }

        return true
    }

    /*
     *  Checks if the currently selected cell wins
     */
    function checkVictory(row, column) {
        console.log("Check victory " + row + "," + column)

        /*
         *  1) check the row containing the currently selected cell
         *  2) check the column containing the currently selected cell
         *  3) check both diagonals
         */
        var isVictory = checkVictoryRow(row, column)
                        || checkVictoryColumn(row, column)
                        || checkVictoryTopLeftBottomRight(row, column)
                        || checkVictoryTopRightBottomLeft(row, column)

        /*
         *  Draws the marked winning cells
         */
        if(isVictory)
            drawResolvedCells()

        return isVictory;
    }

    function drawResolvedCells() {
        console.log("Draw resolved")

        for(var i = 0; i < cellsRows().length; i++)
        {
            for(var j = 0; j < cellsRow(i).length; j++)
            {
                cell(i, j).drawResolvedState()
            }
        }
    }

    /*
     *  Resets all the marked cells
     */
    function resetResolvedStates() {
        for(var i = 0; i < cellsRows().length; i++)
        {
            for(var j = 0; j < cellsRow(i).length; j++)
            {
                cell(i, j).setResolved(false)
            }
        }
    }

    /*
     *  Resets the board for a new game
     */
    function reset() {
        for(var i = 0; i < cellsRows().length; i++)
        {
            for(var j = 0; j < cellsRow(i).length; j++)
            {
                cell(i, j).reset()
            }
        }

        setAcceptInput(true)
    }

    /*
     *  Sets the currently expected symbol: 'x' or 'o'
     */
    function setNextSymbolForCells(symbol) {
        console.log("Next symbol: " + symbol)

        for(var i = 0; i < cellsRows().length; i++)
        {
            for(var j = 0; j < cellsRow(i).length; j++)
            {
                cell(i, j).setNextState(symbol)
            }
        }
    }

    /*
     *  When a player wins, we block mouse events until the next round
     */
    function setAcceptInput(accept) {
        for(var i = 0; i < cellsRows().length; i++)
        {
            for(var j = 0; j < cellsRow(i).length; j++)
            {
                cell(i, j).setAcceptInput(accept)
            }
        }
    }
}
