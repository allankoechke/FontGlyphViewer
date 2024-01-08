#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "fontglyphloader.h"


int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    FontGlyphLoader fontGlyphLoader;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("fontGlyphLoader", &fontGlyphLoader);

    const QUrl url(u"qrc:/assets/src/ui/Main.qml"_qs);

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
        []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
