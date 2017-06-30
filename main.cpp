#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickItem>
#include <QDebug>
#include <QDir>
#include <QObject>

//Needed for this branch: terminal access
#include <QDebug>
#include <QProcess>
#include "terminal.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    terminal Testerino;
    //qDebug << terminal.returnone();

    QProcess *process = new QProcess;
    process->setWorkingDirectory("/home/drmoo");
    process->start("pcsc_scan");

    //qmlRegisterType<terminalObject>("customObjs", 1, 0, "terminalObjectQML");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    QObject *MainWindow = engine.rootObjects().first();

    engine.rootContext()->setContextProperty("testing", &Testerino);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
