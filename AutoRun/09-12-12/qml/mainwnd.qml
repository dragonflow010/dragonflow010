import Qt 4.7
import "mainwnd.js" as Logic
import "plugin" 1.0
import com.siteview.qmlcomponents 1.0

Rectangle{
    property string toolTip:""
    property bool bFirstStart:false

    property string strTxt:""
    property string strLogoTxt: ""

    property bool bupTitle: false
    property string strLan:""
    property string strL: ""
    property string s:"pic/right.png"
    property string strLanPic: ""


    property bool bShowSub: false
    property bool bShowMain: false
    property bool bLDisSub: true
    property bool bRDisSub: true
    property bool bLDisMain: true
    property bool bRDisMain: true


    property string strButTxt: "Exit"
    property int bNewAgain: 0

    id:mainwnd;
    width: 800; height: 600

    y:0
    x:0
    //603, 389
    color:"black"

    property string language:"Language:"

    //////Control arrow funtion
    function setTwoButState(board, lState, rState)
    {
        ////0:Main 1:sub
        if(board == 0)
        {
            bLDisMain = lState
            bRDisMain = rState
        }
        else
        {
            bLDisSub = lState
            bRDisSub = rState
        }
    }

    function setShow(board, b)
    {
        if(board == 0)
        {
            bShowMain = b
        }
        else
        {
            bShowSub = b
        }
    }
    ///////////End


    function createModelView(source,query,ref)
    {
        bNewAgain = 2;
        Logic.createModelView(source,query,ref);
        console.log("mainwnd function")
    }
    function createNewView()
    {
        initsMy(strL)
    }
    function initsMy(lan)
    {
        bNewAgain = 0;

        bupTitle = false
        var s = lan
        var k;
        strL = lan

        var tmp = "pic/" + lan
        strLanPic = tmp + ".png"

        s = s + '.xml'
        /***********2012-3-12 chensi modify*************/
        s = 'Default.xml'
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
        initsMy("XXX");
        //里面为任何值都可以
        //        var k
        //        k="language/ENU.xml"
        //        Logic.clearAll();
        //        console.log("mainwnd inits deletelaysers")
        //        Logic.createModelView(k,"/data/main/item",mainwnd)

    }



    QShellExe{id:per;}
    QMultiLanguage{id:multiLan;}

    function translateText(txt)
    {
        var strText = multiLan.translateStart(txt);
        return strText;   //返回经过翻译的字符
    }

    function showUpdateDlg(cdPath, chktype)
    {
        console.log("showUpdateDlg:" +cdPath + ' ' + chktype)
        per.UpdateExe(cdPath, chktype)
    }
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

        var temp = s.split(";")
        language = temp[0] + ":"
    }
    function setTooltip(strTooptip)
    {
        console.log("mainwnd.qml setTooltip")

        toolTip = strTooptip

        console.log(toolTip)
    }
    function setupTitle(strLogo, strTitle, strBut)
    {

        strTxt      = strTitle
        strButTxt   = strBut
        strLogoTxt  = strLogo

    }
    function getlinkSource()
    {

        return strLan
    }
    Rectangle{
        width: 800
        height: 480
        x:0
        y:60
        MouseArea{
            id:mousearea;
            acceptedButtons:Qt.LeftButton | Qt.RightButton
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                refresh();
            }
            onPressed: {
                //            bNewAgain = false
                bNewAgain = Logic.deleteTopLayer();
            }


        }
    }



    Title{
//        x: 430
        x: 17
        y: 20
        width:350
        z:500
        titleTxt:strTxt
    }

    Image {
        width: 800; height: 600
        source: "pic/bg.png"

    }

    ////Main logo pic
 //   Image {
  //      id:logoimg
  //      anchors.top: parent.top
  //      anchors.left: parent.left
  //      anchors.topMargin: 9
  //      anchors.leftMargin: 16
  //      source: "pic/logo.png"
  //      fillMode: Image.PreserveAspectFit
  //      smooth: true

  //      visible: false
  //  }
    Text {
        id: logotxt
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 7
        anchors.leftMargin: 14
        text: strLogoTxt
        color:"#a38fff"
        font.family: "Verdana"
        font.bold:true
        font.pointSize:20
        //font.weight:Font.Bold
    }

    ////End

    ////Main Item Control
    HoverButton{
        id:leftmain
        width:30;height:30
        normal_ico: bLDisMain ? "../pic/left.png" : "../pic/left_hover.png"
        hover_ico: bLDisMain ? "../pic/left.png" : "../pic/left_hover1.png"
        pressed_ico: bLDisMain ? "../pic/left.png" : "../pic/left_pressed.png"
        anchors.left:parent.left
        anchors.top:parent.top
        anchors.leftMargin: 2
        anchors.topMargin: 192
        visible: bShowMain

        onButtonClick: {
            Logic.arrowPressed(0, 1) //1:left 2:right
        }
    }
    HoverButton{
        id:rightmain
        width:30;height:30
        normal_ico: bRDisMain ? "../pic/right.png" : "../pic/right_hover.png"
        hover_ico: bRDisMain ? "../pic/right.png" : "../pic/right_hover1.png"
        pressed_ico: bRDisMain ? "../pic/right.png" : "../pic/right_pressed.png"
        anchors.right:parent.right
        anchors.top:parent.top
        anchors.rightMargin: 2

        anchors.topMargin: 192
        visible: bShowMain

        onButtonClick: {
            Logic.arrowPressed(0, 2) //1:left 2:right
        }
    }

    ////Sub Item Control
    HoverButton{
        id:leftsub
        width:30;height:30
        normal_ico: bLDisSub ? "../pic/left.png" : "../pic/left_hover.png"
        hover_ico: bLDisSub ? "../pic/left.png" : "../pic/left_hover1.png"
        pressed_ico: bLDisSub ? "../pic/left.png" : "../pic/left_pressed.png"
        anchors.left:parent.left
        anchors.bottom:parent.bottom
        anchors.leftMargin: 2
        anchors.bottomMargin: 198
        visible: bShowSub

        onButtonClick: {
            Logic.arrowPressed(1, 1) //1:left 2:right
        }
    }
    HoverButton{
        id:rightsub
        width:30;height:30
        normal_ico: bRDisSub ? "../pic/right.png" : "../pic/right_hover.png"
        hover_ico: bRDisSub ? "../pic/right.png" : "../pic/right_hover1.png"
        pressed_ico: bRDisSub ? "../pic/right.png" : "../pic/right_pressed.png"
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.rightMargin: 2

        anchors.bottomMargin: 198
        visible: bShowSub

        onButtonClick: {
            Logic.arrowPressed(1, 2) //1:left 2:right
        }
    }
    /////Control End

//    Keys.onPressed: {
//        Logic.onKeyPressed(event.key)
//    }

    ////Exit Button
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
        width: 560
        //anchors.horizontalCenter:parent.horizontalCenter
        anchors.bottom:parent.bottom
        anchors.bottomMargin:14
        anchors.left: parent.left
        anchors.leftMargin: 87

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color:"white"
        id:t
        font.family: "Verdana"
        text:toolTip
        font.bold:true
        font.pointSize:16

    }

    Component.onCompleted:{
        Logic.clearAll();
        mainwnd.inits();
    }


}
