program lab3;

uses graph,wincrt,math;

const
    l=5;
    angle=Pi/6;
type
    tcrd=record
        x,y:integer;
    end;
    TMatrix33=array[1..9] of real;
    TCrds=array[1..l] of tcrd;

var g,h,c:integer;
    ch:char;
    poly:TCrds;

    McompressionX,
    MStretchingX,
    MScalingUp,
    MScalingDown,
    MSymmetryX,
    MSymmetryY,
    MRotation,
    MRotationR,
    movingX,
    movingY: TMatrix33;

//1 4 7
//2 5 8
//3 6 9
function createArr(
    x1,x4,x7,
    x2,x5,x8,
    x3,x6,x9:real):TMatrix33;
var arr:TMatrix33;
begin
    arr[1]:=x1;
    arr[2]:=x2;
    arr[3]:=x3;
    arr[4]:=x4;
    arr[5]:=x5;
    arr[6]:=x6;
    arr[7]:=x7;
    arr[8]:=x8;
    arr[9]:=x9;
    Exit(arr);
end;


procedure initMatrix();

begin

    
    movingX:=createArr(
        1,  0,  0,
        0,  1,  0,
        10, 0,  0
    );
    movingY:=createArr(
        1,  0,  0,
        0,  1,  0,
        0,  10,  0
    );

    MRotation:=createArr(
        cos(angle), sin(angle) ,  0,
        -sin(angle), cos(angle),  0,
        0,  0,  0
    );
    MRotationR:=createArr(
        cos(-angle), sin(-angle) ,  0,
        -sin(-angle), cos(-angle),  0,
        0,  0,  0
    );
    MSymmetryX:=createArr(
        1,  0,  0,
        0,  -1,  0,
        0,  0,  1
    );
    MSymmetryY:=createArr(
        -1,  0,  0,
        0,  1,  0,
        0,  0,  1
    );

    MScalingUp:=createArr(
        1.1,  0,  0,
        0,  1.1,  0,
        0,  0,  1
    );
    MScalingDown:=createArr(
        0.9,  0,  0,
        0,  0.9,  0,
        0,  0,  1
    );
    MStretchingX:=createArr(
        1.1,  0,  0,
        0,  1,  0,
        0,  0,  1
    );
    McompressionX:=createArr(
        0.9,  0,  0,
        0,  1,  0,
        0,  0,  1
    );

end;

procedure init();
begin
    poly[1].x:=100;
    poly[1].y:=100;

    poly[2].x:=200;
    poly[2].y:=150;

    poly[3].x:=200;
    poly[3].y:=400;

    poly[4].x:=150;
    poly[4].y:=400;

    poly[5].x:=123;
    poly[5].y:=123;
end;

procedure DrPoly();
var i:integer;
begin
    MoveTo(poly[1].x,poly[1].y);
    for i:=2 to l do 
    begin
        lineto(poly[i].x,poly[i].y)
    end;
    lineto(poly[1].x,poly[1].y)
end;

function MultMatrix(crd:Tcrd;arr:TMatrix33):tcrd;
var crd2:Tcrd;
begin
    crd2.x:=round(crd.x*arr[1]+crd.y*arr[2]+arr[3]);
    crd2.y:=round(crd.x*arr[4]+crd.y*arr[5]+arr[6]);
    Exit(crd2);
end;

procedure ChangeCrds(var arr:TCrds;matrix:TMatrix33);
var i:integer;
begin
    for i:=1 to l do
    begin
        arr[i]:=MultMatrix(arr[i],matrix);
    end;

end;

//перемещение
procedure movePolyX(right:boolean);
begin
    if right then
    begin
        movingX[3]:=10;
    end
    else
    begin
        movingX[3]:=-10;
    end;
    ChangeCrds(poly,movingX);
    ClearDevice;
    DrPoly();
end;

procedure movePolyY(up:boolean);
begin
    if up then
    begin
        movingY[6]:=-10;
    end
    else
    begin
        movingY[6]:=+10;
    end;
    ChangeCrds(poly,movingY);
    ClearDevice;
    DrPoly();
end;

