import QtQuick
import QtQuick.Controls

Button {
    id: root
    width: _rbtn.width + 30
    implicitHeight: 30

    property string color: theme.primaryAccent
    property alias radius: bg.radius

    background: Rectangle {
        id: bg
        radius: height/2
        color: root.down ? Qt.lighter(root.color) : root.color
        border.width: 0
        border.color: theme.primaryText
    }

    contentItem: Item {
        anchors.fill: parent

        Row {
            id: _rbtn
            anchors.centerIn: parent

            Text {
                text: root.text
                font.pixelSize: 14
                color: theme.primaryText
            }
        }
    }
}
