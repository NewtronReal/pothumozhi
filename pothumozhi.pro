TEMPLATE = app
QT += gui quick
INCLUDEPATH += .
DEFINES += QT_DEPRECATED_WARNINGS
SOURCES += main.cpp \
    cpp-sources/Integrations.cpp
RESOURCES += qml.qrc

HEADERS += \
    cpp-headers/Integrations.h

DISTFILES +=
