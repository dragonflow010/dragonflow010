import Qt 4.7
import "Xmlutil.js" as Logic


Rectangle{
    property int ontop: 1
    property alias source: xmlModel.source
    property alias query: xmlModel.query
    property string strText:""
    property bool benter:false
    property int mouseIndex: 0
    property bool bToolTipOnStart: false
    property string linkSource:""

    property bool bupTitle: false
    property string strupTitle:""
    property int nGloab: 0
    property int nCount: 0
    property string strTxt: "Exit"
    property bool bFir: false







    anchors.horizontalCenter: mainwnd.horizontalCenter
    anchors.top: mainwnd.top
    anchors.topMargin: 70
    clip: true
    id: model_view;
    //   width: Logic.getWidth()
    width: 750
    height: 450
    focus: true
    //color:focus?"#8e0000ff":"#8e000f00"
    color:"#00000000"
    radius: 10



    function navigate(i)
    {

        if(view.count <= 10)
        {
            return;
        }

        if(i<0)
        {

            for(var i = 9; i < 100; i += 10)
            {

                if(view.currentIndex <= i)
                {
                    view.currentIndex = (view.count <= i+10) ? (view.count - 1) : (i + 10)
                    break;
                }
            }

        }
        else
        {
            for(var i = 99; i >= 19; i -= 10)
            {
                if(view.currentIndex >= 0 && view.currentIndex <= 19)
                {
                    view.currentIndex = 0
                    break;
                }
                if(view.currentIndex >= i)
                {
                    view.currentIndex = i - 9
                    break;
                }
            }

        }

        if(view.currentIndex == (view.count - 1))
        {
            console.log("---------------------------|| 1")
            mainwnd.setTwoButState(false, true)
        }
        else if(view.currentIndex != 0)
        {
            console.log("---------------------------|| 2")
            mainwnd.setTwoButState(false, false)
        }
        else if(view.currentIndex == 0)
        {
            console.log("---------------------------|| 3")
            mainwnd.setTwoButState(true, false)
        }


        //        view.currentIndex=(view.currentIndex+i+view.count)%view.count;

    }
    function setTooltip(type,index)
    {
        //        if(!ontop)
        //        {
        //            return;
        //        }

        //        console.log("xmlutil.qml setTooltip"+index+""+view.count)
        //        if(type == 1)
        //        {
        //            //鼠标移动
        //            strText =  xmlModel.get(index).title
        //            mainwnd.setTooltip(strText);
        //        }
        //        if(type == 2)
        //        {
        //            console.log(view.currentIndex +": "+view.count)
        //            //键盘或图标移动
        //            strText = xmlModel.get(view.currentIndex).title
        //            mainwnd.setTooltip(strText)
        //        }

    }

    function setupTitle()
    {
        strupTitle = xmlModel.get(0).upTitle
        strTxt = xmlModel.get(0).butTxt
        console.log("---------------------------" + strupTitle)
        if(strupTitle == "")
        {
            mainwnd.bupTitle = false
        }
        else
        {
            mainwnd.setupTitle(strupTitle, strTxt)
        }

    }

    function expandcurrent()
    {
        console.log('exe tttt '+view.currentIndex+ " "+xmlModel.count)
        var item_temp=xmlModel.get(nGloab%view.count);
        if(item_temp.itemtype=='expand')
        {
            //            mainwnd.createModelView(linkSource,item_temp.linkquery,model_view)
        }
        else if(item_temp.itemtype=='exe')
        {
            mainwnd.deleteLayers(model_view);
            mainwnd.shellExe(item_temp.linkquery, 0);
        }
        else if(item_temp.itemtype=='html')
        {
            mainwnd.deleteLayers(model_view);
            mainwnd.shellExe(item_temp.linkquery, 1);
        }
        else
        {
            mainwnd.deleteLayers(model_view);
        }
    }



    //    NumberAnimation on scale{
    //        from: 0; to: 1.0
    //        easing.type: Easing.OutBack; duration: 1000
    //    }

    //    Behavior on scale {
    //        NumberAnimation { easing.type: Easing.OutBack; duration: 1000 }
    //    }

    function retValue(nNum)
    {
        var para = [150, 315, 475, 600, 740]
        return para[nNum - 1];

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

    }

    Component {
        id: appDelegate

        Item {
            width: 140; height: 130
            //            anchors.verticalCenter: parent.verticalCenter
            //            scale: model_view.ontop?Logic.getScale(index):0.8
            //            anchors.top: parent.top
            //            anchors.topMargin:  ((view.count % 10) == 0) ? 175: 25
            BorderImage {
                id: myIcon
                anchors.top: parent.top
                anchors.topMargin: 2
                anchors.left:parent.left
                anchors.leftMargin: 5
                width:130;height:130
                scale: (mousearea.containsMouse && model_view.ontop)?1.0:(1.0/1.1)
                source: "pic/bottom_bg.png"
                smooth: true
                BorderImage{
                    id:innerIcon
                    width:90
                    height:60
                    anchors.top:parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    scale: (mousearea.containsMouse && model_view.ontop)?1.0:(1.0/1.1)
                    anchors.topMargin: 15
                    source:icon
                }

            }
            Text {
                id: tex
                width: 118
                height: 36
                color: "black"
                clip: false
                //               font.bold:true
                //                font.italic:true
                font.family:"Verdana"
                font.pixelSize: 12
                anchors.bottom: myIcon.bottom
                anchors.bottomMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                //                text: (simtitle=="")?title:simtitle
                text:(title.length > 50) ? (title.slice(0, 50)) : title

                //opacity:(view.currentIndex == index)?1:0
                //        opacity:(((view.currentIndex>=view.count&&index==0)||(view.currentIndex == index))&&ontop)?1:0
                Component.onCompleted: {
                    console.log('Text Component.onCompleted:'+view.count)
                    if(view.count <= 10)
                    {
                        console.log("---------------------------|| 4")
                        if(!bFir)
                        {
                            mainwnd.setTwoButState(true, true)
                            bFir = true
                        }
                        mainwnd.setShow(false)
                    }
                    else
                    {
                        console.log("---------------------------|| 5")
                        if(!bFir)
                        {
                            mainwnd.setTwoButState(true, false)
                            bFir = true
                        }
                        mainwnd.setShow(true)
                    }
                    if(!bToolTipOnStart)
                    {
                        bToolTipOnStart=true;
                        setTooltip(1,0)
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
                    mouseIndex = index;

                    setTooltip(1,index)
                }
                onExited: {
                    console.log(view.currentIndex + ":"+index)
                    if( benter)
                    {
                        var i = view.currentIndex%(view.count)

                        setTooltip(1,i)
                    }
                    benter = false
                }
                onClicked: {
                    nGloab = index;
                    //                    view.currentIndex = index;
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
        //        anchors.fill: parent
        //        anchors.top: parent.top
        height: (count <= 5) ? 150 : 300
        width: (count <= 5) ? retValue(count) : 740
        anchors.centerIn: parent
        //        anchors.fill: mainwnd

        cellWidth: 148; cellHeight: 150
//        highlight: appHighlight
        focus: true
        model: xmlModel
        delegate: appDelegate
        //        flickableDirection: Flickable.HorizontalFlick
        //        boundsBehavior: (count < 10) ? Flickable.StopAtBounds : Flickable.DragAndOvershootBounds

        interactive:false
        snapMode: GridView.SnapToRow

        flow:(count < 10) ? (GridView.LeftToRight) : (GridView.TopToBottom)
        //                highlightRangeMode:GridView.StrictlyEnforceRange

    }


    //    PathView {
    //        //            Component.onCompleted: {Logic.recalPath(view)}
    //        //            property int startx: 0
    //        //            property int endx: 0
    //        id: view
    //        pathItemCount:5
    //        //        interactive:false
    //        anchors.fill: parent
    //        highlight: appHighlight
    //        preferredHighlightBegin: 0.5
    //        preferredHighlightEnd: 0.5
    //        focus: true
    //        model: xmlModel
    //        delegate: appDelegate

    //        MouseArea {
    //            id:mousearea_for_line
    //            anchors.fill: parent

    //            onClicked: {
    //                mainwnd.deleteLayers(model_view,0);
    //            }
    //        }

    //        path: Path {
    //            startX: Logic.getStartX(); startY: 50

    //            PathLine{x:Logic.getStartX() + (Logic.getEndX()-Logic.getStartX() )/4.0;y:50}
    //            PathPercent{value: 0.25+(ontop?0.015:0.0)}

    //            PathLine{x:(Logic.getStartX() + Logic.getEndX() )/2 ;y:50}
    //            PathPercent{value: 0.5}

    //            PathLine{x:Logic.getStartX() + (Logic.getEndX()-Logic.getStartX() )/4.0*3;y:50}
    //            PathPercent{value: 0.75-(ontop?0.015:0.0)}

    //            PathLine{x:Logic.getEndX();y:50}
    //            PathPercent{value: 1.0}

    //        }
    //    }
    Component.onCompleted:{
        linkSource = mainwnd.getlinkSource();
        console.log("Component.onCompleted fff"+":"+linkSource);
        //view.flow:Flow.TopToBottom


    }

}
