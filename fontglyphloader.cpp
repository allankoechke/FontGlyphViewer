#include "fontglyphloader.h"
#include <QDebug>

FontGlyphLoader::FontGlyphLoader(QObject *parent) : QObject{parent} {}

void FontGlyphLoader::loadFont(const QString &path)
{
    int fontId = QFontDatabase::addApplicationFont(path);
    QString fontFamily = QFontDatabase::applicationFontFamilies(fontId).at(0);
    QFont font(fontFamily);
    QRawFont rawFont = QRawFont::fromFont(font);

    qDebug() << "Family: " << fontFamily;

    // Check for each Unicode character
    for (int unicode = 0; unicode <= 0x10FFFF; ++unicode) {
        if (rawFont.supportsCharacter(unicode)) {
            qDebug() << "Character:" << QChar(unicode) << " Unicode:" << unicode;
        }
    }

}
