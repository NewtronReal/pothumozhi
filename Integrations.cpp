#include <Integrations.h>
#include <QUrl>

Integrations::Integrations(QObject *parent):QObject(parent){}

QString Integrations::readFile(QString path){
    QFile file(path);
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        printf("err:file can't be opened");
        return "something Wrong";
    }
    QTextStream textFile(&file);
    return textFile.readAll();
}
