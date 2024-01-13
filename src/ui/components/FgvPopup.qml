import QtQuick
import QtQuick.Controls

import '../controls'

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
        color: theme.primaryBackground
    }

    contentItem: Item {
        anchors.fill: parent
        anchors.margins: 8

        Item {
            anchors.top: parent.top
            anchors.bottom: copybtn.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottomMargin: 8

            Text {
                anchors.centerIn: parent
                font.pixelSize: Math.min(parent.width, parent.height)*0.8
                font.family: glyphFamily
                color: theme.primaryText
                text: String.fromCharCode(parseInt(glyph, 16))
            }
        }

        FgvButton {
            id: copybtn
            text: `Copy '\\u${glyph}'`
            onClicked: fontGlyphLoader.copyToClipboard('\\u' + glyph);
            anchors.bottom: parent.bottom
            width: parent.width
        }
    }
}
