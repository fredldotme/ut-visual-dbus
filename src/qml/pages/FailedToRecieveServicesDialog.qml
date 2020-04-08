import QtQuick 2.2
import QtQuick.Controls 2.2

Dialog {

    Column {
        width: parent.width

        /*DialogHeader {
            acceptText: qsTr("Try again")
            cancelText: qsTr("Close")
        }*/

        Label {
            //font.weight: Theme.fontSizeLarge
            width: parent.width
            wrapMode: Text.WordWrap
            text: qsTr("Failed to recieve list of services. You can try again or close the application.")
        }
    }
    onRejected: Qt.quit();
    onAccepted: {
        pageStack.clear();
        pageStack.push("qrc:/qml/pages/MainPage.qml");
    }
}
