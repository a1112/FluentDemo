import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import FluentUI

Button {
    property bool disabled: false
    property string contentDescription: ""
    property color normalColor: FluTheme.dark ? FluTheme.primaryColor.lighter : FluTheme.primaryColor.dark
    property color hoverColor: FluTheme.dark ? Qt.darker(normalColor,1.15) : Qt.lighter(normalColor,1.15)
    property color pressedColor: FluTheme.dark ? Qt.darker(normalColor,1.3) : Qt.lighter(normalColor,1.3)
    property color disableColor: FluTheme.dark ? Qt.rgba(82/255,82/255,82/255,1) : Qt.rgba(199/255,199/255,199/255,1)
    property bool textBold: true
    property color textColor: {
        if(disabled){
            return disableColor
        }
        if(pressed){
            return pressedColor
        }
        return hovered ? hoverColor :normalColor
    }
    id: control
    horizontalPadding:2
    enabled: !disabled
    Keys.onSpacePressed: control.visualFocus&&clicked()
    background: Item{
        implicitWidth: 28
        implicitHeight: 28
        FluFocusRectangle{
            visible: control.visualFocus
            radius:8
        }
    }
    focusPolicy:Qt.TabFocus
    Accessible.role: Accessible.Button
    Accessible.name: control.text
    Accessible.description: contentDescription
    Accessible.onPressAction: control.clicked()
    contentItem: FluText {
        id:btn_text
        text: control.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: control.textBold
        color: control.textColor
    }
}
