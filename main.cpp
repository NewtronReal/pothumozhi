#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <iostream>
#include <Integrations.h>
using namespace std;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<Integrations>("NewIntegrations",1,0,"Integrations");

    const QUrl mainQml(QStringLiteral("qrc:/main.qml"));
    const QMetaObject::Connection connection = QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated,
                &app, [&](QObject *object, const QUrl &url) {
            if (url != mainQml)
            return;

            if (!object)
            app.exit(-1);
            else
            QObject::disconnect(connection);
}, Qt::QueuedConnection);

    engine.load(mainQml);

    return app.exec();
}
