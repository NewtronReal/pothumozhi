import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    property var meaning:translation
    property var engmeaning:word
    property var descript:description
    id: item1
    height:75
    width:125
    MouseArea{
        anchors.fill:parent
        onClicked:listView.selectedItem = parent
        DropShadow{
            id:mainShadow
            samples:10
            radius:5
            color:"transparent"
            anchors.fill:mainrect
            source:mainrect
        }
        Rectangle{
            id: mainrect
            anchors.fill:parent
            radius:10
            anchors.margins:5
            border.color:"#6537f7"

            Image {
                id: image1
                anchors.fill:parent
                x: 5
                y: 5
                width: 100
                height: 100
                source: "qrc:/background.svg"
                smooth:true
                visible:false
            }
            OpacityMask{
                id:opacityMask
                source:image1
                maskSource:mainrect
                anchors.fill:image1
                visible:false
            }

            Text {
                id: text1
                x: 0
                font.bold:true
                font.family:"Manjari"
                y: 0
                text: qsTr(word)
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.topMargin: 6
            }

            Text {
                id: text2
                y: 27
                font.family:"Manjari"
                font.bold:true
                text: qsTr(translation)
                anchors.left: parent.left
                anchors.right: parent.right
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 6
                anchors.leftMargin: 6
            }

            Rectangle {
                id: rectangle1
                x: 13
                y: 44
                width: 75
                height: 15
                color: "#667eea"
                radius: 11.5
                anchors.bottom: parent.bottom
                anchors.horizontalCenterOffset: 0
                anchors.bottomMargin: 6
                anchors.horizontalCenter: parent.horizontalCenter
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#5f72bd"
                    }

                    GradientStop {
                        position: 1
                        color: "#9b23ea"
                    }
                }

                Text {
                    id: text3
                    y: 0
                    color: "#ffffff"
                    text: qsTr("പറയൂ")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: image.right
                    font.pixelSize: 12
                    font.bold: true
                    anchors.leftMargin: 5
                }

                Image {
                    id: image
                    x: 8
                    y: 2
                    width: 12
                    height: 12
                    smooth:true
                    source: "qrc:/speaker-enabled.svg"
                    fillMode: Image.PreserveAspectFit
                }
            }

        }
    }
    states: [
        State {
            name: "State1"
            PropertyChanges{
                target:mainShadow
                color:"gray"
            }
            PropertyChanges{
                target:mainrect
                border.color:"transparent"
            }

            PropertyChanges{
                target:opacityMask
                visible:true
            }
            PropertyChanges{
                target:text1
                color:"white"
            }
            PropertyChanges{
                target:text2
                color:"white"
            }
        }
    ]
    Component.onCompleted:{
        listView.selectedItemChanged.connect(afterFunction)
    }
    function afterFunction(){
        if(listView.selectedItem == item1){
            item1.state = "State1"
        }else{
            item1.state = ""
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:3;height:75;width:125}
}
##^##*/
