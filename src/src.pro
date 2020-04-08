TARGET = ut-visual-dbus
INSTALLS += target
target.path = /usr/bin

CONFIG += c++11

QT += quick qml dbus

SOURCES += \
    cpp/dbusserviceinspector.cpp \
    cpp/interfacemember.cpp \
    cpp/argument.cpp \
    cpp/dbusutil.cpp \
    cpp/ut-visual-dbus.cpp

OTHER_FILES += \
    qml/ut-visual-dbus.qml \
    qml/pages/MainPage.qml \
    qml/pages/ServicePathsListPage.qml \
    qml/pages/FailedToRecieveServicesDialog.qml \
    qml/pages/ServiceInterfacesListPage.qml \
    qml/pages/InterfaceMembersPage.qml \
    qml/pages/MethodCallPage.qml \
    qml/pages/PropertyPage.qml \
    translations/*.ts

HEADERS += \
    cpp/dbusserviceinspector.h \
    cpp/interfacemember.h \
    cpp/argument.h \
    cpp/dbusutil.h

RESOURCES += \
    qml.qrc
