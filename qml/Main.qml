import QtQuick.Window 2.15
import QtQuick 2.15
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.platform 1.1

import 'views'
import 'components'

Window {
    id: app
    width: 1080
    height: 720
    visible: true
    color: theme.primaryBackground
    title: qsTr("Font Glyph Viewer")

    property bool isMobileScreen: width<=600
    property ListModel fontModel: ListModel{}
    property ListModel glyphsModel: ListModel{}
    property ListModel fontModelFiltered: ListModel{}
    property Theme theme: Theme{}
    property ListElement currentFont
    property FgvPopup fgpopup: FgvPopup{}

    property string selectedFontFamily: ''

    // signal backButtonClicked()

    FgvNavigationBar {
        id: topbar

        // onBackButtonClicked: app.backButtonClicked()
    }

    Item {
        anchors.top: topbar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        RowLayout {
            anchors.fill: parent
            spacing: 0

            SideBar {
                id: sideBar
                Layout.fillHeight: true
                Layout.preferredWidth: Math.min(parent.width/4, 300)
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: 1
                color: theme.lightBorder
            }

            ViewerPanel {
                id: fontViewer
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    FileDialog {
        id: fileDialog
        folder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
        nameFilters: ["Font files (*.ttf *.otf)"]
        onAccepted: {
            fontGlyphLoader.loadFont(file)
        }
    }

    Connections {
        target: fontGlyphLoader

        function onFontLoadError(error) {
            console.log("Font Loading Error")
        }

        function onFontLoadingFinished(fontMap) {
            var glyphs = fontMap['glyphs'];
            var family = fontMap['family'];
            var glyphsArray = [];

            if(!isMobileScreen) {
                glyphsModel.clear()
                selectedFontFamily=family
            }

            for(var i=0; i<glyphs.length; i++) {
                glyphsArray.push({'glyph': glyphs[i]})
                if(!isMobileScreen) {
                    glyphsModel.append({'glyph': glyphs[i]})
                }
            }

            fontModel.append({'name': family, 'glyphs': glyphsArray})

        }

        function onCopiedToClipboard() {
            // console.log('Copied to clipboard')
        }
    }

    function removeFontGlyph(family) {

        for(var i=0; i<fontModel.count; i++) {
            var font = fontModel.get(i)
            if(font.name===family) {
                fontModel.remove(i)
                glyphsModel.clear();
                selectedFontFamily=''
                console.log(glyphsModel.count, fontModel.count)
                break
            }
        }
    }

    function filterModel(text) {
        text = text.toString().trim().toLowerCase()
        fontModelFiltered.clear()

        if(text==='')
        {
            for(var i=0; i<fontModel.count; i++)
            {
                var obj = fontModel.get(i);
                fontModelFiltered.append({'name': obj.name, 'glyphs': obj.glyphs});
            }
        }

        else {
            for(var j=0; j<fontModel.count; j++) {
                let obj = fontModel.get(j)
                var name = obj['name']
                if(name.toLowerCase().includes(text)) {
                    fontModelFiltered.append({'name': obj.name, 'glyphs': obj.glyphs});
                }
            }
        }
    }
}
