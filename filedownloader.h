#ifndef filedownloader_H
#define filedownloader_H

#include <QObject>
#include <QByteArray>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <QObject>
#include <QThread>
#include <signal.h>

class filedownloader : public QObject
{
    Q_OBJECT
    public:
        explicit filedownloader(QUrl imageUrl, QObject *parent = 0);
        virtual ~filedownloader();
        QByteArray downloadedData() const;
        QByteArray downloadedImage;

    signals:
        void downloaded();

    private slots:
        void fileDownloaded(QNetworkReply* pReply);

    private:
        QNetworkAccessManager m_WebCtrl;
        QByteArray m_DownloadedData;
};

#endif // filedownloader_H
