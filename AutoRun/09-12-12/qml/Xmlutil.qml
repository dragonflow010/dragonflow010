import Qt 4.7
import "Xmlutil.js" as Logic
import "plugin" 1.0

Rectangle{
    property int ontop: 1
    property alias source: xmlModel.source
    property alias query: xmlModel.query
    property string strText:""
    property string strTitle: ""

    property bool benter:false
    property bool bToolTipOnStart: false
    property string linkSource:""

    property bool bupTitle: false
   // property string strupTitle:""
    //property string strlogo: ""


    property int nCount: 0
    //property string strTxt: "Exit"
    property bool bFir: false

    property int tmpCurrentIndex: -1
    property int nNewAgain: 0
    property int nGCurIndex: 0
    property int nNextPageCount: 6
    property int nStartTimer: 0
    property int nRemCur: 0

    property bool bClick: false
    property int  nLastVisit: -2
    property int  nFirstVisit: -1

    property int  remViewCurrentIdx: -1

    property int nTotalItem: 0









    anchors.horizontalCenter: mainwnd.horizontalCenter
    clip: true
    id: model_view;
    width: ((nNewAgain > 1) &&(nNextPageCount <= 5) && (mainwnd.bNewAgain ==2 )) ? retValue(nNextPageCount) : ((nTotalItem <= 5) ? retValue(nNextPageCount) : 750)
    height: 150
    focus: true
    color:"#00000000"
    radius: 10
    border.color: ((nNewAgain > 1) && (mainwnd.bNewAgain >= 1) && nStartTimer > 0.7) ? ("#8e000f00") : ("#00000000")
    border.width: 1
    opacity: (nStartTimer<0.4)?0.0:1.0

    function initShow()
    {
        //setTooltip(1,2)

        /////highlight button when the CD starts in the beginning.
        /*nFirstVisit = 2
        if(nFirstVisit != nLastVisit)
        {
            expandcurrent()
        }
        nLastVisit = nFirstVisit*/
        /////end
    }

    function moveMouseFoucus(board, i)
    {
        setTooltip(1, i)
        nFirstVisit = i
        if(nFirstVisit != nLastVisit)
        {
            expandcurrent()
        }
        nLastVisit = nFirstVisit
    }
    function navigate(i)
    {
        if(view.count <= 5)
        {
            return;
        }

        if(i<0)
        {

            if(nGCurIndex >= parseInt(view.count / 5))
            {
                nNextPageCount = (view.count % 5);
            }
            else
            {
                view.currentIndex = (nGCurIndex + 1) * 5;
                nNextPageCount = view.count - view.currentIndex
            }
        }
        else
        {
            if(/*nGCurIndex >= 0 && nGCurIndex <= 9*/nGCurIndex == 0)
            {
                view.currentIndex = 0
                nGCurIndex = 0
                nNextPageCount = nNextPageCount + 5
            }
            else
            {

                view.currentIndex = (nGCurIndex - 1) * 5;
                nNextPageCount = view.count - view.currentIndex
            }

        }

        remViewCurrentIdx = view.currentIndex
        nGCurIndex = parseInt(view.currentIndex / 5);

        ////Move Mouse Focus
        moveMouseFoucus(retBoard(), remViewCurrentIdx)
        ////end

        if(parseInt(remViewCurrentIdx / 5) == 0)
        {

            mainwnd.setTwoButState(retBoard(), true, false)
        }
        else if(parseInt(remViewCurrentIdx / 5) >= parseInt(view.count / 5))
        {

            mainwnd.setTwoButState(retBoard(), false, true)
        }
        else
        {
            mainwnd.setTwoButState(retBoard(), false, false)
        }

       // nGCurIndex  = view.currentIndex

    }
    function setTooltip(type,index)
    {
        console.log("xmlutil.qml setTooltip"+index+";"+view.count)
        if(type == 1)
        {
            //鼠标移动
            //            view.currentIndex = index
            strText =  xmlModel.get(index).simtitle
            strTitle = xmlModel.get(index).title

            if(strText != "")
            {
                strText = translateLan(strText)
            }
            else
            {
                strText = translateLan(strTitle)
            }
            mainwnd.setTooltip(strText);
        }
        if(type == 2)
        {
            console.log(view.currentIndex +": "+view.count)
            //键盘或图标移动
            strText = xmlModel.get(view.currentIndex).title
            mainwnd.setTooltip(translateLan(strText))
        }

    }

    function setupTitle()
    {
        var strupTitle = xmlModel.get(0).upTitle
        var strTxt = xmlModel.get(0).butTxt
        var strlogo = xmlModel.get(0).logo
        if(strupTitle == "")
        {
            mainwnd.bupTitle = false
        }
        else
        {
            mainwnd.setupTitle(translateLan(strlogo), translateLan(strupTitle), translateLan(strTxt))
        }

    }

    function scaleOrNot()
    {
        myIcon.scale = 1.0
    }
    function retBoard()
    {
        var board
        if((nNewAgain > 1) && (mainwnd.bNewAgain >= 1))
        {
            /////Sub
            board = 1
        }
        else
        {
            /////Main
            board = 0
        }

        return board
    }
    function expandcurrent()
    {
        console.log('exe tttt '+view.currentIndex+ " "+xmlModel.count)
        var item_temp
        var item_id


        //////Show the control arrow
        if(view.count <= 5)
        {
            mainwnd.setShow(retBoard(), false)
        }
        else
        {
            mainwnd.setShow(retBoard(), true)
        }
        console.log("remViewCurrentIdx:" + parseInt(remViewCurrentIdx / 5))
        if(parseInt(remViewCurrentIdx / 5) == 0)
        {

            mainwnd.setTwoButState(retBoard(), true, false)
        }
        else if(parseInt(remViewCurrentIdx / 5) >= parseInt(view.count / 5))
        {

            mainwnd.setTwoButState(retBoard(), false, true)
        }
        else
        {
            mainwnd.setTwoButState(retBoard(), false, false)
        }
        /////end

        if(bClick)
        {
            item_temp = xmlModel.get(tmpCurrentIndex%view.count);
        }
        else
        {
            item_temp = xmlModel.get(nFirstVisit % view.count);
        }

        console.log("type:" + item_temp.itemtype)
        if(item_temp.itemtype=='expand' && !bClick)
        {
            nNewAgain = 1
            mainwnd.createModelView(linkSource,item_temp.linkquery,model_view)
        }
        else if(item_temp.itemtype=='exe' && bClick)
        {
            item_id =  xmlModel.get(item_temp).linkquery
            mainwnd.deleteLayers(model_view);
            if(item_temp.type != '')
            {
                mainwnd.showUpdateDlg(translateLan(item_id), translateLan(item_temp.type));
            }
            else
            {

                mainwnd.shellExe(translateLan(item_id), 0);
            }

        }
        else if(item_temp.itemtype=='html' && bClick)
        {
            mainwnd.deleteLayers(model_view);
            mainwnd.shellExe(item_temp.linkquery, 1);
        }
        else if(item_temp.itemtype == 'folder' && bClick)
        {
            mainwnd.deleteLayers(model_view);
            mainwnd.shellExe(item_temp.linkquery, 4);
        }
        else if(item_temp.itemtype == 'txt' && bClick)
        {
            mainwnd.deleteLayers(model_view);
            mainwnd.shellExe(item_temp.linkquery, 5);
        }
        else
        {
            mainwnd.deleteLayers(model_view);
        }

        bClick = false
    }

    function translateLan(id)
    {
        return mainwnd.translateText(id);
    }

    NumberAnimation on scale{
        //        from: 0; to: 1.0
        //        easing.type: Easing.OutBack; duration: 1000
        from: 0.6; to: 1.0;
        duration: 600; easing.type:  Easing.InOutQuad
    }
    NumberAnimation on nStartTimer{
        //        from: 0; to: 1.0
        //        easing.type: Easing.OutBack; duration: 1000
        from: 0.0; to: 1.0;
        duration: 800; easing.type:  Easing.InOutQuad
    }
    //    NumberAnimation on opacity{
    //        //        from: 0; to: 1.0
    //        //        easing.type: Easing.OutBack; duration: 1000
    //        from: 0; to: 1.0;
    //        duration: 600; easing.type:  Easing.InOutQuad
    //    }

    Behavior on y {
        //        SpringAnimation { spring: 2; damping: 0.2 }
        //        SmoothedAnimation { velocity: 500 }
        NumberAnimation {easing.type: Easing.OutBack; duration: 2000 }
        //                NumberAnimation { easing.type: Easing.InBounce; duration: 300 }
    }

    function retValue2(nNum)
    {
        var para = [200, 550, 700, 750, 750]
        console.log("nNum"+":"+ nNum);
        return para[nNum - 1];
    }
    function retValue(nNum)
    {
        var para = [200, 420, 570, 700, 750]
        return para[nNum - 1];

    }
    function retCellWidth(nNum)
    {
        var para = [150, 200, 180, 180, 150]
        return para[nNum];
    }
    function retAnchorsValue(nNume)
    {
        var parae = [32, 69, 69, 59, 7]
        return parae[nNume - 1];
    }
    function scaleRetValue(nIndexNum)
    {
        //        (/*tmpCurrentIndex == index || */nFirstVisit == index)?(1.0 / 0.9):
        //                                                                     ((mousearea.containsMouse /*&& model_view.ontop*/)?(1.0 / 0.9):1.0)
        if(nFirstVisit == nIndexNum)
        {
            return (1.0 / 0.9);
        }
        else
        {
            return (1.0);
        }
    }
    function imageSourceValue(nIndexNum)
    {
        if(nFirstVisit == nIndexNum)
        {
            return "pic/bottom_bg2.png"
        }
        else
        {
            return "pic/bottom_bg.png"
        }
    }
    XmlListModel {
        id: xmlModel
        source: "";
        query:  ""

        XmlRole { name: "simtitle"; query: "simtitle/string()" }
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "icon"; query: "icon/string()" }
        XmlRole {name: "itemtype"; query: "itemtype/string()" }
        XmlRole {name: "linkquery"; query: "linkquery/string()" }
        XmlRole {name: "upTitle"; query: "upTitle/string()"}
        XmlRole {name: "butTxt"; query: "butTxt/string()"}
        XmlRole {name: "type"; query: "type/string()"}
        XmlRole {name: "logo"; query: "logo/string()"}
    }

    Component {
        id: appDelegate

        Item {
            width: 140; height: 130
            id: iItem
            opacity:((nNewAgain > 1) &&(index == view.currentIndex - 1) && (mainwnd.bNewAgain == 2) &&
                     (nNextPageCount < 5)) ? 0.0 : 1.0
            BorderImage {
                id: myIcon
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.left:parent.left
                anchors.leftMargin: 5
                width:134;height:130
                scale: (mousearea.containsMouse && parseInt(nFirstVisit / 5) == nGCurIndex) ? (1.0 / 0.9) : ((parseInt(nFirstVisit / 5) == nGCurIndex) ? scaleRetValue(index) : 1.0);
                source: (mousearea.containsMouse && parseInt(nFirstVisit / 5) == nGCurIndex) ? "pic/bottom_bg2.png":((parseInt(nFirstVisit / 5) == nGCurIndex) ? imageSourceValue(index) : "pic/bottom_bg.png");
                smooth: true

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.OutExpo; duration: 300 }
                }
            }
            BorderImage{
                id:innerIcon
                width:81
                height:60
                anchors.top:parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                //                scale: (mousearea.containsMouse && model_view.ontop)?(1.0 / 1.1):(1.0/1.1)
                anchors.topMargin: 18
                smooth: true
                source:icon
            }
            Text {
                id: tex
                width: 128
                height: 36
                color: "black"
                clip: false

                //               font.bold:true
                //                font.italic:true
                font.family:"Verdana"
                font.pixelSize: 11
                anchors.top: myIcon.top
                anchors.topMargin: 85
                anchors.bottom: myIcon.bottom
                anchors.bottomMargin: 17

                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                //                text: (simtitle=="")?title:simtitle
//                text:(title.length > 45) ? (title.slice(0, 45)) : title
                text:translateLan(title)

                //opacity:(view.currentIndex == index)?1:0
                //        opacity:(((view.currentIndex>=view.count&&index==0)||(view.currentIndex == index))&&ontop)?1:0
                Component.onCompleted: {
                    nCount = view.count
                    //                                        nNextPageCount = view.count

                    if(view.count <= 5)
                    {
                        if(!bFir)
                        {
                            nNextPageCount = view.count
                            nTotalItem = view.count
                            mainwnd.setTwoButState(retBoard(), true, true)
                            bFir = true
                        }

                        mainwnd.setShow(retBoard(), false)
                    }
                    else
                    {
                        if(!bFir)
                        {
                            nNextPageCount = view.count
                            nTotalItem = view.count
                            mainwnd.setTwoButState(retBoard(), true, false)
                            bFir = true
                        }
                        mainwnd.setShow(retBoard(), true)
                    }
                    if((!bToolTipOnStart) && (mainwnd.bNewAgain < 1))
                    {
                        bToolTipOnStart=true;
                        setTooltip(1,0)
                        initShow();
                    }
                    if(!mainwnd.bupTitle)
                    {
                        mainwnd.bupTitle = true
                        setupTitle();
                    }

                }
            }

            MouseArea {
                id:mousearea
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    benter = true;
                    setTooltip(1,index)

                    remViewCurrentIdx = index

                    console.log("Index:" + index + "CurrentIndex: " + view.currentIndex)

                    //nGCurIndex = view.currentIndex / 5
                    nGCurIndex = parseInt(view.currentIndex / 5)
                    nFirstVisit = index
                    if(nFirstVisit != nLastVisit)
                    {
                        expandcurrent()
                    }
                    nLastVisit = nFirstVisit
                }
                onExited: {
                    console.log(view.currentIndex + ":"+index)
                    if( benter)
                    {
                        nRemCur = index%(view.count)
                        console.log("nRemCur: " << nRemCur)

                        setTooltip(1,nRemCur)
                    }
                    benter = false
                }
                onClicked: {
                    tmpCurrentIndex = index
                   // nGCurIndex = view.currentIndex
                    bClick = true
                    expandcurrent()

                }
            }
        }

    }

    Component {
        id: appHighlight

        Rectangle { width: 80; height: 80; color:"red"}//"#2effffff"
    }


    GridView {
        id:view
                //anchors.fill: parent
        anchors.top: parent.top
        anchors.topMargin: 9

        anchors.left: parent.left
        anchors.leftMargin: ((nNewAgain > 1) && (nNextPageCount <= 5) && (mainwnd.bNewAgain == 2)) ? retAnchorsValue(nNextPageCount) :
                                                                                                                                     ((count <= 5) ? retAnchorsValue(count) : 3)

        //        height: (count <= 5) ? 150 : 360
        height: 150
        width: (count <= 5) ? retValue(count) : 750

        cellWidth: 150;
        cellHeight: 180
//                        highlight: appHighlight


        focus: true
        model: xmlModel
        delegate: appDelegate
        //        flickableDirection: Flickable.HorizontalFlick
        //        boundsBehavior: (count < 10) ? Flickable.StopAtBounds : Flickable.DragAndOvershootBounds

        interactive:false
        snapMode: GridView.SnapToRow

        flow:(count <= 5) ? (GridView.LeftToRight) : (GridView.TopToBottom)
        highlightRangeMode:(count <= 5) ? (GridView.NoHighlightRange) : (GridView.StrictlyEnforceRange)

    }
    Component.onCompleted:{
        linkSource = mainwnd.getlinkSource();
        nNewAgain = 2

    }

}
