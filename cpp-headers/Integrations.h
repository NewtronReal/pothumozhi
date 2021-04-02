#ifndef INTEGRATIONS_H
#define INTEGRATIONS_H
#include <QFile>
#include <QTextStream>
#include <QObject>
#include <iostream>
using namespace std;

class Integrations : public QObject
{
    Q_OBJECT
public:
    Integrations(QObject* parent = NULL);
    virtual ~Integrations() {}
public slots:
    QString readFile(QString path);
};



#endif // INTEGRATIONS_H
