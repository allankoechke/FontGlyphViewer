import QtQuick

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

    // Icons Material
    property string addIcon: "\ue047"
    property string addRoundFilledIcon: "\ue04f"
    property string addIconRoundOutlined: "\ue050"
    property string backArrowIcon: "\ue092"
    property string angleRightIcon: "\ue09c"
    property string angleLeftIcon: "\ue094" // 3
}

