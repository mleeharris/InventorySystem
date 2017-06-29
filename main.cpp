#include <QGuiApplication>
#include <QQmlApplicationEngine>

//Needed for this branch: terminal access
#include <QDebug>
#include <QProcess>

int main(int argc, char *argv[])
{
    QProcess *process = new QProcess;
    process->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    process->start("python NFCReader.py --addkey 00 FFFFFFFFFFFF");
    process->waitForFinished(-1);

    QString stdout = process->readAllStandardOutput();
    QString stderr = process->readAllStandardError();

    qDebug().noquote() << "stdout: " << stdout << "\n stderr: " << stderr;

    QProcess *process2 = new QProcess;
    process2->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    process2->start("python NFCReader.py --auth 04 00");
    process2->waitForFinished(-1);

    QString stdout2 = process2->readAllStandardOutput();
    QString stderr2 = process2->readAllStandardError();

    qDebug().noquote() << "stdout: " << stdout2 << "\n stderr: " << stderr2;

    QProcess *process3 = new QProcess;
    process3->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    process3->start("python NFCReader.py --update 04 Superbud9123");
    process3->waitForFinished(-1);

    QString stdout3 = process3->readAllStandardOutput();
    QString stderr3 = process3->readAllStandardError();

    qDebug().noquote() << "stdout: " << stdout3 << "\n stderr: " << stderr3;

    QProcess *process4 = new QProcess;
    process4->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    process4->start("python NFCReader.py --read 04");
    process4->waitForFinished(-1);

    QString stdout4 = process4->readAllStandardOutput();
    QString stderr4 = process4->readAllStandardError();

    qDebug().noquote() << "stdout: " << stdout4 << "\n stderr: " << stderr4;

//    QGuiApplication app(argc, argv);

//    QQmlApplicationEngine engine;

//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
//    if (engine.rootObjects().isEmpty())
//        return -1;

//    return app.exec();
    return 0;
}
