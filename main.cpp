#include <QGuiApplication>
#include <QQmlApplicationEngine>

//Needed for this branch: terminal access
#include <QDebug>
#include <QProcess>

int main(int argc, char *argv[])
{
    QProcess process;
    process.start("ping 8.8.8.8 -c 2"); //Put your terminal command here
    process.waitForFinished(-1); // will wait forever until finished, can be changed Qprocess emits a "finished" signal

    QString stdout = process.readAllStandardOutput();
    QString stderr = process.readAllStandardError();

    /* Will print Terminal Output to Application output below
     * .noquote() interprets all newlines, qDebug() will be default print out '\n' */
    qDebug().noquote() << "stdout: " << stdout << "\n stderr: " << stderr;

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