procedure rotationLeft();
begin
    MRotation[3]:=
        -poly[1].x*cos(angle)+ poly[1].x +poly[1].y*sin(angle);
    MRotation[6]:=-poly[1].x*sin(angle)-poly[1].y*cos(angle)+poly[1].y;
    ChangeCrds(poly, MRotation);
    ClearDevice;
    DrPoly();
end;

procedure rotationRight();
begin
    MRotationR[3]:=
        -poly[1].x*cos(-angle)+ poly[1].x +poly[1].y*sin(-angle);
    MRotationR[6]:=-poly[1].x*sin(-angle)-poly[1].y*cos(-angle)+poly[1].y;
    ChangeCrds(poly, MRotationR);
    ClearDevice;
    DrPoly();
end;

procedure SymmetryX();
begin
    MSymmetryX[6]:=2*poly[1].y;
    ChangeCrds(poly, MSymmetryX);
    ClearDevice;
    DrPoly();
end;
procedure SymmetryY();
begin
    MSymmetryY[3]:=2*poly[1].x;
    ChangeCrds(poly, MSymmetryY);
    ClearDevice;
    DrPoly();
end;

procedure ScalingUp();
begin
    if abs(poly[1].x-poly[2].x) < 1000 then
    begin
        MScalingUp[3]:=-poly[1].x*1.1+poly[1].x;
        MScalingUp[6]:=-poly[1].y*1.1+poly[1].y;
        ChangeCrds(poly, MScalingUp);
        ClearDevice;
        DrPoly();
    end;

end;
procedure ScalingDown();
begin
    if abs(poly[1].x-poly[2].x) > 30 then
    begin
        MScalingDown[3]:=-poly[1].x*0.9+poly[1].x;
        MScalingDown[6]:=-poly[1].y*0.9+poly[1].y;
        ChangeCrds(poly, MScalingDown);
        ClearDevice;
        DrPoly();
    end;

end;

procedure StretchingX();
begin
    MStretchingX[3]:=-poly[1].x*1.1+poly[1].x;
    ChangeCrds(poly, MStretchingX);
    ClearDevice;
    DrPoly();
end;
procedure compressionX();
begin
    if abs(poly[1].x-poly[2].x)>30 then
    begin
        McompressionX[3]:=-poly[1].x*0.9+poly[1].x;
        ChangeCrds(poly, McompressionX);
        ClearDevice;
        DrPoly();
    end;
end;

procedure ScalingRotationR();
begin
    ScalingDown();
    rotationRight();
end;
procedure ScalingRotationL();
begin
    ScalingUp();
    rotationLeft();
end;

procedure reset();
begin
    init();
    ClearDevice;
    DrPoly();
end;


procedure move(ch:char);
begin
     case ch of
        #77://вправо
        begin
            movePolyX(true);
        end;
        #75:
        begin
            movePolyX(false);
        end;
        #72:
        begin
            movePolyY(true);
        end;
        #80:
        begin
            movePolyY(false);
        end;

     end;
end;

procedure action(ch:char);
begin
   case ch of
        #26://ctr+z
        begin
            rotationleft();
        end;
        #1://ctr+A
        begin
            rotationright();
        end;

        #24://Ctrl+X
        begin
            Symmetryx();
        end;
        #19://Ctrl+S
        begin
            SymmetryY();
        end;
        #3:
        begin
            ScalingUp();
        end;
        #4:
        begin
            ScalingDown();
        end;
        #18://Сtr+R
        begin
            Reset();
        end;

        #22://crt+V
        begin
            StretchingX();
        end;
        #6://crt+F
        begin
            compressionX();
        end;
        #2:
        begin
            ScalingRotationL();
        end;
        #7:
        begin
            ScalingRotationR();
        end;
   end;


end;

begin
    g := detect;
    initgraph(g,h,'');
    init();
    initMatrix();
    setcolor(10);
    DrPoly();

    repeat 
        
        ch:=readkey();
        if ch = #0 then
        begin
            ch:=readkey();
            move(ch);
        end;
        action(ch);

    until ch = #27;
    CloseGraph;
end.
