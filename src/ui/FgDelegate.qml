import QtQuick

Item {
    id: root
    width: fontgrid.size
    height: width

    property string iconGlyph

    signal clicked

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 4
        color: '#ccc'

        Text {
            text: String.fromCharCode(parseInt(iconGlyph, 16))
            font.pixelSize: 28
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            anchors.top: parent.top
            anchors.bottom: copyrect.top
            font.family: app.fontFamily
        }

        Rectangle {
            id: copyrect
            height: 30
            width: parent.width
            color: '#bbb'
            anchors.bottom: parent.bottom

            Text {
                text: '\\u' + iconGlyph
                font.pixelSize: 12
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // Copy to clipboard
                    fontGlyphLoader.copyToClipboard('\\u' + iconGlyph);
                }
            }
        }
    }
}

