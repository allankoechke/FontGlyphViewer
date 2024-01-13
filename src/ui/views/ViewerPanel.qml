import QtQuick
import QtQuick.Controls

import '../controls'
import '../delegates'

Item {
    id: root

    Column {
        anchors.centerIn: parent
        spacing: 20
        visible: !fontgrid.visible

        FgvIcon {
            iconSize: 56
            iconSource: '\ue691'
            color: theme.secondaryText
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: qsTr('No font selected')
            font.pixelSize: 24
            color: theme.secondaryText
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Item {
        anchors.fill: parent

        Item {
            id: fontInfoItem
            height: 67
            width: parent.width
            anchors.top: parent.top
            anchors.left: parent.left

            Rectangle {
                width: parent.width
                height: 1
                color: theme.darkBorder
                anchors.bottom: parent.bottom
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                color: selectedFontFamily==='' ? theme.disabledInteractive : theme.primaryText
                text: selectedFontFamily==='' ? "None Selected" : selectedFontFamily
            }

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                spacing: 2

                FgvButton {
                    height: width
                    enabled: selectedFontFamily!==''
                    anchors.verticalCenter: parent.verticalCenter
                    leftIcon: '\uf815'
                    textColor: enabled ? theme.primaryText : theme.disabledInteractive
                    buttonType: FgvButton.Text
                    buttonIconType: FgvButton.LeftOnly
                    onClicked: {
                        // Give information about the font
                    }
                }

                FgvButton {
                    height: width
                    enabled: selectedFontFamily!==''
                    anchors.verticalCenter: parent.verticalCenter
                    leftIcon: '\ue312'
                    textColor: enabled ? theme.primaryText : theme.disabledInteractive
                    buttonType: FgvButton.Text
                    buttonIconType: FgvButton.LeftOnly
                    onClicked: {
                        // Clear Selected Font
                        selectedFontFamily=''
                        glyphsModel.clear()
                    }
                }

                FgvButton {
                    height: width
                    enabled: selectedFontFamily!==''
                    anchors.verticalCenter: parent.verticalCenter
                    leftIcon: '\ue1b9'
                    textColor: enabled ? theme.tertiaryAccent : theme.disabledInteractive
                    buttonType: FgvButton.Text
                    buttonIconType: FgvButton.LeftOnly
                    onClicked: removeFontGlyph(selectedFontFamily)
                }
            }
        }

        GridView {
            id: fontgrid
            anchors.top: fontInfoItem.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            visible: model.count!==0
            clip: true
            model: glyphsModel
            cellHeight: fontgrid.size
            cellWidth: fontgrid.size

            property real size: width/Math.round(width/100) // Get cellwidth based on dimension of the window

            delegate: ViewerDelegate {
                iconGlyph: glyph
                onClicked: {
                    fgpopup.glyph = iconGlyph
                    fgpopup.glyphFamily = selectedFontFamily
                    fgpopup.open()
                }
            }

            ScrollBar.vertical: ScrollBar {
                id: scrollbar
                active: fontgrid.moving || fontgrid.flicking
                policy: ScrollBar.AlwaysOn

                background: Rectangle {
                    width: 12
                    height: parent.height
                    color: Qt.rgba(0,0,0,0.6)
                    radius: width/2
                }

                contentItem: Rectangle {
                    implicitWidth: 8
                    implicitHeight: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    radius: width / 2
                    color: scrollbar.pressed ? "#fff" : Qt.rgba(1,1,1,0.6)
                    opacity: scrollbar.policy === ScrollBar.AlwaysOn || (scrollbar.active && scrollbar.size < 1.0) ? 0.75 : 0

                    // Animate the changes in opacity (default duration is 250 ms).
                    Behavior on opacity {
                        NumberAnimation {}
                    }
                }
            }

        }
    }
}
