import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import "qrc:/qml/pages"

ApplicationWindow
{
    id: appWindow
    visible: true

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("‹")
                onClicked: pageStack.pop()
                enabled: pageStack.depth > 0
            }
            Label {
                text: pageStack.currentItem.title
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
        }
    }

    readonly property int fontSizeMedium : 32

    StackView {
        id: pageStack
        anchors.fill: parent
        initialItem: MainPage { }
    }
}
