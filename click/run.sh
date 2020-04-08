#!/bin/sh

export LD_LIBRARY_PATH=$PWD/usr/lib:$LD_LIBRARY_PATH

if [ -d $PWD/usr/lib/arm-linux-gnueabihf/qt5/qml ]; then
    export QML2_IMPORT_PATH=$QML2_IMPORT_PATH:$PWD/usr/lib/arm-linux-gnueabihf/qt5/qml
fi

if [ -d $PWD/usr/lib/aarch64-linux-gnu/qt5/qml ]; then
    export QML2_IMPORT_PATH=$QML2_IMPORT_PATH:$PWD/usr/lib/aarch64-linux-gnu/qt5/qml
fi

if [ -d $PWD/usr/lib/x86_64-linux-gnu/qt5/qml ]; then
    export QML2_IMPORT_PATH=$QML2_IMPORT_PATH:$PWD/usr/lib/x86_64-linux-gnu/qt5/qml
fi

exec $PWD/usr/bin/ut-visual-dbus \
    --desktop_file_hint=${HOME}/.local/share/applications/${APP_ID}.desktop "$@"
