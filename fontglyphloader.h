#ifndef FONTGLYPHLOADER_H
#define FONTGLYPHLOADER_H

#include <QObject>
#include <QFontDatabase>
#include <QFont>
#include <QRawFont>
#include <QUrl>
#include <QVariantMap>

class FontGlyphLoader : public QObject {
    Q_OBJECT
public:
    explicit FontGlyphLoader(QObject *parent = nullptr);

    Q_INVOKABLE void loadFont(const QString &path);

signals:
    void fontLoadingFinished(const QVariantMap &fontMap);

    void fontLoadError(const QString &error);
};

#endif  // FONTGLYPHLOADER_H
