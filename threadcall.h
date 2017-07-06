#ifndef THREADCALL_H
#define THREADCALL_H

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <QObject>
#include <QThread>
#include <signal.h>
#include <string.h>
#include <iostream>
#include <string>

class threadcall : public QThread
{
    Q_OBJECT
public:
    explicit threadcall (QThread* parent = 0);
    ~threadcall();

    Q_INVOKABLE QString userGet();
    Q_INVOKABLE QString passGet();
    Q_INVOKABLE QString userpassGet();
    Q_INVOKABLE QString updateGet();

    Q_INVOKABLE void userChange(QString);
    Q_INVOKABLE void passChange(QString);
    Q_INVOKABLE void updateChange(QString);

signals:
    void sig_loginInfo();

private:
    QString username;
    QString password;

    QString update;

    void run();
};

#endif // THREADCALL_H
