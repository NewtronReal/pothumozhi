import QtQuick 2.15
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
import QtQuick.Window 2.15
import NewIntegrations 1.0
import "qml-models"

Window {
    id: window
    visible: true
    flags: Qt.FramelessWindowHint
    width: 640
    height: 480
    minimumHeight: 400
    minimumWidth:400
    title: qsTr("Stack")
    color: "transparent"
    property int bw: 5

    Integrations{
        id:integrations
    }

    function toggleMaximized() {
        if (window.visibility === Window.Maximized) {
            window.showNormal();
        } else {
            window.showMaximized();
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: {
            const p = Qt.point(mouseX, mouseY);
            const b = bw + 10;
            if (p.x < b && p.y < b) return Qt.SizeFDiagCursor;
            if (p.x >= width - b && p.y >= height - b) return Qt.SizeFDiagCursor;
            if (p.x >= width - b && p.y < b) return Qt.SizeBDiagCursor;
            if (p.x < b && p.y >= height - b) return Qt.SizeBDiagCursor;
            if (p.x < b || p.x >= width - b) return Qt.SizeHorCursor;
            if (p.y < b || p.y >= height - b) return Qt.SizeVerCursor;
        }
        acceptedButtons: Qt.NoButton
    }

    DragHandler {
        id: resizeHandler
        grabPermissions: TapHandler.TakeOverForbidden
        target: null
        onActiveChanged: if (active) {
                             const p = resizeHandler.centroid.position;
                             const b = bw + 10;
                             let e = 0;
                             if (p.x < b) { e |= Qt.LeftEdge }
                             if (p.x >= width - b) { e |= Qt.RightEdge }
                             if (p.y < b) { e |= Qt.TopEdge }
                             if (p.y >= height - b) { e |= Qt.BottomEdge }
                             window.startSystemResize(e);
                         }
    }
    Rectangle{
        id: rectangle3
        radius: 10
        anchors.fill:parent
        anchors.margins:5
        layer.enabled:true
        layer.effect:DropShadow{
            id: dropShadow
            color:"grey"
            radius:5
            samples:10
        }

        Item {
            id: item1
            y: 0
            height: 40
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0
            anchors.rightMargin: 0

            MouseArea {
                id: mouseArea3
                anchors.fill: parent
                anchors.margins:5
                onPressed:startSystemMove()

                Item {
                    id: item2
                    x: 525
                    y: 7
                    width: 100
                    height: 25
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 5

                    Rectangle {
                        id: rectangle
                        x: 67
                        y: 5
                        width: 20
                        height: 20
                        color: "#667eea"
                        radius: 12.5
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        gradient: Gradient {
                            GradientStop {
                                position: 0
                                color: "#a445b2"
                            }

                            GradientStop {
                                position: 0.52
                                color: "#d41872"
                            }

                            GradientStop {
                                position: 1
                                color: "#ff0066"
                            }
                        }
                        anchors.rightMargin: 6

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            onClicked:window.close()
                        }
                    }

                    Rectangle {
                        id: rectangle1
                        x: 50
                        y: 13
                        width: 18
                        height: 18
                        color: "#667eea"
                        radius: 12.5
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: rectangle.left
                        gradient: Gradient {
                            GradientStop {
                                position: 0
                                color: "#667eea"
                            }

                            GradientStop {
                                position: 1
                                color: "#764ba2"
                            }
                        }
                        anchors.verticalCenterOffset: 0
                        MouseArea {
                            id: mouseArea1
                            anchors.fill: parent
                            onClicked:{
                                window.toggleMaximized()
                            }
                        }
                        anchors.rightMargin: 6
                    }

                    Rectangle {
                        id: rectangle2
                        x: 26
                        y: 13
                        width: 18
                        height: 18
                        color: "#667eea"
                        radius: 12.5
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: rectangle1.left
                        gradient: Gradient {
                            GradientStop {
                                position: 0
                                color: "#209cff"
                            }

                            GradientStop {
                                position: 1
                                color: "#68e0cf"
                            }
                        }
                        MouseArea {
                            id: mouseArea2
                            anchors.fill: parent
                            onClicked:window.showMinimized()
                        }
                        anchors.verticalCenterOffset: 0
                        anchors.rightMargin: 6
                    }
                }
                Rectangle {
                    id: rectangle4
                    color: "#e2e1e1"
                    radius: 10
                    anchors.left: text1.right
                    anchors.right: item2.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 12
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    layer.enabled:true
                    layer.effect:DropShadow{
                        samples:10
                        radius:5
                        color:textInput.activeFocus ? "gray":"transparent"
                    }

                    TextInput {
                        id: textInput
                        anchors.fill: parent
                        anchors.margins:5
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 8
                        anchors.leftMargin: 8
                        onTextChanged:{
                            listModel.clear()
                            var translations = JSON.parse(integrations.readFile(":/translations.json"))
                            for(var i in translations){
                                if(i.toLowerCase().includes(textInput.text.toLowerCase())||translations[i].translation.toLowerCase().includes(textInput.text.toLowerCase()))
                                    listModel.append({word:i,translation:translations[i].translation,description:translations[i].description||""})
                            }
                        }

                        Text{
                            anchors.fill:parent
                            verticalAlignment: Text.AlignVCenter
                            color:"gray"
                            text: "ഇവിടെ പരതൂ....."
                            visible:parent.text == ""
                        }
                    }
                }

                Text {
                    id: text1
                    y: 2
                    text: qsTr("പുതുമൊഴി")
                    anchors.left: parent.left
                    font.pixelSize: 30
                    anchors.leftMargin: 16
                    font.bold: true
                }
            }
        }

        Rectangle {
            id: rectangle5
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 46
            anchors.bottomMargin: 8
            anchors.leftMargin: 8
            anchors.rightMargin: 8

            Item {
                id: item3
                height: 110
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rectangle6.bottom
                anchors.topMargin: 8
                anchors.rightMargin: 0
                anchors.leftMargin: 0

                ListView{
                    property var selectedItem
                    x: 0
                    y: 35
                    onSelectedItemChanged:{
                        meaning.text = selectedItem.meaning
                        englishword.text = selectedItem.engmeaning
                        descript.text = selectedItem.descript
                    }

                    height: 75
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 35
                    id:listView
                    focus:true
                    Keys.enabled:true
                    model:ListModel{
                        id:listModel
                    }
                    clip:true
                    delegate:ListItem{}
                    orientation:ListView.LeftToRight
                    Component.onCompleted:{
                        var translations = JSON.parse(integrations.readFile(":/translations.json"))
                        for(var i in translations){
                            listModel.append({word:i,translation:translations[i].translation,description:translations[i].description||""})
                        }
                    }
                }

                ListView {
                    property var selectedItem
                    id: listView1
                    height: 35
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    model: ListModel{
                        ListElement{
                            languageName:"മലയാളം"
                            tooltipenabled:false
                            languageNameEng:"Malayalam"
                            description:"ഇന്ത്യയിൽ പ്രധാനമായും കേരള സംസ്ഥാനത്തിലും ലക്ഷദ്വീപിലും പുതുച്ചേരിയുടെ ഭാഗമായ മയ്യഴിയിലും സംസാരിക്കപ്പെടുന്ന ഭാഷയാണ് മലയാളം. ഇതു ദ്രാവിഡ ഭാഷാ കുടുംബത്തിൽപ്പെടുന്നു. ഇന്ത്യയിൽ ശ്രേഷ്ഠഭാഷാ പദവി ലഭിക്കുന്ന അഞ്ചാമത്തെ ഭാഷയാണ് മലയാളം[5]."
                        }
                        ListElement{
                            languageName:"தமிழ்"
                            tooltipenabled:false
                            languageNameEng:"Tamil"
                            description:"இக்கட்டுரை தமிழ் மொழி பற்றியது. ஏனைய பயன்பாடுகளுக்கு தமிழ் (மாற்றுப் பயன்பாடுகள்) பக்கத்தைப் பாருங்கள்.தமிழ் மொழி (Tamil language) தமிழர்களினதும், தமிழ் பேசும் பலரதும் தாய்மொழி ஆகும். தமிழ் திராவிட மொழிக் குடும்பத்தின் முதன்மையான மொழிகளில் ஒன்றும் செம்மொழியும் ஆகும்."
                        }
                        ListElement{
                            languageName:"தతెಕമ"
                            tooltipenabled:true
                            tooltiptext:"NeoDravidian"
                            languageNameEng:"NeoDravidian"
                            description:"NeoDravidian is a new language formed from dravidian languages. It is equally owed to everey dravidian languages. It uses indus script as its default script which is now in under decryption. Until then we use our own scripts."
                        }
                    }
                    orientation:ListView.LeftToRight
                    clip:true
                    delegate: LanguageBar{}
                    onSelectedItemChanged:{
                        meaning.text = selectedItem.language
                        englishword.text = selectedItem.languageEng
                        descript.text = selectedItem.descrip
                    }

                    Component.onCompleted:{
                        selectedItem = currentItem
                    }
                }
            }

            Rectangle {
                id: rectangle6
                height: 200
                color: "#8a66fb"
                radius: 14
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                clip:true

                Text {
                    id: meaning
                    y: 132
                    height: 37
                    color: "#ffffff"
                    text: qsTr("മലയാളം")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    font.pixelSize: 44
                    fontSizeMode:Text.HorizontalFit
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Manjari"
                    font.bold: true
                    anchors.leftMargin: 8
                }

                Image {
                    id: image
                    y: 81
                    width: 32
                    height: 32
                    anchors.verticalCenter: meaning.verticalCenter
                    anchors.left: meaning.right
                    source: "src/speaker-disabled.svg"
                    anchors.leftMargin: 8
                    fillMode: Image.PreserveAspectFit
                }

                ScrollView {
                    id: scrollView
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: meaning.bottom
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 8
                    anchors.bottomMargin: 8
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    clip:true

                    Text {
                        id: descript
                        x: 0
                        color: "#ffffff"
                        text: qsTr("ഇന്ത്യയിൽ പ്രധാനമായും കേരള സംസ്ഥാനത്തിലും ലക്ഷദ്വീപിലും പുതുച്ചേരിയുടെ ഭാഗമായ മയ്യഴിയിലും സംസാരിക്കപ്പെടുന്ന ഭാഷയാണ് മലയാളം. ഇതു ദ്രാവിഡ ഭാഷാ കുടുംബത്തിൽപ്പെടുന്നു. ഇന്ത്യയിൽ ശ്രേഷ്ഠഭാഷാ പദവി ലഭിക്കുന്ന അഞ്ചാമത്തെ ഭാഷയാണ് മലയാളം[5].")
                        anchors.left: parent.left
                        width:parent.parent.width-16
                        anchors.top: parent.top
                        font.pixelSize: 14
                        wrapMode: Text.WordWrap
                        anchors.topMargin: 0
                        styleColor: "#ffffff"
                        font.bold: false
                        font.family: "Manjari"
                        anchors.leftMargin: 0
                        anchors.rightMargin: 0
                    }
                }

                Text {
                    id: englishword
                    y: 60
                    text: qsTr("Malayalam")
                    color:"#f1efef"
                    anchors.left: parent.left
                    anchors.bottom: meaning.top
                    font.pixelSize: 28
                    font.bold: true
                    font.family: "Manjari"
                    fontSizeMode:Text.HorizontalFit
                    anchors.leftMargin: 8
                    anchors.bottomMargin: 6
                }

                ScrollView {
                    id: scrollView1
                    x: 8
                    y: 72
                    width: 200
                    height: 200
                }
            }
        }
    }
}
