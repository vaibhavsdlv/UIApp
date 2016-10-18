#ifndef MOVEMENTLISTMODEL_H
#define MOVEMENTLISTMODEL_H

#include <QAbstractListModel>
#include <QDateTime>
#include <QList>
#include <QTimer>

typedef struct transaction
{
    int id;
    QString account;
    QString category;
    QString description;
    QString dateTime;
    QString transactionType;
    int amount;

    bool operator<(const transaction& other) const
    {
      if(dateTime.toLongLong() - other.dateTime.toLongLong() > 0)
      {
          return true;
      }
      else
      {
          return false;
      }
    }

}stTransaction;

class movementListModel:QAbstractListModel
{
    Q_OBJECT

    QList<stTransaction*> transactionList;
    QHash<int ,QByteArray> tRoles;

public:

    QVariant data(const QModelIndex &index, int role) const;
    bool setData(const QModelIndex & index, const QVariant & value, int role = Qt::EditRole);
    Qt::ItemFlags flags(const QModelIndex &index) const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    void insertParameters(QList<stTransaction*> list, bool enableSort);

    QHash<int,QByteArray> roleNames() const;

    enum eRoles{
        idRole = Qt::UserRole + 1,
        accountRole,
        categoryRole,
        descriptionRole,
        dateTimeRole,
        transactionTypeRole,
        amountRole
    };

    movementListModel();
    void clear();

};

#endif // MOVEMENTLISTMODEL_H
