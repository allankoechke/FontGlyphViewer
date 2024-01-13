import QtQuick
import QtCore
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts

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
    property string selectedFontFamily: ''
    property Theme theme: Theme{}
    property ListElement currentFont


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

    FgvNavigationBar {
        id: topbar
    }

    Loader {
        anchors.top: topbar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        sourceComponent: isMobileScreen ? smallScreenComponent : wideScreenComponent
    }

    Component {
        id: smallScreenComponent

        StackView {
            id: stackView
            width: parent.width
            height: parent.height
            initialItem: sideBarComponent

            Component.onCompleted: {
                console.log('Created StackView')
                //handleMobileScreenChanges()
            }

            function handleMobileScreenChanges() {
                console.log(isMobileScreen, fontFamily!=='')
                if(isMobileScreen) {
                    // If a font is already selected
                    if(fontFamily!=='') {
                        stackView.push(fontViewerComponent)
                    }
                } else {
                    if(fontFamily==='') {
                        stackView.pop(null)
                    }
                }
            }

            Connections {
                target: app

                //function onIsMobileScreenChanged() { handleMobileScreenChanges(); }
            }
        }
    }

    Component {
        id: wideScreenComponent

        Item {
            width: parent.width
            height: parent.height

            RowLayout {
                anchors.fill: parent
                spacing: 0

                Loader {
                    Layout.fillHeight: true
                    Layout.preferredWidth: Math.min(parent.width/4, 300)
                    sourceComponent: sideBarComponent
                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 1
                    color: theme.lightBorder
                }

                Loader {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    sourceComponent: fontViewerComponent
                }
            }
        }
    }

    Component {
        id: sideBarComponent

        SideBar {
            id: sideBar
            width: parent.width
            height: parent.height
        }
    }

    Component {
        id: fontViewerComponent

        ViewerPanel {
            id: fontViewer
            width: parent.width
            height: parent.height
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

    FgvPopup {
        id: fgpopup
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

            console.log('> ', glyphsArray.length)
            fontModel.append({'name': family, 'glyphs': glyphsArray})

        }

        function onCopiedToClipboard() {
            // console.log('Copied to clipboard')
        }
    }
}
