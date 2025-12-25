import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Rectangle {
    id: root
    width: 1920
    height: 1080

    LayoutMirroring.enabled: Qt.locale().textDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property int sessionIndex: session.index

    TextConstants { id: textConstants }
    Keyboard { id: keyboard }

    Connections {
        target: sddm
        function onLoginSucceeded() {}
        function onLoginFailed() {
            password.text = ""
            password.focus = true
            errorMessage.text = textConstants.loginFailed
        }
    }

    // Background Image
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "/usr/share/wallpapers/loginscreen.png"
        fillMode: Image.PreserveAspectCrop
        smooth: true
    }

    // Blur overlay
    Rectangle {
        anchors.fill: parent
        color: "#40000000"
    }

    // Main container
    Item {
        anchors.fill: parent

        // Top section - Clock and Date
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 80
            spacing: 10

            Text {
                id: timeLabel
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                font.pixelSize: 72
                font.bold: true
                font.family: "JetBrains Mono"

                function updateTime() {
                    text = Qt.formatDateTime(new Date(), "hh:mm")
                }
            }

            Text {
                id: dateLabel
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                font.pixelSize: 24
                font.family: "JetBrains Mono"

                function updateDate() {
                    text = Qt.formatDateTime(new Date(), "dddd, MMMM d, yyyy")
                }
            }

            Timer {
                interval: 1000
                repeat: true
                running: true
                onTriggered: {
                    timeLabel.updateTime()
                    dateLabel.updateDate()
                }
                Component.onCompleted: {
                    timeLabel.updateTime()
                    dateLabel.updateDate()
                }
            }
        }

        // Login panel
        Rectangle {
            id: loginPanel
            anchors.centerIn: parent
            width: 400
            height: 280
            radius: 12
            color: "#CC1a1a1a"
            border.color: "#33ccff"
            border.width: 2

            ColumnLayout {
                anchors.centerIn: parent
                width: parent.width - 80
                spacing: 20

                // Session selector
                ComboBox {
                    id: session
                    Layout.fillWidth: true
                    height: 40
                    font.pixelSize: 14
                    font.family: "JetBrains Mono"
                    model: sessionModel
                    currentIndex: sessionModel.lastIndex
                    textRole: "name"

                    background: Rectangle {
                        color: "#2a2a2a"
                        border.color: session.activeFocus ? "#33ccff" : "#555555"
                        border.width: 2
                        radius: 6
                    }

                    contentItem: Text {
                        leftPadding: 10
                        text: session.displayText
                        color: "white"
                        font: session.font
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                // Username field
                TextField {
                    id: username
                    Layout.fillWidth: true
                    height: 40
                    font.pixelSize: 14
                    font.family: "JetBrains Mono"
                    placeholderText: textConstants.userName
                    selectByMouse: true
                    color: "white"
                    placeholderTextColor: "#888888"

                    background: Rectangle {
                        color: "#2a2a2a"
                        border.color: username.activeFocus ? "#33ccff" : "#555555"
                        border.width: 2
                        radius: 6
                    }

                    Keys.onReturnPressed: password.focus = true
                }

                // Password field
                TextField {
                    id: password
                    Layout.fillWidth: true
                    height: 40
                    font.pixelSize: 14
                    font.family: "JetBrains Mono"
                    placeholderText: textConstants.password
                    echoMode: TextInput.Password
                    selectByMouse: true
                    color: "white"
                    placeholderTextColor: "#888888"
                    focus: true

                    background: Rectangle {
                        color: "#2a2a2a"
                        border.color: password.activeFocus ? "#33ccff" : "#555555"
                        border.width: 2
                        radius: 6
                    }

                    Keys.onReturnPressed: loginButton.clicked()
                }

                // Error message
                Text {
                    id: errorMessage
                    Layout.fillWidth: true
                    color: "#ff5555"
                    font.pixelSize: 12
                    font.family: "JetBrains Mono"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    visible: text !== ""
                }

                // Login button
                Button {
                    id: loginButton
                    Layout.fillWidth: true
                    height: 40
                    text: textConstants.login

                    contentItem: Text {
                        text: loginButton.text
                        font.pixelSize: 14
                        font.family: "JetBrains Mono"
                        font.bold: true
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        color: loginButton.down ? "#2299cc" : (loginButton.hovered ? "#44ddff" : "#33ccff")
                        radius: 6
                    }

                    onClicked: {
                        errorMessage.text = ""
                        sddm.login(username.text, password.text, sessionIndex)
                    }
                }
            }
        }

        // Bottom info
        RowLayout {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 40
            spacing: 20

            // Keyboard layout button
            Button {
                width: 40
                height: 40
                text: keyboard.layouts[keyboard.currentLayout].shortName
                font.pixelSize: 14
                visible: keyboard.layouts.length > 1

                background: Rectangle {
                    color: parent.down ? "#2a2a2a" : (parent.hovered ? "#3a3a3a" : "#1a1a1a")
                    border.color: "#555555"
                    border.width: 2
                    radius: 20
                }

                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: keyboard.currentLayout = (keyboard.currentLayout + 1) % keyboard.layouts.length
            }

            // Power menu
            RowLayout {
                spacing: 20

                // Suspend
                Button {
                    width: 40
                    height: 40
                    text: "⏾"
                    font.pixelSize: 20
                    visible: sddm.canSuspend

                    background: Rectangle {
                        color: parent.down ? "#2a2a2a" : (parent.hovered ? "#3a3a3a" : "#1a1a1a")
                        border.color: "#555555"
                        border.width: 2
                        radius: 20
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: sddm.suspend()
                }

                // Reboot
                Button {
                    width: 40
                    height: 40
                    text: "⟳"
                    font.pixelSize: 20
                    visible: sddm.canReboot

                    background: Rectangle {
                        color: parent.down ? "#2a2a2a" : (parent.hovered ? "#3a3a3a" : "#1a1a1a")
                        border.color: "#555555"
                        border.width: 2
                        radius: 20
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: sddm.reboot()
                }

                // Shutdown
                Button {
                    width: 40
                    height: 40
                    text: "⏻"
                    font.pixelSize: 20
                    visible: sddm.canPowerOff

                    background: Rectangle {
                        color: parent.down ? "#2a2a2a" : (parent.hovered ? "#3a3a3a" : "#1a1a1a")
                        border.color: "#555555"
                        border.width: 2
                        radius: 20
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: sddm.powerOff()
                }
            }
        }
    }

    Component.onCompleted: {
        if (username.text === "")
            username.focus = true
        else
            password.focus = true
    }
}
