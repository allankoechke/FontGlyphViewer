import QtQuick
import QtQuick.Controls

Item {
    id: root
    width: _rbtn.width + 30
    implicitHeight: 30

    enum Type {
        Filled,
        Outlined,
        Text
    }

    enum IconType {
        NONE,
        LeftOnly,
        RightOnly,
        LeftAndText,
        RightAndText,
        LeftAndRight,
        LeftRightAndText
    }

    property string color: theme.primaryAccent
    property alias radius: bg.radius
    property int buttonType: FgvButton.Filled
    property int buttonIconType: FgvButton.NONE
    property string textColor: theme.primaryText
    property string leftIcon: ''
    property string rightIcon: ''
    property real iconSize: 16
    property string text: ''
    property real textIconSpacing: 8

    signal clicked()

    QtObject {
        id: internal
        property string buttonColor: { if(buttonType===FgvButton.Filled) { return btn.down ? Qt.lighter(root.color) : root.color } else { return 'transparent' }}
        property bool showText: buttonIconType===FgvButton.NONE || buttonIconType===FgvButton.LeftAndText || buttonIconType===FgvButton.RightAndText || buttonIconType===FgvButton.LeftRightAndText
        property bool showLeftIcon: buttonIconType===FgvButton.LeftOnly || buttonIconType===FgvButton.LeftAndText || buttonIconType===FgvButton.LeftAndRight || buttonIconType===FgvButton.LeftRightAndText
        property bool showRightIcon: buttonIconType===FgvButton.RightOnly || buttonIconType===FgvButton.RightAndText || buttonIconType===FgvButton.LeftAndRight || buttonIconType===FgvButton.LeftRightAndText
    }

    Button {
        id: btn
        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        background: Rectangle {
            id: bg
            radius: height/2
            color: internal.buttonColor
            border.width: 0
            border.color: theme.primaryText
            clip: true

            Rectangle {
                id: backBtnTapIndicator
                width: 0
                height: width
                radius: height/2
                anchors.centerIn: parent
                visible: btnAnimator.running
            }
        }

        contentItem: Item {
            anchors.fill: parent
            clip: true

            Row {
                id: _rbtn
                spacing: textIconSpacing
                anchors.centerIn: parent

                FgvIcon {
                    anchors.verticalCenter: parent.verticalCenter
                    iconSize: iconSize
                    iconSource: leftIcon
                    color: textColor
                    scale: btn.down ? 1.2 : 1
                    visible: internal.showLeftIcon

                    Behavior on scale { NumberAnimation { duration: 200 }}
                }

                Text {
                    text: root.text
                    font.pixelSize: 14
                    color: textColor

                    Behavior on scale { NumberAnimation { duration: 200 }}
                }

                FgvIcon {
                    anchors.verticalCenter: parent.verticalCenter
                    iconSize: iconSize
                    iconSource: rightIcon
                    color: textColor
                    scale: btn.down ? 1.2 : 1
                    visible: internal.showRightIcon

                    Behavior on scale { NumberAnimation { duration: 200 }}
                }
            }
        }

        ParallelAnimation {
            id: btnAnimator

            NumberAnimation {
                target: backBtnTapIndicator
                from: 0; to: backBtnTapIndicator.parent.width
                properties: 'width'
                duration: 200
            }
        }

        onClicked: {
            btnAnimator.start()
            root.clicked()
        }
    }
}
