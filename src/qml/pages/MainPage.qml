import QtQuick 2.2
import QtQuick.Controls 2.0
import Nemo.DBus 2.0

Page {
    property variant sessionServices
    property variant systemServices
    property bool isSessionServices: switchButton.checked

    id: page
    title: qsTr("Visual D-Bus")

    Component.onCompleted: {
        dbusList.typedCall('ListNames', undefined,
                           function(result) {
                               sessionServices = result.filter(function(value) {return value[0] !== ':'}).sort();
                           }, function() {
                               pageStack.push(Qt.resolvedUrl("qrc:/qml/pages/FailedToRecieveServicesDialog.qml"));
                           });
        dbusList.bus = DBus.SystemBus;
        dbusList.typedCall('ListNames', undefined,
                           function(result) {
                               systemServices = result.filter(function(value) {return value[0] !== ':'}).sort();
                           }, function() {
                               pageStack.push(Qt.resolvedUrl("qrc:/qml/pages/FailedToRecieveServicesDialog.qml"));
                           });
    }

    DBusInterface {
        id: dbusList
        service: 'org.freedesktop.DBus'
        path: '/org/freedesktop/DBus'
        iface: 'org.freedesktop.DBus'
        bus: DBus.SessionBus
    }

    ListView {
        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
            bottom: switchButton.top
        }
        clip: true
        model: isSessionServices ? sessionServices : systemServices
        //spacing: Theme.paddingSmall
        delegate: MouseArea {
            id: listItem
            height: serviceNameLabel.contentHeight
            width: parent.width
            Label {
                id: serviceNameLabel
                wrapMode: Text.Wrap
                font.pixelSize: appWindow.fontSizeMedium
                anchors {
                    fill: parent
                    //margins: Theme.paddingLarge
                }
                verticalAlignment: Text.AlignVCenter
                text: isSessionServices ? sessionServices[index] : systemServices[index]
                //color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                pageStack.push("qrc:/qml/pages/ServicePathsListPage.qml",
                               {"serviceName": serviceNameLabel.text, "isSystemBus": !isSessionServices});
            }
        }
    }

    CheckBox {
        id: switchButton
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        text: "Bus: " + (isSessionServices ? "Session" : "System")
        checked: true
    }
}


