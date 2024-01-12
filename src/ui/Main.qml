import QtQuick
import QtCore
import QtQuick.Dialogs
import QtQuick.Controls

Window {
    id: app
    width: 640
    height: 480
    visible: true
    color: theme.primaryBackground
    title: qsTr("Font Glyph Viewer")

    property ListModel fontModel: ListModel{}
    property string fontFamily


    QtObject {
        id: theme

        // Background Colors
        property string primaryBackground: "#121212"
        property string secondaryBackground: "#1E1E1E"
        property string tertiaryBackground: "#242424"

        // Text Colors
        property string primaryText: "#FFFFFF"
        property string secondaryText: "#B3B3B3"
        property string accentText: "#BB86FC"

        // Accent Colors
        property string primaryAccent: "#BB86FC"
        property string secondaryAccent: "#03DAC6"
        property string tertiaryAccent: "#CF6679"

        // Border and Divider Colors
        property string lightBorder: "#333333"
        property string darkBorder: "#292929"

        // Interactive Element Colors
        property string normalInteractive: "#BB86FC"
        property string hoverInteractive: "#3700B3"
        property string activeInteractive: "#03DAC6"
        property string disabledInteractive: "#666666"

        // Error and Warning Colors
        property string errorColor: "#CF6679"
        property string warningColor: "#FFC107"
        property string successColor: "#03DAC6"

        // Shadows and Overlays
        property string shadowColor: "rgba(0, 0, 0, 0.5)"
        property string overlayColor: "rgba(255, 255, 255, 0.1)"
    }


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
            color: theme.lightBorder
        }

        Text {
            text: fontFamily==='' ? "Select a font (.otf, .ttf)" : "Font: " + fontFamily
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            font.pixelSize: 16
            color: theme.primaryText
        }

        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            spacing: 8

            FgButton {
                visible: fontFamily!==''
                text: qsTr('Clear All')
                color: theme.tertiaryAccent
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
        color: theme.secondaryText
    }

    GridView {
        id: fontgrid
        visible: fontModel.count!==0 || fontFamily!==''

        ScrollBar.vertical: ScrollBar {
            id: scrollbar
            active: fontgrid.moving || fontgrid.flicking
            policy: ScrollBar.AlwaysOn

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
                Behavior on opacity {
                    NumberAnimation {}
                }
            }
        }

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
