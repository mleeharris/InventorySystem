#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QDebug>
#include <QObject>
#include <QProcess>
#include "filedownloader.h"


/***********************************************************************/
// Currently unused potentially useful image downloader
/***********************************************************************/
filedownloader::filedownloader(QUrl imageUrl, QObject *parent) : QObject(parent) {
    connect(&m_WebCtrl, SIGNAL (finished(QNetworkReply*)), this, SLOT (fileDownloaded(QNetworkReply*)));

    QNetworkRequest request(imageUrl);
    m_WebCtrl.get(request);
}

filedownloader::~filedownloader() { }

void filedownloader::fileDownloaded(QNetworkReply* pReply) {
    m_DownloadedData = pReply->readAll();
    downloadedImage = pReply->readAll();
    //emit a signal
    pReply->deleteLater();
    emit downloaded();
}

QByteArray filedownloader::downloadedData() const {
    return m_DownloadedData;
}
