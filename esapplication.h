#ifndef ESAPPLICATION_H
#define ESAPPLICATION_H

#include <QtDebug>
#include <QQuickView>
#include <QSqlDatabase>
#include "movementlistmodel.h"
#include <QTimer>

class ESApplication:QObject
{
    Q_OBJECT
    QObject *parent;
    QSqlDatabase db;
    movementListModel m_fullMovementModel, m_last10TrxModel;
    QQuickView view;
    QString m_account, m_desc, m_category, m_trxType;
    QDateTime m_trxDateTime;
    int m_amount;

    // for chart
    QVariantList m_dataList;
    QVariantList m_labelList;

    Q_PROPERTY(QVariantList dataList READ dataList WRITE setDataList )
    Q_PROPERTY(QVariantList labelList READ labelList WRITE setLabelList)

    Q_PROPERTY(QString account READ account WRITE setAccount)
    Q_PROPERTY(QString desc READ desc WRITE setDesc)
    Q_PROPERTY(QString category READ category WRITE setCategory)
    Q_PROPERTY(QString trxDateTime READ trxDateTime WRITE setTrxDateTime)
    Q_PROPERTY(QString amount READ amount WRITE setAmount)

public:
    void setAccount(const QString &a);
    QString account() const;
    void setDesc(const QString &a);
    QString desc() const;
    void setCategory(const QString &a);
    QString category() const;
    void setTrxDateTime(const QString &a);
    QString trxDateTime() const;
    void setAmount(const QString &a);
    QString amount() const;

    void setDataList(const QVariantList &a);
    QVariantList dataList() const;
    void setLabelList(const QVariantList &a);
    QVariantList labelList() const;

    Q_INVOKABLE void setTrxType(const QString &a);

    ESApplication(QObject *parent);

    Q_INVOKABLE void addTransaction();
    Q_INVOKABLE void refillMovementModel();
    Q_INVOKABLE void refillLast10TrxModel();
    Q_INVOKABLE void clearDB();

    Q_INVOKABLE void chartLast10Trx();
};

#endif // ESAPPLICATION_H
