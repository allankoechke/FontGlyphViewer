#include <QApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQmlContext>
#include <QQuickStyle>

#include "fontglyphloader.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

    app.setOrganizationName("CodeArtKe");
    app.setOrganizationDomain("codeart.co.ke");
    app.setApplicationName("Font Glyph Viewer");

    QQuickStyle::setStyle("Basic");

    app.setWindowIcon(QIcon(":/assets/logo.png"));

    QQmlApplicationEngine engine;

    FontGlyphLoader fontGlyphLoader;
    engine.rootContext()->setContextProperty("fontGlyphLoader", &fontGlyphLoader);

    const QUrl url(QStringLiteral("qrc:/qml/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

