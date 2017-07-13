#ifndef TERMINAL_H
#define TERMINAL_H

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <QObject>
#include <QThread>
#include <signal.h>

class terminal : public QObject
{
    Q_OBJECT
public:
    explicit terminal (QObject* parent = 0);
    ~terminal();

    Q_INVOKABLE void updateMsg(QString);

    Q_INVOKABLE QString readCard();

    Q_INVOKABLE void addKey(QString, QString);
    Q_INVOKABLE void auth(QString);
    Q_INVOKABLE QString readBlock(QString);
    Q_INVOKABLE QString updateBlock(QString, QString);
    Q_INVOKABLE QString getMsg();

public slots:
    int returntwo();

private:
    QString msg;

};

#endif // TERMINAL_H
