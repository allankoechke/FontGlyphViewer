import QtQuick 2.15

Text {
    id: root
    font.family: fontLoader.name
    text: iconSource
    font.pixelSize: iconSize

    property string iconSource: ''
    property real iconSize: 16

    FontLoader {
        id: fontLoader
        source: "qrc:/assets/fonts/MaterialIcons-Regular.otf"
    }
}
