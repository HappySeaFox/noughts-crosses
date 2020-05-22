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

#include <QtGui>
#include <QtQml>

/*
 *  Noughts and Crosses game
 *
 *  Main UI: main.qml
 *
 *  +-----------------------------+
 *  |          |       |          |
 *  | Player 1 | Board | Player 2 |
 *  |          |       |          |
 *  +-----------------------------+
 *
 *  The main UI and the Board (mainly) control the game.
 *
 *  Game process:
 *
 *  Player #1 (Player.qml) selects a cell. The Board checks if the player has built a line.
 *  If yes, it displays a 'win' message, increments the game score, and starts another round. If not, it
 *  passes the control to the Player #2.
 */
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));

    if(engine.rootObjects().isEmpty())
        return 1;

    return app.exec();
}
