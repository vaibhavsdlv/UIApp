#include "esapplication.h"
#include <QSqlQuery>
#include <QQmlContext>

ESApplication::ESApplication(QObject *parent=0)
{
    this->parent = parent;
    this->m_amount = 0;



    createLocalDBIfNotAvailable();

    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(QStandardPaths::writableLocation(QStandardPaths::DataLocation)+"/expenses.db");

    if(!db.open())
    {
        qDebug()<<"Database open failed!";
        exit(0);
    }

    // fill chart data
    for(int i = 0; i<10; i++)
    {
        m_dataList.append(10-i);
        m_labelList.append(QString::number(i));
    }

    refillMovementModel();
    refillLast10TrxModel();


    view.rootContext()->setContextProperty("_MovementModel", (QObject*)&m_fullMovementModel);
    view.rootContext()->setContextProperty("_last10TrxModel", (QObject*)&m_last10TrxModel);
    view.rootContext()->setContextProperty("_ESApplication", this);
    view.setSource(QUrl("qrc:/qml/Resources/Home.qml"));
    QObject::connect((QObject*)(&view)->engine(), SIGNAL(quit()), parent, SLOT(quit()));
    view.show();
}

void ESApplication::refillMovementModel()
{
    // Fill movement model;
    m_fullMovementModel.clear();

    // Query: select * from Transactions
    QSqlQuery query(db);
    if(!query.exec("select * from Transactions order by Date desc"))
    {
        qDebug()<<"SQL Select * Query failed!";
    }
    else
    {
        QList<stTransaction*> transactionList;

        while(query.next())
        {
            stTransaction *tempTransaction = new stTransaction();
            tempTransaction->id = query.value(0).toInt();
            tempTransaction->account = query.value(1).toString();
            tempTransaction->category = query.value(2).toString();
            tempTransaction->description = query.value(3).toString();
            tempTransaction->dateTime = QDateTime::fromMSecsSinceEpoch(query.value(4).toLongLong()*1000).toString("dd/MM/yyyy");
            tempTransaction->transactionType = query.value(5).toString();
            tempTransaction->amount = query.value(6).toInt();
            transactionList.append(tempTransaction);
        }

        m_fullMovementModel.insertParameters(transactionList, false);
    }
}

void ESApplication::refillLast10TrxModel()
{
    // Fill last 10 trx model
    m_last10TrxModel.clear();
    QSqlQuery query(db);
    // Query: // Query: select * from Transactions order by id dec limit 10
    if(!query.exec("select * from Transactions order by ID desc limit 10"))
    {
        qDebug()<<"SQL Select last 10 trx Query failed!";
    }
    else
    {
        QList<stTransaction*> transactionList;

        while(query.next())
        {
            stTransaction *tempTransaction = new stTransaction();
            tempTransaction->id = query.value(0).toInt();
            tempTransaction->account = query.value(1).toString();
            tempTransaction->category = query.value(2).toString();
            tempTransaction->description = query.value(3).toString();
            tempTransaction->dateTime = QDateTime::fromMSecsSinceEpoch(query.value(4).toLongLong()*1000).toString("dd/MM/yyyy");
            tempTransaction->transactionType = query.value(5).toString();
            tempTransaction->amount = query.value(6).toInt();
            transactionList.append(tempTransaction);
        }

        m_last10TrxModel.insertParameters(transactionList, false);
    }
}

void ESApplication::clearDB()
{
    QSqlQuery query(db);
    if(!query.exec("delete from Transactions"))
    {
        qDebug()<<"SQL Delete Query failed!";
    }
    refillLast10TrxModel();
    refillMovementModel();
}

void ESApplication::chartLast10Trx()
{
    // Function to get last 10 Trx and update the chart
    QSqlQuery query(db);
    // Query: // Query: select * from Transactions order by id dec limit 10
    if(!query.exec("select * from Transactions order by ID desc limit 10"))
    {
        qDebug()<<"SQL Select last 10 trx Query failed!";
    }
    else
    {
        m_labelList.clear();
        m_dataList.clear();
        int counter = 0;

        while(query.next())
        {
            counter++;
            m_labelList.append(query.value(2).toString());
            m_dataList.append(query.value(6).toInt());
        }

        for(; counter<10; counter++)
        {
            m_labelList.append("");
            m_dataList.append(0);
        }
    }
}

void ESApplication::setAccount(const QString &a)
{
    if (a != m_account)
    {
        m_account = a;
    }
}

QString ESApplication::account() const
{
    return m_account;
}

void ESApplication::setDesc(const QString &a)
{
    if (a != m_desc)
    {
        m_desc = a;
    }
}

QString ESApplication::desc() const
{
    return m_desc;
}

void ESApplication::setCategory(const QString &a)
{
    if (a != m_category)
    {
        m_category = a;
    }
}

QString ESApplication::category() const
{
    return m_category;
}

void ESApplication::setTrxDateTime(const QString &a)
{
    m_trxDateTime = QDateTime::fromString(a.left(10), "yyyy-MM-dd");
}

QString ESApplication::trxDateTime() const
{
    return m_trxDateTime.toString("dd-MM-yyyy");
}

void ESApplication::setAmount(const QString &a)
{
    m_amount = a.toInt();
}

QString ESApplication::amount() const
{
    return QString::number(m_amount);
}

void ESApplication::setDataList(const QVariantList &a)
{
    m_dataList = a;
}

QVariantList ESApplication::dataList() const
{
    return m_dataList;
}

void ESApplication::setLabelList(const QVariantList &a)
{
    m_labelList = a;
}

QVariantList ESApplication::labelList() const
{
    return m_labelList;
}

void ESApplication::createLocalDBIfNotAvailable()
{
    QString localDataPath = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    QDir localDataDir(localDataPath);
    if(!localDataDir.exists(localDataPath))
    {
        localDataDir.mkdir(localDataPath);
        qDebug()<<"Local Data Dir created.";
    }

    if(!QFile::exists(localDataPath+"/expenses.db"))
    {
        QFile::copy("/usr/share/UIApp/expenses.db", localDataPath+"/expenses.db");
        qDebug()<<"Local DB File created.";
    }
}

void ESApplication::setTrxType(const QString &a)
{
    if(a != m_trxType)
    {
        m_trxType = a;
    }
}

void ESApplication::addTransaction()
{
    QString trxType = m_trxType.compare("+")!=0?"expense":"income";

//    query : insert into transactions(Account, Category, Description, Date, TrxType, Amount)
//    values("Account", "Category", "Description", "Date", "TrxType", int Amount);
    QString queryString = "insert into transactions(Account, Category, Description, Date, "
                          " TrxType, Amount) values('"+m_account+"', '"+m_category+"', '"+m_desc+
            "', "+QString::number(m_trxDateTime.toMSecsSinceEpoch()/1000)+", '"
            +trxType+"', "+QString::number(m_amount)+")";

    QSqlQuery query(db);
    if(!query.exec(queryString))
    {
        qDebug()<<"SQL insert into transactions query failed!";
    }
}
