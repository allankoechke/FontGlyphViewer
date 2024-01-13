import sys, os, subprocess

CQTDEPLOYER_DIR = "D:/Programs/CQtDeployer/1.6/"
PROJECT_DIR = os.path(__file__)
BUILD_DIR = os.path.join(PROJECT_DIR, '../builds/build-IconFontLoader-Desktop_Qt_6_6_1_MinGW_64_bit-Release')
QMAKE_DIR = "D:/Programs/Qt/6.6.1/mingw_64/bin"

if __name__ == "__main__":
    cqtdeployer = os.path.join(CQTDEPLOYER_DIR, 'CQtDeployer')
    executable = os.path.join(BUILD_DIR, 'appFontGlyphViewer.exe')
    qmake = os.path.join(QMAKE_DIR, 'qmake.exe')
    qmlDir = os.path.join(PROJECT_DIR, 'src/ui')
    cmd = [cqtdeployer, '-bin', executable, '-qmake', qmake, "-qmlDir", qmlDir] #, '-icon', D:/Workspace/Upwork/IconFontLoader/assets/logo.png -name FontGlyphViewer]

    subprocess.Popen()