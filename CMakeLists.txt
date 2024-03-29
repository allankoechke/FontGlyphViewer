cmake_minimum_required(VERSION 3.16)

project(FontGlyphViewer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Gui QuickControls2)

qt_standard_project_setup()

qt_add_executable(appFontGlyphViewer
    src/main.cpp
    src/fontglyphloader.h
    src/fontglyphloader.cpp
)

qt_add_qml_module(appFontGlyphViewer
    URI assets
    VERSION 1.0
    RESOURCES
        assets/logo.png
        assets/fonts/MaterialIcons-Regular.otf
    QML_FILES
        src/ui/Main.qml
        src/ui/views/SideBar.qml
        src/ui/views/ViewerPanel.qml
        src/ui/delegates/SideBarDelegate.qml
        src/ui/delegates/ViewerDelegate.qml
        src/ui/controls/FgvButton.qml
        src/ui/controls/FgvIcon.qml
        src/ui/components/FgvNavigationBar.qml
        src/ui/components/FgvPopup.qml
        src/ui/Theme.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appFontGlyphViewer PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appFontGlyphViewer
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appFontGlyphViewer
    PRIVATE Qt6::Quick Qt6::Gui Qt6::QuickControls2
)

include(GNUInstallDirs)
install(TARGETS appFontGlyphViewer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
