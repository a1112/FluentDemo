#include "qqmlcontext.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <FramelessHelper/Quick/framelessquickmodule.h>
#include <FramelessHelper/Core/private/framelessconfig_p.h>
FRAMELESSHELPER_USE_NAMESPACE

    int main(int argc, char *argv[])
{
    //将样式设置为Basic，不然会导致组件显示异常
    qputenv("QT_QUICK_CONTROLS_STYLE","Basic");
    FramelessHelper::Quick::initialize();
//    QGuiApplication::setOrganizationName("ZhuZiChu");
//    QGuiApplication::setOrganizationDomain("https://zhuzichu520.github.io");
//    QGuiApplication::setApplicationName("FluentUI");
    QGuiApplication app(argc, argv);
#ifdef Q_OS_WIN // 此设置仅在Windows下生效
    FramelessConfig::instance()->set(Global::Option::ForceHideWindowFrameBorder);
#endif
    FramelessConfig::instance()->set(Global::Option::DisableLazyInitializationForMicaMaterial);
    FramelessConfig::instance()->set(Global::Option::CenterWindowBeforeShow);
    FramelessConfig::instance()->set(Global::Option::ForceNonNativeBackgroundBlur);
    FramelessConfig::instance()->set(Global::Option::EnableBlurBehindWindow);
#ifdef Q_OS_MACOS
    FramelessConfig::instance()->set(Global::Option::ForceNonNativeBackgroundBlur,false);
#endif
    QQmlApplicationEngine engine;

    engine.addImportPath(TaoQuickImportPath);

    engine.rootContext()->setContextProperty("taoQuickImportPath", TaoQuickImportPath);
    FramelessHelper::Quick::registerTypes(&engine);
    const QUrl url(u"qrc:/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
