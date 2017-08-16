#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickItem>
#include <QDebug>
#include <QDir>
#include <QObject>
#include <QVector>

#include <QDebug>
#include <QProcess>
#include "terminal.h"
#include "threadcall.h"
#include "filedownloader.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //QUrl imageUrl("https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png");
    //Backend backend;
    terminal Testerino;
    threadcall Threadz;
    Threadz.start();
    //qDebug << terminal.returnone();

    qDebug() << "Hello from GUI thread " << app.thread()->currentThreadId();

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QObject *MainWindow = engine.rootObjects().first();
    QObject *ScanPage = MainWindow->findChild<QObject *>("scan_page");
    //QObject *LoggedIn = MainWindow->findChild<QObject *>("logged_in");

    //filedownloader imgtest(imageUrl, MainWindow);
    //QObject *imgtest = new filedownloader(imageUrl, MainWindow);

    engine.rootContext()->setContextProperty("testing", &Testerino);
    engine.rootContext()->setContextProperty("thread", &Threadz);
    //engine.rootContext()->setContextProperty("image", &imgtest);
    //engine.rootContext()->setContextProperty("backend", &backend);

    //QPixmap buttonImage;
    //buttonImage.loadFromData(imgtest->downloadedData());

    //threadcall::connect(&Threadz,SIGNAL(sig_loginInfo()),LoggedIn,SLOT(loginInfo()));
    //filedownloader::connect(&imgtest, SIGNAL(downloaded()), MainWindow, SLOT(loadImage()));
    threadcall::connect(&Threadz,SIGNAL(sig_loginInfo()),MainWindow,SLOT(scanned()));
    threadcall::connect(&Threadz,SIGNAL(sig_active()),ScanPage,SLOT(updateActive()));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
