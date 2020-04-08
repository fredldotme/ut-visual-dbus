import QtQuick 2.2
import QtQuick.Controls 2.0
import harbour.visual.dbus.dbusinspector 1.0


Page {
    property string serviceName: ""
    property bool isSystemBus: true
    title: ""

    DBusInspector {
        id: dbusInspector
    }

    Label {
        id: listHeader
        text: pathsListView.model.length === 0 ? 'No paths available for this service.' : 'Paths:'
        //font.pixelSize: Theme.fontSizeLarge
        font.underline: pathsListView.model.length !== 0
        anchors {
            top: parent.top
            left: parent.left
            //leftMargin: Theme.horizontalPageMargin
            right: parent.right
            //rightMargin: Theme.horizontalPageMargin
        }
        wrapMode: Text.Wrap
    }

    ListView {
        id: pathsListView
        anchors {
            top: listHeader.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }
        spacing: 0
        clip: true
        model: dbusInspector.getPathsList(serviceName, isSystemBus)
        delegate: MouseArea {
            id: listItem
            width: parent.width
            height: label.contentHeight
            //contentHeight: label.contentHeight
            Label {
                id: label
                text: modelData
                anchors {
                    fill: parent
                    //leftMargin: Theme.horizontalPageMargin * 1.5
                    //rightMargin: Theme.horizontalPageMargin * 1.5
                }
                font.pixelSize: appWindow.fontSizeMedium
                wrapMode: Text.Wrap
                verticalAlignment: Text.AlignVCenter
                //color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                pageStack.push("qrc:/qml/pages/ServiceInterfacesListPage.qml",
                               {"serviceName": serviceName, "servicePath": modelData, "isSystemBus": isSystemBus});
            }
        }
    }
}
