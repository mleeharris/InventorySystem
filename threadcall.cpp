#include <QGuiApplication>
#include <QQmlApplicationEngine>

//Needed for this branch: terminal access
#include <QDebug>
#include <QObject>
#include <QProcess>
#include "threadcall.h"
#include <string>
#include <iostream>

threadcall::threadcall(QThread *parent) : QThread(parent) {

}

threadcall::~threadcall(){
    return;
}

QString threadcall::userGet() {
    return username;
}

QString threadcall::passGet() {
    return password;
}

QString threadcall::userpassGet() {
    QString toReturn = username + '=' + password;
    return toReturn;
}

QString threadcall::updateGet() {
    return update;
}

int threadcall::activeGet() {
    return active;
}

void threadcall::userChange(QString newname) {
    username = newname;
}

void threadcall::passChange(QString newname) {
    password = newname;
}

void threadcall::updateChange(QString newname) {
    update = newname;
}

void threadcall::activeChange(int newnum) {
    active = newnum;
}

void threadcall::run() {
    qDebug() << "Hello from worker thread " << thread()->currentThreadId();

    QProcess *process2 = new QProcess;
    process2->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    process2->start("python NFCReader.py --auth 04 00");
    process2->waitForFinished(-1);

    QProcess *process4 = new QProcess;
    process4->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    process4->start("python NFCReader.py --read 04");
    process4->waitForFinished(-1);

    QString stdout4 = process4->readAllStandardOutput();

    QProcess *process5 = new QProcess;
    process5->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
    process5->start("python NFCReader.py --read 05");
    process5->waitForFinished(-1);

    QString stdout5 = process5->readAllStandardOutput();
    QString namechange;

    while(1) {
        if (activeGet() == 0) {
            QProcess *process2 = new QProcess;
            process2->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
            process2->start("python NFCReader.py --auth 04 00");
            process2->waitForFinished(-1);

            QProcess *process4 = new QProcess;
            process4->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
            process4->start("python NFCReader.py --read 04");
            process4->waitForFinished(-1);

            stdout4 = process4->readAllStandardOutput();

            QProcess *process5 = new QProcess;
            process5->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
            process5->start("python NFCReader.py --read 05");
            process5->waitForFinished(-1);

            stdout5 = process5->readAllStandardOutput();

            updateChange(stdout4);

            if (stdout4 == "Error") {
                activeChange(0);
                emit sig_active();
                namechange = "Error";
                //qDebug() << stdout4 << ' :: ' << stdout5;
            }
            else if (namechange != stdout4) {
                activeChange(1);
                namechange = stdout4;
                userChange(stdout4);
                passChange(stdout5);
                emit sig_loginInfo();
                emit sig_active();
                //qDebug() << stdout4 << ' lmao ' << stdout5;
            }
            else {
                //qDebug() << stdout4 << ' ayyyyyy ' << stdout5;
            }
        }
        if (activeGet() == 1) {
            int i = 0;
            while (i < 400000000) {
                i++;
            }
            QProcess *process2 = new QProcess;
            process2->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
            process2->start("python NFCReader.py --auth 04 00");
            process2->waitForFinished(-1);

            QProcess *process4 = new QProcess;
            process4->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
            process4->start("python NFCReader.py --read 04");
            process4->waitForFinished(-1);

            stdout4 = process4->readAllStandardOutput();

            QProcess *process5 = new QProcess;
            process5->setWorkingDirectory("/home/drmoo/Documents/PartKeepr/partkeeprgui");
            process5->start("python NFCReader.py --read 05");
            process5->waitForFinished(-1);

            stdout5 = process5->readAllStandardOutput();

            updateChange(stdout4);

            if (stdout4 == "Error") {
                activeChange(0);
                emit sig_active();
                namechange = "Error";
                //qDebug() << stdout4 << ' :: ' << stdout5;
            }
            else if (namechange != stdout4) {
                activeChange(1);
                namechange = stdout4;
                userChange(stdout4);
                passChange(stdout5);
                emit sig_loginInfo();
                emit sig_active();
                //qDebug() << stdout4 << ' lmao ' << stdout5;
            }
            else {
                //qDebug() << stdout4 << ' ayyyyyy ' << stdout5;
            }
        }
    }

    //qDebug() << stdout;
}
