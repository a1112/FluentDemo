import QtQuick
import QtQuick.Layouts
import FluentUI
import taoQuick
import org.wangwenx190.FramelessHelper

FluWindow {

    id:window

    width: 640
    height: 480
    title:"FluentDemo"

    FluAppBar {
        id: title_bar
        title: window.title
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        showDark: true
    }
    ColumnLayout{
                anchors.centerIn: parent
    FluButton{

        text:"hello world"
        onClicked: {
            showSuccess("hello TaoQuick FlutUi")
        }
    }
    CusButton_Blue {
        width: 120
        height: 36

        text: "Hello"
        onClicked: {
            showSuccess("hello TaoQuick")
        }
    }
    }
    FramelessHelper{
        id:framless_helper
        onReady: {
            setTitleBarItem(title_bar)
            moveWindowToDesktopCenter()
            setHitTestVisible(title_bar.minimizeButton())
            setHitTestVisible(title_bar.maximizeButton())
            setHitTestVisible(title_bar.closeButton())
            setHitTestVisible(title_bar.darkButton())
            if (blurBehindWindowEnabled)
                window.backgroundVisible = false
            window.show()
        }
    }

    Connections{
        target: FluTheme
        function onDarkChanged(){
            if (FluTheme.dark)
                FramelessUtils.systemTheme = FramelessHelperConstants.Dark
            else
                FramelessUtils.systemTheme = FramelessHelperConstants.Light
        }
    }

    Component.onCompleted: {
//        FluApp.init(app)
//        FluApp.routes = {
//            "/":"qrc:/qml/Window/MainWindow.qml",
//        }
//        FluApp.initialRoute = "/"
//        FluApp.run()
    }
}
