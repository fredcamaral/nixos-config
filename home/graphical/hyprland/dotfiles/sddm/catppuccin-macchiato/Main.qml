import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import SddmComponents 2.0

Rectangle {
    id: root
    color: "#181926"  // Catppuccin Macchiato crust color

    TextConstants { id: textConstants }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            Image {
                anchors.fill: parent
                source: config.background
                fillMode: Image.PreserveAspectCrop
            }
        }

        Rectangle {
            Layout.preferredWidth: 400
            Layout.fillHeight: true
            color: "#24273a"  // Catppuccin Macchiato base color

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                Image {
                    Layout.alignment: Qt.AlignHCenter
                    source: "logo.png"
                    sourceSize.width: 128
                    sourceSize.height: 128
                }

                TextField {
                    Layout.preferredWidth: 300
                    placeholderText: textConstants.userName
                    text: userModel.lastUser
                    color: "#cad3f5"  // Catppuccin Macchiato text color
                    background: Rectangle {
                        color: "#363a4f"  // Catppuccin Macchiato surface0 color
                        radius: 5
                    }
                }

                TextField {
                    Layout.preferredWidth: 300
                    placeholderText: textConstants.password
                    echoMode: TextInput.Password
                    color: "#cad3f5"  // Catppuccin Macchiato text color
                    background: Rectangle {
                        color: "#363a4f"  // Catppuccin Macchiato surface0 color
                        radius: 5
                    }
                }

                Button {
                    Layout.preferredWidth: 300
                    text: textConstants.login
                    onClicked: sddm.login(userNameText.text, passwordText.text, sessionModel.lastIndex)
                    background: Rectangle {
                        color: "#8aadf4"  // Catppuccin Macchiato blue color
                        radius: 5
                    }
                }
            }
        }
    }
}