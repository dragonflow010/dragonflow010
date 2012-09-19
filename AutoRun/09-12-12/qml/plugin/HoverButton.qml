import Qt 4.7

Item{
    id: container

    property string normal_ico: ""
    property string hover_ico: ""
    property string pressed_ico: ""
    property string label:""

    property bool bExit:false
    height:20
    width:20
    signal buttonClick

    BorderImage{
        id:buttonImage
        width: container.width; height: container.height
        source: normal_ico
        visible: true
    }
    BorderImage{
        id:buttonImage_hover
        width: container.width; height: container.height
        source: hover_ico
        visible: false
    }
    BorderImage{
        id:buttonImage_pressed
        width: container.width; height: container.height
        source: pressed_ico
        visible: false
    }
    Text{
        id: buttonLabel
        color: "white"
        font.bold:true
        anchors.centerIn:parent
        text:label
    }
    MouseArea{
        id: buttonMouseArea
        anchors.fill:parent
        onClicked:buttonClick()

        hoverEnabled:true

        onEntered:{
            buttonImage.visible = false;
            buttonImage_pressed.visible = false;
            buttonImage_hover.visible = true;
        }
        onExited:{
            bExit = true;
            buttonImage.visible = true;
            buttonImage_hover.visible = false;
            buttonImage_pressed.visible = false
        }
        onPressed:{
            buttonImage.visible = false;
            buttonImage_hover.visible = false;
            buttonImage_pressed.visible = true
        }
        onReleased:{
            if(!bExit)
            {
                buttonImage_hover.visible = true;
                buttonImage.visible = false;
                buttonImage_pressed.visible = false;
            }
            else
            {
                buttonImage_hover.visible = false;
                buttonImage.visible = true;
                buttonImage_pressed.visible = false;
                bExit = false;
            }
        }
    }
}
