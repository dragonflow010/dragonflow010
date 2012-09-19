import Qt 4.7
import "mainwnd.js" as Logic
import "plugin" 1.0
import com.siteview.qmlcomponents 1.0

Rectangle{
    property string toolTip:""
    property bool bFirstStart:false

    property string strTxt:""
    property bool bupTitle: false
    property string strLan:""
    property string s:"pic/right.png"
    property bool bShow: true
    property bool bLDis: true
    property bool bRDis: true
    property string strButTxt: "Exit"

    id:mainwnd;
    width: 800; height: 600

    y:0
    x:0
    //603, 389
    color:"black"

    property string language:"Language:"

    function setTwoButState(lState, rState)
    {
        bLDis = lState
        bRDis = rState
    }
    function createModelView(source,query,ref)
    {
        Logic.createModelView(source,query,ref);
        console.log("mainwnd function")
    }
    function initsMy(lan)
    {
        bupTitle = false
        var s = lan
        var k;
        s = s + '.xml'
        k = "language/" + s
        strLan = k;
        Logic.clearAll();
        Logic.createModelView(k, "/data/main/item", mainwnd)
    }
    function getUILanMy(uitxt)
    {
        var s = uitxt
        console.log("SSSSSSSSSSSSSSSSSS"+s)
        var temp = s.split(";")
        language = temp[0] + ":"
    }
    function deleteLayers(ref)
    {
        console.log("mainwnd deletelayers" + " " +ref)
        Logic.deleteLayers(ref)
    }

    function getScale(curidx,view,ref)
    {
        console.log("mainwnd getscale")
        return Logic.getScale(curidx,view,ref)
    }
    function inits()
    {
        var k
        k="language/ENU.xml"
        Logic.clearAll();
        console.log("mainwnd inits deletelaysers")
        Logic.createModelView(k,"/data/main/item",mainwnd)

    }
    function setShow(b)
    {
        bShow = b
    }
    QShellExe{id:per;}

    function shellExe(exename, mode)
    {
        console.log("shelle" + "   " + mode)
        per.ShellExe(exename, mode)
    }
    function exit()
    {
        per.ExitExe();
    }
    function refresh()
    {
        console.log("refresh")
        Logic.refresh();
    }
    function getUILan()
    {
        var s = list.uitxt
        console.log("SSSSSSSSSSSSSSSSSS"+s)
        var temp = s.split(";")
        language = temp[0] + ":"
    }
    function setTooltip(strTooptip)
    {
        console.log("mainwnd.qml setTooltip")
        toolTip = strTooptip
        console.log(toolTip)
    }
    function setupTitle(strTitle, strBut)
    {
        console.log("---------------------"+"main"+strTitle);
        strTxt = strTitle
        strButTxt = strBut
        console.log("---------------" + "main" + strTxt.length);
    }
    function getlinkSource()
    {

        return strLan
    }
    MouseArea{
        id:mousearea;
        acceptedButtons:Qt.RightButton
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            refresh();
        }
        onPressed: {
            Logic.deleteTopLayer();
        }


    }

    Title{
        x: 430
        y:20
        width:350
        z:500
        titleTxt:strTxt
    }

    Image {
        width: 800; height: 600
        source: "pic/bg.png"

    }

    HoverButton{
        id:left
        width:30;height:30
        normal_ico: bLDis ? "../pic/left.png" : "../pic/left_hover.png"
        hover_ico: bLDis ? "../pic/left.png" : "../pic/left_hover.png"
        pressed_ico: bLDis ? "../pic/left.png" : "../pic/left_pressed.png"
        anchors.left:parent.left
        anchors.bottom:parent.bottom
        anchors.leftMargin: 8
        anchors.bottomMargin: 300
        visible: bShow

        onButtonClick: {
            Logic.arrowPressed(1) //1:left 2:right
        }
    }
    HoverButton{
        id:right
        width:30;height:30
        normal_ico: bRDis ? "../pic/right.png" : "../pic/right_hover.png"
        hover_ico: bRDis ? "../pic/right.png" : "../pic/right_hover.png"
        pressed_ico: bRDis ? "../pic/right.png" : "../pic/right_pressed.png"
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.rightMargin: 8

        anchors.bottomMargin: 300
        visible: bShow

        onButtonClick: {
            Logic.arrowPressed(2) //1:left 2:right
        }
    }
    Keys.onPressed: {
        Logic.onKeyPressed(event.key)
    }

    //    Rectangle
    //    {
    //        id:languageRec
    //        z:2
    //        anchors.bottom:parent.bottom
    //        anchors.bottomMargin:35
    //        anchors.right:parent.right
    //        anchors.rightMargin:125
    //        MyList{
    //            id:list
    //            width:100

    //            onCurrentIndexChanged:{mainwnd.inits();mainwnd.getUILan();}

    //        }
    //    }


    HoverButton{
        id: exitButton
        width:75;height:25
        normal_ico:"../pic/quit_pressed1.png"
        hover_ico:"../pic/quit_pressed2.png"
        pressed_ico:"../pic/quit_pressed3.png"
        label:strButTxt
        anchors.bottom:parent.bottom
        anchors.left:parent.left
        anchors.leftMargin: 11
        anchors.bottomMargin: 13

        onButtonClick:{mainwnd.exit();}
    }
    Text{
        anchors.horizontalCenter:parent.horizontalCenter
        anchors.bottom:parent.bottom
        anchors.bottomMargin:10
        color:"white"
        id:t
        text:toolTip
        font.bold:true
        font.pointSize:20
    }

    Component.onCompleted:{
        Logic.clearAll();
        mainwnd.inits();
        console.log("component")
    }


}
