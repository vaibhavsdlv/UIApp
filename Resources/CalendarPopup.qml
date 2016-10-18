import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: dialogComponent
    anchors.fill: parent

    // This rectange is the a overlay to partially show the parent through it
    // and clicking outside of the 'dialog' popup will do 'nothing'
    Rectangle {
        anchors.fill: parent
        id: overlay
        color: "#000000"
        opacity: 0.6
        // add a mouse area so that clicks outside
        // the dialog window will not do anything
        MouseArea {
            anchors.fill: parent
        }
    }
    Calendar {
        id: calendarPopUp
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        onClicked: {
            _ESApplication.trxDateTime = date
            btnDtTm.text = _ESApplication.trxDateTime
            dialogComponent.destroy()
        }
    }
}
