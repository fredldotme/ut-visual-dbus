import QtQuick 2.2
import QtQuick.Controls 2.0
import harbour.visual.dbus.dbusinspector 1.0

Page {
    property string serviceName: ""
    property string servicePath: value
    property bool isSystemBus: true

    DBusInspector {
        id: dbusInspector
    }

    /*PageHeader {
        id: header
        anchors.top: parent.top
    }*/

    Label {
        id: currentPath
        text: 'Path: ' + servicePath
        font.pixelSize: Theme.fontSizeLarge
        anchors {
            top: parent.top
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
        }
        wrapMode: Text.Wrap
    }

    Rectangle {
        id: separator
        height: 3
        width: parent.width
        color: Theme.highlightColor
        anchors {
            top: currentPath.bottom
        }
    }

    Label {
        id: listHeader
        text: interfacesListView.model.length === 0 ? 'No interfaces available for this path.' : 'Interfaces:'
        font.pixelSize: Theme.fontSizeLarge
        font.underline: interfacesListView.model.length !== 0
        anchors {
            top: separator.bottom
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
        }
        wrapMode: Text.Wrap
    }

    ListView {
        id: interfacesListView
        anchors {
            top: listHeader.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }
        model: dbusInspector.getInterfacesList(serviceName, servicePath, isSystemBus)
        delegate: MouseArea {
            id: listItem
            width: parent.width
            height: label.contentHeight
            Label {
                id: label
                text: modelData
                anchors {
                    fill: parent
                    margins: Theme.horizontalPageMargin * 1.5
                }
                font.pixelSize: appWindow.fontSizeMedium
                wrapMode: Text.Wrap
                verticalAlignment: Text.AlignVCenter
                color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                pageStack.push("qrc:/qml/pages/InterfaceMembersPage.qml",
                               {"serviceName": serviceName, "servicePath": servicePath,
                                   "serviceInterface": modelData, "isSystemBus": isSystemBus});
            }
        }
    }
}
