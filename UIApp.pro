TEMPLATE = app

QT += qml quick widgets sql

TARGET = UIApp

CONFIG += sailfishapp_no_deploy_qml sailfishapp

desktop.files = UIApp.desktop

SOURCES += \
    main.cpp \
    movementlistmodel.cpp \
    esapplication.cpp

RESOURCES += \
    resources.qrc

DISTFILES +=

HEADERS += \
    movementlistmodel.h \
    esapplication.h

OTHER_FILES += \
    rpm/UIApp.yaml \
    UIApp.desktop \
    expenses.db

DEPLOYMENT_PATH = /usr/share/$${TARGET}

data.files = expenses.db
data.path = $${DEPLOYMENT_PATH}

INSTALLS += data

