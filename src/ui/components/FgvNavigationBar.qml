import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import '../controls'

Item {
    id: topbar
    height: 50
    width: parent.width*0.95
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    signal backButtonClicked()

    Rectangle {
        height: 1; width: app.width
        anchors.bottom: parent.bottom
        color: theme.lightBorder
        anchors.horizontalCenter: parent.horizontalCenter
    }

    RowLayout {
        anchors.fill: parent
        spacing: 8
        anchors.margins: 4

        FgvButton {
            id: backBtn
            visible: isMobileScreen
            Layout.fillHeight: true
            Layout.preferredWidth: height
            leftIcon: theme.backArrowIcon
            textColor: theme.primaryText
            buttonType: FgvButton.Text
            buttonIconType: FgvButton.LeftOnly

            onClicked: topbar.backButtonClicked()
        }

        Text {
            id: selectedFontName
            text: "Font Glyph Viewer"
            font.pixelSize: 16
            color: theme.primaryText
            Layout.fillWidth: true
            Layout.fillHeight: true
            verticalAlignment: Text.AlignVCenter
        }

        Row {
            spacing: 8
            Layout.fillHeight: true

            FgvButton {
                text: qsTr('Add')
                onClicked: fileDialog.open()
                anchors.verticalCenter: parent.verticalCenter
                leftIcon: theme.addIconRoundOutlined
                textColor: theme.primaryText
                buttonType: FgvButton.Filled
                buttonIconType: FgvButton.LeftAndText
            }
        }
    }
}

