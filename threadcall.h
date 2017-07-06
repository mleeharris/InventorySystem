#ifndef THREADCALL_H
#define THREADCALL_H

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <QObject>
#include <QThread>
#include <signal.h>

class threadcall : public QThread
{
    Q_OBJECT
private:
    void run();
};

#endif // THREADCALL_H
