import QtQuick
import QtCore
import QtQuick.Dialogs

Window {
    id: app
    width: 640
    height: 480
    visible: true
    title: qsTr("Font Glyph Viewer")

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

    Item {
        id: topbar
        height: 50
        width: parent.width
        anchors.top: parent.top

        Rectangle {
            height: 1; width: parent.width
            anchors.bottom: parent.bottom
            color: 'silver'
        }

        Text {
            text: fontFamily==='' ? "Select a font (.otf, .ttf)" : "Font: " + fontFamily
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            font.pixelSize: 16
        }

        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            spacing: 8

            FgButton {
                visible: fontFamily!==''
                text: qsTr('Clear All')
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    fontFamily=''
                    fontModel.clear()
                }
            }

            FgButton {
                text: qsTr('Open')
                onClicked: fileDialog.open()
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Text {
        visible: fontModel.count===0 || fontFamily===''
        text: qsTr('No font item found!')
        font.pixelSize: 16
        anchors.centerIn: parent
    }

    GridView {
        id: fontgrid
        visible: fontModel.count!==0 || fontFamily!==''

        property real size: width/Math.round(width/100) // Get cellwidth based on dimension of the window

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
        cellHeight: fontgrid.size
        cellWidth: fontgrid.size
        delegate: FgDelegate {
            iconGlyph: glyph
            onClicked: {
                fgpopup.glyph = iconGlyph
                fgpopup.glyphFamily = fontFamily
                fgpopup.open()
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

    FgPopup {
        id: fgpopup
    }
}
