#ifndef FONTGLYPHLOADER_H
#define FONTGLYPHLOADER_H

#include <QObject>
#include <QFontDatabase>
#include <QFont>
#include <QRawFont>
#include <QUrl>
#include <QVariantMap>
#include <QClipboard>
#include <QGuiApplication>

class FontGlyphLoader : public QObject {
    Q_OBJECT
public:
    explicit FontGlyphLoader(QObject *parent = nullptr);

    Q_INVOKABLE void loadFont(const QString &path);

    Q_INVOKABLE void copyToClipboard(const QString &text);

signals:
    void fontLoadingFinished(const QVariantMap &fontMap);

    void fontLoadError(const QString &error);

    void copiedToClipboard();

private:
    QClipboard *clipboard = QGuiApplication::clipboard();
};

#endif  // FONTGLYPHLOADER_H
