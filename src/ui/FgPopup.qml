import QtQuick
import QtQuick.Controls

Popup {
    id: root
    width: 200
    height: 200
    x: (parent.width-width)/2
    y: (parent.height-height)/2
    modal: true

    property string glyph
    property string glyphFamily

    background: Rectangle {
        radius: 8
    }

    contentItem: Item {
        anchors.fill: parent
        anchors.margins: 16

        Row {
            anchors.top: parent.top
            anchors.right: parent.right
            spacing: 8

            Text {
                text: glyph
                font.pixelSize: 14
                anchors.verticalCenter: parent.verticalCenter
            }

            FgButton {
                text: qsTr('Copy')
                anchors.verticalCenter: parent.verticalCenter
                onClicked: fontGlyphLoader.copyToClipboard('\\u' + glyph);
            }
        }

        Text {
            anchors.centerIn: parent
            font.pixelSize: 48
            font.family: glyphFamily
            text: String.fromCharCode(parseInt(glyph, 16))
        }
    }
}
