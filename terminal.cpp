#include <QGuiApplication>
#include <QQmlApplicationEngine>

//Needed for this branch: terminal access
#include <QDebug>
#include <QObject>
#include <QProcess>
#include "terminal.h"

terminal::terminal(QObject *parent) : QObject(parent) {

}

terminal::~terminal(){
    return;
}

void terminal::addKey(QString keycode, QString keynum) {
    QString use = "python3 NFCReader.py --addkey ";
    use.append(QString("%1 ").arg(keynum));
    use.append(QString("%1").arg(keycode));

    QProcess *process1 = new QProcess;
    process1->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    //process1->start("python3 NFCReader.py --addkey 00 FFFFFFFFFFFF");
    //qDebug() << use;
    process1->start(use);
    process1->waitForFinished(-1);

    QString stdout1 = process1->readAllStandardOutput();

    //qDebug() << stdout1;
    //qDebug() << keycode;

    if (stdout1 == "Error") {
        updateMsg("Error: The key " + keycode + " was not added");
    }
    else {
        updateMsg("The key " + keycode + " was added succesfully");
    }
}

void terminal::auth(QString blocktoauth) {
    QString use = QString("python3 NFCReader.py --auth %1 00").arg(blocktoauth);

    QProcess *process1 = new QProcess;
    process1->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    //process1->start("python3 NFCReader.py --auth 04 00");
    process1->start(use);
    process1->waitForFinished(-1);

    QString stdout1 = process1->readAllStandardOutput();

    //qDebug() << stdout1;

    if (stdout1 == "Error") {
        updateMsg("Error: Not authorized");
    }
    else {
        updateMsg("Authorized block " + blocktoauth + " successfully");
    }
}

QString terminal::readBlock(QString blocktoread) {
    QString use = "python3 NFCReader.py --read ";
    use.append(QString("%1").arg(blocktoread));

    //qDebug() << use;

    QProcess *process1 = new QProcess;
    process1->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    process1->start(use);
    process1->waitForFinished(-1);

    QString stdout1 = process1->readAllStandardOutput();

    //qDebug() << stdout1;

    if (stdout1 == "Error") {
        updateMsg("Error: Not read");
    }
    else {
        if (blocktoread == "04") {
            updateMsg("Read username: " + stdout1);
        }
        if (blocktoread == "05") {
            updateMsg("Read password: " + stdout1);
        }
        if (blocktoread == "07") {
            updateMsg("Read trailer: " + stdout1);
        }
    }

    return stdout1;
}

QString terminal::updateBlock(QString blocktowrite, QString info) {
    QString use = "python3 NFCReader.py --update ";
    use.append(QString("%1 ").arg(blocktowrite));
    use.append(QString("%1").arg(info));

    //qDebug() << use;

    QProcess *process1 = new QProcess;
    process1->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    process1->start(use);
    process1->waitForFinished(-1);

    QString stdout1 = process1->readAllStandardOutput();

    //qDebug() << stdout1;

    if (stdout1 == "Error") {
        updateMsg("Error: Not updated");
    }
    else {
        updateMsg("Written value " + info + " to block " + blocktowrite);
    }

    return stdout1;
}

QString terminal::getMsg() {
    return msg;
}

void terminal::updateMsg(QString newmsg) {
    msg = newmsg;
}

QString terminal::readCard() {
    QProcess *process2 = new QProcess;
    process2->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    process2->start("python3 NFCReader.py --auth 04 00");
    process2->waitForFinished(-1);

    QProcess *process4 = new QProcess;
    process4->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    process4->start("python3 NFCReader.py --read 04");
    process4->waitForFinished(-1);

    QString stdout4 = process4->readAllStandardOutput();

    QProcess *process5 = new QProcess;
    process5->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    process5->start("python3 NFCReader.py --read 05");
    process5->waitForFinished(-1);

    QString stdout5 = process5->readAllStandardOutput();

    QString stdout = stdout4 + '=' + stdout5;

    return stdout;
}

int terminal::returntwo() {
    return 2;
}
