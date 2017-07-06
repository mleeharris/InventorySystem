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
    threadcall Threadz;
    Threadz.start();
    //qDebug << terminal.returnone();

    qDebug() << "Hello from GUI thread " << app.thread()->currentThreadId();

    //qmlRegisterType<terminalObject>("customObjs", 1, 0, "terminalObjectQML");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QObject *MainWindow = engine.rootObjects().first();
    QObject *LoggedIn = MainWindow->findChild<QObject *>("logged_in");

    engine.rootContext()->setContextProperty("testing", &Testerino);
    engine.rootContext()->setContextProperty("thread", &Threadz);

    threadcall::connect(&Threadz,SIGNAL(sig_loginInfo()),LoggedIn,SLOT(loginInfo()));
    threadcall::connect(&Threadz,SIGNAL(sig_loginInfo()),MainWindow,SLOT(scanned()));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
