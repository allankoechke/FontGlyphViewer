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
        color: theme.secondaryBackground

        Text {
            text: String.fromCharCode(parseInt(iconGlyph, 16))
            font.pixelSize: 28
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            anchors.top: parent.top
            anchors.bottom: copyrect.top
            font.family: app.fontFamily
            color: theme.secondaryText
        }

        Rectangle {
            id: copyrect
            height: 30
            width: parent.width
            color: theme.tertiaryBackground
            anchors.bottom: parent.bottom

            Rectangle {
                id: indicator
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                color: theme.primaryAccent
                visible: clickedAnimation.running
            }

            Text {
                text: '\\u' + iconGlyph
                font.pixelSize: 12
                anchors.centerIn: parent
                color: theme.secondaryText
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // Copy to clipboard
                    fontGlyphLoader.copyToClipboard('\\u' + iconGlyph);
                    clickedAnimation.start()
                }
            }

            ParallelAnimation {
                id: clickedAnimation

                NumberAnimation {
                    target: indicator
                    from: 0; to: copyrect.width
                    duration: 200
                    properties: 'width'
                }
            }
        }
    }
}

