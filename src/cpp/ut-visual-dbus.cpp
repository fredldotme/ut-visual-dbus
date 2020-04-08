#include "dbusserviceinspector.h"
#include <QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QObject>

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qmlRegisterType<DBusServiceInspector>("harbour.visual.dbus.dbusinspector", 1, 0, "DBusInspector");
    qmlRegisterType<InterfaceMember>("harbour.visual.dbus.interfacemember", 1, 0, "InterfaceMember");
    qmlRegisterType<Argument>("harbour.visual.dbus.argument", 1, 0, "Argument");

    QGuiApplication *app = new QGuiApplication(argc, argv);
    QQmlApplicationEngine* newEngine = new QQmlApplicationEngine(app);
    newEngine->load(QUrl("qrc:/qml/ut-visual-dbus.qml"));
    return app->exec();
}

