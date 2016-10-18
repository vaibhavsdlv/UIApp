#include <QGuiApplication>
#include "esapplication.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    ESApplication appy((QObject*)&app);

    return app.exec();
}
