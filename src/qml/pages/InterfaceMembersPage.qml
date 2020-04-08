import QtQuick 2.2
import QtQuick.Controls 2.0
import harbour.visual.dbus.dbusinspector 1.0
import harbour.visual.dbus.interfacemember 1.0
import harbour.visual.dbus.argument 1.0

Page {
    property string serviceName: ""
    property string servicePath: value
    property string serviceInterface: value
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

    Label {
        id: currentInterface
        text: 'Interface: ' + serviceInterface
        font.pixelSize: Theme.fontSizeLarge
        anchors {
            top: currentPath.bottom
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
            top: currentInterface.bottom
        }
    }

    Component {
        id: sectionHeading
        Text {
            text: section
            font.bold: true
            font.pixelSize: 20
        }
    }

    ListView {
        id: membersListView
        anchors {
            top: separator.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }
        clip: true
        spacing: 0
        model: dbusInspector.getInterfaceMembers(serviceName, servicePath, serviceInterface, isSystemBus)
        delegate: MouseArea {
            id: listItem
            width: parent.width
            height: label.contentHeight
            //contentHeight: label.contentHeight + Theme.paddingLarge
            Label {
                id: label
                text: modelDataToString(modelData)
                anchors {
                    fill: parent
                    leftMargin: Theme.horizontalPageMargin * 1.5
                    rightMargin: Theme.horizontalPageMargin * 1.5
                }
                wrapMode: Text.Wrap
                verticalAlignment: Text.AlignVCenter
                color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                if (modelData.kind === "method")
                    pageStack.push("qrc:/qml/pages/MethodCallPage.qml", { "serviceName": serviceName,
                                       "servicePath": servicePath, "interfaceName": serviceInterface,
                                       "method": modelData, "isSystemBus": isSystemBus});
                else if (modelData.kind === "property")
                    pageStack.push("qrc:/qml/pages/PropertyPage.qml", { "serviceName": serviceName,
                                       "servicePath": servicePath, "interfaceName": serviceInterface,
                                       "property": modelData, "isSystemBus": isSystemBus});
            }
        }
        section {
            property: "modelData.kind"
            criteria: ViewSection.FullString
            delegate: Label {
                text: section
            }
        }
    }

    function modelDataToString(modelData) {
        var text = "";
        text += modelData.type !== "" ? modelData.type + " " : "";
        text += modelData.name;
        text += modelData.access !== "" ? "(" + modelData.access + ") " : "";
        var args = [];
        if(modelData.kind === "method") {
            for(var i = 0; i < modelData.inputArguments.length; i++) {
                args.push(modelData.inputArguments[i].type + " " + modelData.inputArguments[i].name);
            }
            text += "(" + args.join(", ") + ") -> ";
        }
        args = [];
        if(modelData.kind !== "property") {
            for(i = 0; i < modelData.outputArguments.length; i++) {
                args.push(modelData.outputArguments[i].type + " " + modelData.outputArguments[i].name);
            }
            text += "(" + args.join(", ") + ")";
        }
        return text;
    }
}
