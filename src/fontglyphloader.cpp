#include "fontglyphloader.h"
#include <QDebug>

FontGlyphLoader::FontGlyphLoader(QObject *parent) : QObject{parent} {}

void FontGlyphLoader::loadFont(const QString &path)
{
    try
    {
        QUrl url(path);
        int fontId = QFontDatabase::addApplicationFont(url.toLocalFile());
        QString fontFamily = QFontDatabase::applicationFontFamilies(fontId).at(0);
        QFont font(fontFamily);
        QRawFont rawFont = QRawFont::fromFont(font);

        QStringList glyphs;

        // Check for each Unicode character
        for (int unicode = 0; unicode <= 0x10FFFF; ++unicode) {
            if (rawFont.supportsCharacter(unicode)) {
                glyphs.append(QString::number(unicode, 16));
            }
        }

        QVariantMap fontMap;
        fontMap["family"] = fontFamily;
        fontMap["glyphs"] = glyphs;
        fontMap["url"] = url.toLocalFile();

        emit fontLoadingFinished(fontMap);
    }

    catch(const char * err)
    {
        qDebug() << err;
        emit fontLoadError("Error");
    }
}

void FontGlyphLoader::copyToClipboard(const QString &text)
{
    clipboard->setText(text);
    emit copiedToClipboard();
}
