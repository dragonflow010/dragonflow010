var component;

var bS = 0;
var currentboard=0;
var board = new Array(10);
function clearAll()
{
    for (var i = 0; i < currentboard; i++)
    {

        board[i].destroy();

    }
    currentboard=0;
}
function refresh()
{
    board[currentboard - 1].focus = true
}
function createModelView(source,query,ref)
{


    console.log('createModelView '+ source+' '+query);
    if (component == null)
    {
        component = Qt.createComponent("Xmlutil.qml");
    }
    if (component.status == Component.Ready) {
        var dynamicObject = component.createObject(mainwnd);
        if (dynamicObject == null) {
            console.log("error creating block");
            console.log(component.errorString());
            return false;
        }
        //        dynamicObject.horizonalCenter=mainwnd.horizontalCenter
        dynamicObject.source = source;
        dynamicObject.query = query;
        dynamicObject.focus=true

        bS = dynamicObject.nCount;
        //		dynamicObject.text = "strtext";
        //        dynamicObject.width = 400;
        //        dynamicObject.height = 200;

        //        board.y=ref.y+50
        //        dynamicObject.y=ref.y-30;
        //        dynamicObject.z=ref.z+1
        //        dynamicObject.focus=true


        if(currentboard>0)
        {
            //delete some layers
            deleteLayers(ref,1)

            //            dynamicObject.y=board[currentboard-1].y-20
            console.log(ref)


            //            console.log(currentboard)
            //            console.log('refy is'+board[currentboard-1].y+'y is' +dynamicObject.y)

        }
        board[currentboard]=dynamicObject
        currentboard++

        //调整所有的y位置

        setYPara()

    } else {
        console.log("error loading block component");
        console.log(component.errorString());
        return false;
    }
    return true;
}

function retCount()
{
    console.log("_________________________"+bS);
    if(bS <= 10)
        return false
    else
        return true
}
function deleteLayers(ref,inner)
{
    for (var i = 0; i < currentboard; i++)
    {
        if(board[i]==ref)
        {
            console.log('find it '+i)

            var j=i+1;
            while(j < currentboard)
            {
                console.log('destroy layer')
                board[j].destroy();
                j++;
            }
            currentboard=i+1;
            break
        }
    }
    if(!(inner== 1))
    {
        setYPara()
    }
}

function setYPara()
{
    var cYPara=[
            [0],
            [160],
            [210,140],
            [240,180,130],
            [200,100,0,-100]
        ]
    var cScalePara=[
            [1.0],
            [1.0],
            [0.8,1.0],
            [0.6,0.8,1.0],
            [0.4,0.6,0.8,1.0]
        ]
    for (var i = 0; i < currentboard; i++)
    {
        board[i].y = cYPara[currentboard][i]

        board[i].scale=cScalePara[currentboard][i]
        board[i].ontop=(i ==currentboard-1)?1:0

    }
}
function arrowPressed(type)
{
    console.log("arrowPressed" + currentboard)
    if(currentboard > 0)
    {
        if(type == 1)
        {
            board[currentboard-1].navigate(1)
            board[currentboard-1].setTooltip(2,0)
        }
        if(type == 2)
        {
            board[currentboard - 1].navigate(-1)
            board[currentboard-1].setTooltip(2,0)
        }
    }
}
function onKeyPressed(key)
{
    console.log('onKeyPressed '+currentboard)
    if(currentboard>0)
    {
        if(key==Qt.Key_Left)
        {
            board[currentboard-1].navigate(1)
            board[currentboard-1].setTooltip(2,0)
        }
        if(key==Qt.Key_Right)
        {
            board[currentboard-1].navigate(-1)
            board[currentboard-1].setTooltip(2,0)
        }
//        if(key==Qt.Key_Escape)
//        {

//            deleteTopLayer()
//            board[currentboard-1].setTooltip(2,0)
//        }
//        if(key==Qt.Key_Enter || key==Qt.Key_Return)
//        {
//            board[currentboard-1].expandcurrent()
//        }
    }
}




function deleteTopLayer()
{
    if(currentboard>1)
    {
        board[currentboard-1].destroy();
        currentboard--;
    }
    if(currentboard>=1)
    {
        board[currentboard-1].focus=true
    }

    setYPara()
}
