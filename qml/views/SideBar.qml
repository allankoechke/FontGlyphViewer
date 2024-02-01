import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import '../delegates'
import '../controls'

Item {
    id: root

    Connections {
        target: fontModel

        function onCountChanged() {
            filterModel(input.text)
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        TextField {
            id: input
            Layout.preferredWidth: parent.width * 0.9
            Layout.preferredHeight: 40
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 8
            placeholderText: qsTr('Search Font')
            leftPadding: 20
            rightPadding: 20
            color: theme.secondaryText
            background: Rectangle {
                color: 'transparent'
                radius: height/2
                border.width: 1
                border.color: activeFocus ? theme.primaryAccent : theme.lightBorder
            }

            onTextChanged: filterModel(text)
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: theme.lightBorder
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: !lv.visible

            Column {
                anchors.centerIn: parent
                spacing: 20

                FgvIcon {
                    iconSize: 36
                    iconSource: '\ue691'
                    color: theme.secondaryText
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: input.text.trim()==='' ? qsTr('No Font Added') : qsTr('No Search Match')
                    font.pixelSize: 24
                    color: theme.secondaryText
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        ListView {
            id: lv
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: fontModelFiltered
            visible: model.count > 0
            spacing: 4
            clip: true
            delegate:  SideBarDelegate {
                id: sideBarDelegate

                property ListModel glyphs: model.glyphs

                name: model.name
                selected: name===selectedFontFamily

                onClicked: {
                    glyphsModel.clear()
                    for(var i=0; i<glyphs.count; i++)
                    {
                        glyphsModel.append(glyphs.get(i))
                    }
                    selectedFontFamily=name
                }
            }

            ScrollBar.vertical: ScrollBar {
                id: scrollbar
                active: lv.moving || lv.flicking
                policy: ScrollBar.AsNeeded

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
                    Behavior on opacity { NumberAnimation {} }
                }
            }
        }
    }
}
