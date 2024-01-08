import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Font Glyph Loader")

    property ListModel fontModel: ListModel{}

    Component.onCompleted: {
        for(var i=0; i<50; i++) {
            fontModel.append({'name': i})
        }
    }

    Rectangle {
        id: topbar
        height: 50
        width: parent.width
        anchors.top: parent.top
        color: '#ccc'
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
            width: fontgrid.cellWidth
            height: fontgrid.cellHeight

            Rectangle {
                anchors.fill: parent
                anchors.margins: 4
                color: '#444'
            }
        }
    }
}
