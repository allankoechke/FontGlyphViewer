import QtQuick
import QtCore
import QtQuick.Dialogs

Window {
    id: app
    width: 640
    height: 480
    visible: true
    title: qsTr("Font Glyph Loader")

    property ListModel fontModel: ListModel{}
    property string fontFamily

    Connections {
        target: fontGlyphLoader

        function onFontLoadError(error) {
            console.log("Font Loading Error")
        }

        function onFontLoadingFinished(fontMap) {
            // console.log(JSON.stringify(fontMap))

            var glyphs = fontMap['glyphs']
            fontFamily = fontMap['family']

            fontModel.clear()
            for(var i=0; i<glyphs.length; i++) {
                fontModel.append({'glyph': glyphs[i]})
            }
        }

        function onCopiedToClipboard() {
            console.log('Copied to clipboard')
        }
    }

    Rectangle {
        id: topbar
        height: 50
        width: parent.width
        anchors.top: parent.top
        color: '#ccc'

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            radius: 8
            color: 'grey'
            width: _rbtn.width + 20
            height: parent.height - 10

            Row {
                id: _rbtn
                anchors.centerIn: parent

                Text {
                    text: qsTr("Open")
                    font.pixelSize: 16
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: { fileDialog.open() }
            }
        }
    }

    GridView {
        id: fontgrid
        anchors {
            top: topbar.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            topMargin: 10
            bottomMargin: 10
        }
        clip: true
        model: fontModel
        cellHeight: 100
        cellWidth: 100
        delegate: Item {
            id: glyphdelegate
            width: fontgrid.cellWidth
            height: fontgrid.cellHeight

            property string iconGlyph: glyph

            Rectangle {
                anchors.fill: parent
                anchors.margins: 4
                color: '#ccc'

                Text {
                    text: String.fromCharCode(parseInt(glyphdelegate.iconGlyph, 16))
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
                        text: '\\u' + glyphdelegate.iconGlyph
                        font.pixelSize: 12
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            // Copy to clipboard
                            fontGlyphLoader.copyToClipboard('\\u' + glyphdelegate.iconGlyph);
                        }
                    }
                }
            }
        }
    }

    FileDialog {
        id: fileDialog
        currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
        nameFilters: ["Font files (*.ttf *.otf)"]
        onAccepted: {
            // console.log(selectedFile)
            fontGlyphLoader.loadFont(selectedFile)
        }
    }
}
