#include "movementlistmodel.h"

movementListModel::movementListModel()
{
    tRoles[idRole] = "idRole";
    tRoles[accountRole] = "accountRole";
    tRoles[categoryRole] = "categoryRole";
    tRoles[descriptionRole] = "descriptionRole";
    tRoles[dateTimeRole] = "dateTimeRole";
    tRoles[transactionTypeRole] = "transactionTypeRole";
    tRoles[amountRole] = "amountRole";
}

void movementListModel::clear()
{
    beginRemoveRows(QModelIndex(), 0, transactionList.size()-1);
    foreach(stTransaction *transaction ,transactionList)
    {
        delete transaction;
    }
    transactionList.clear();
    endRemoveRows();
}

QVariant movementListModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() > transactionList.size())
    {
        return QVariant();
    }

    if(role == idRole)
    {
        return (transactionList.at(index.row())->id);
    }
    else if(role == accountRole)
    {
        return transactionList.at(index.row())->account;
    }
    else if(role == categoryRole)
    {
        return transactionList.at(index.row())->category;
    }
    else if(role == descriptionRole)
    {
        return transactionList.at(index.row())->description;
    }
    else if(role == dateTimeRole)
    {
        return transactionList.at(index.row())->dateTime;
    }
    else if(role == transactionTypeRole)
    {
        return transactionList.at(index.row())->transactionType;
    }
    else if(role == amountRole)
    {
        return transactionList.at(index.row())->amount;
    }
    return QVariant();
}

bool movementListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Q_UNUSED(role);
    if(index.row() < 0 || index.row() >= transactionList.size())
    {
        return false;
    }

    switch(role)
    {
        case idRole:
            transactionList.at(index.row())->id = value.toInt();
        break;

        case accountRole:
            transactionList.at(index.row())->account = value.toString();
            break;

        case categoryRole:
            transactionList.at(index.row())->category = value.toString();
            break;

        case descriptionRole:
            transactionList.at(index.row())->description = value.toString();
            break;

        case dateTimeRole:
            transactionList.at(index.row())->dateTime = value.toString();
            break;

        case transactionTypeRole:
            transactionList.at(index.row())->transactionType = value.toString();
            break;

        case amountRole:
            transactionList.at(index.row())->amount = value.toInt();
            break;
    }

    emit dataChanged(index,index);
    return true;
}

Qt::ItemFlags movementListModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::ItemIsEnabled;
    return QAbstractItemModel::flags(index) | Qt::ItemIsEditable;
}

int movementListModel::rowCount(const QModelIndex &parent ) const
{
    Q_UNUSED(parent);
    return transactionList.size();
}

void movementListModel::insertParameters(QList<stTransaction*> list, bool enableSort)
{
    beginInsertRows(QModelIndex(), 0, list.size()-1);
    transactionList = list;
    if(enableSort)
    {
        qSort(transactionList);
    }
    endInsertRows();
}

QHash<int, QByteArray> movementListModel::roleNames() const
{
    return tRoles;
}

