#include <QGuiApplication>
#include <QQmlApplicationEngine>

//Needed for this branch: terminal access
#include <QDebug>
#include <QObject>
#include <QProcess>
#include "threadcall.h"

void threadcall::run() {
    qDebug() << "Hello from worker thread " << thread()->currentThreadId();
}
