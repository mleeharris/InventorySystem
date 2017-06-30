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

    Q_INVOKABLE QString readCard(int block);

public slots:
    int returntwo();
};

#endif // TERMINAL_H
