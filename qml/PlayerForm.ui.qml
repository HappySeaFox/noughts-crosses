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

Rectangle {
    id: item1
    property alias name: name.text
    property alias score: score.text
    property alias avatar: avatar.source
    property alias message: message.text

    property string symbol

    width: 160
    height: 200

    ColumnLayout {
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Item {
            Layout.fillHeight: true
        }

        Text {
            id: name
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Item {
            Layout.fillHeight: true
        }

        RowLayout {
            Item {
                Layout.fillWidth: true
            }
            Image {
                id: avatar
                antialiasing: true
                Layout.preferredWidth: 96
                Layout.preferredHeight: 96
                fillMode: Image.PreserveAspectFit
            }
            Item {
                Layout.fillWidth: true
            }
        }

        Item {
            Layout.fillHeight: true
        }

        Text {
            id: scoreLabel
            text: qsTr("SCORE:")
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 14
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: score
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.Bold
            font.pointSize: 16
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: message
            color: "green"
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.Bold
            fontSizeMode: Text.VerticalFit
            font.pointSize: 10
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
