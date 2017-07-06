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
#include "threadcall.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    terminal Testerino;
    threadcall PlsWork;
    PlsWork.start();
    //qDebug << terminal.returnone();

    qDebug() << "Hello from GUI thread " << app.thread()->currentThreadId();
    PlsWork.wait();

    //qmlRegisterType<terminalObject>("customObjs", 1, 0, "terminalObjectQML");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    QObject *MainWindow = engine.rootObjects().first();

    engine.rootContext()->setContextProperty("testing", &Testerino);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
