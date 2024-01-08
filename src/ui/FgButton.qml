import QtQuick

Rectangle {
    id: root
    radius: 8
    color: 'transparent'
    border.width: 1
    border.color: 'grey'
    width: _rbtn.width + 20
    implicitHeight: 30

    property string text: "Button"
    signal clicked

    Row {
        id: _rbtn
        anchors.centerIn: parent

        Text {
            text: root.text
            font.pixelSize: 14
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
