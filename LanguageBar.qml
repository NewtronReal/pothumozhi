import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
Item {
    id:item1
    property var language:languageName
    property var languageEng:languageNameEng
    property var descrip:description
    width:text1.width + 50
    height:35
    DropShadow{
        id:dropShadow
        anchors.fill:rectangle
        source:rectangle
        color:"gray"
        samples:10
        radius:0
    }
    Rectangle{
        id: rectangle
        anchors.fill:parent
        anchors.margins:5
        color:"white"
        border.color:"#6537f7"
        radius: 12.5

        MouseArea{
            property var hovered:false
            hoverEnabled:true
            anchors.fill:parent
            onEntered:hovered = true
            onExited:hovered = false
            Text {
                id: text1
                x: 16
                y: 5
                color: "#000000"
                text: languageName
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 16
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                fontSizeMode:Text.HorizontalFit
            }
            ToolTip{
                visible:tooltipenabled && parent.hovered
                text:tooltiptext||""
            }
            onClicked:{
                listView1.selectedItem = item1
            }
        }
    }
    states:[
        State{
            name: "hovered"
            PropertyChanges{
                target:rectangle
                color:"#6537f7"
                border.color:"transparent"
            }
            PropertyChanges{
                target:dropShadow
                radius:5
            }
            PropertyChanges{
                target:text1
                color:"white"
            }
        }

    ]
    Component.onCompleted:{
        listView1.selectedItemChanged.connect(changeState)
    }
    function changeState(){
        if(listView1.selectedItem == item1){
            state = "hovered"
        }
        else{
            state = ""
        }
    }
}
