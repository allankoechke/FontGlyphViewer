#ifndef FONTGLYPHLOADER_H
#define FONTGLYPHLOADER_H

#include <QObject>
#include <QFontDatabase>
#include <QFont>
#include <QRawFont>

class FontGlyphLoader : public QObject {
    Q_OBJECT
public:
    explicit FontGlyphLoader(QObject *parent = nullptr);

    Q_INVOKABLE void loadFont(const QString &path);

signals:
};

#endif  // FONTGLYPHLOADER_H
