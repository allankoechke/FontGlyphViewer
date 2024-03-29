import QtQuick 2.15
import '../controls'

Item {
    id: root
    width: lv.width
    height: 40

    property string name: ''
    property bool selected: false

    signal clicked()

    Rectangle {
        height: parent.height
        width: parent.width * 0.9
        color: selected ? theme.darkBorder : 'transparent'
        anchors.centerIn: parent
        border.width: selected ? 0 : 1
        border.color: theme.darkBorder
        radius: 8

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: angleIcon.left
            leftPadding: 10
            rightPadding: 5
            elide: Text.ElideRight
            color: root.selected ? theme.primaryText : theme.secondaryText
            text: name
        }

        FgvIcon {
            id: angleIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            iconSize: 12
            color: selected ? theme.primaryText : theme.secondaryText
            iconSource: '\ue09c'
            rightPadding: 10
        }

        MouseArea {
            anchors.fill: parent
            onClicked: root.clicked()
        }
    }
}
