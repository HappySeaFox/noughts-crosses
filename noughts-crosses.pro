TEMPLATE = app
TARGET = noughts-crosses

QT += qml
CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x050000 # disables all the APIs deprecated before Qt 5.0.0

SOURCES += main.cpp

HEADERS +=

RESOURCES += noughts-crosses.qrc

QML_IMPORT_PATH =
QML_DESIGNER_IMPORT_PATH =
