program lab6;

uses graph,wincrt,math;

type
TXYZ=record 
    x,y,z:integer; 
end; 
Tcrd=record
    x,y:integer;
end;



const V:array[0..7] of TXYZ= (
(x:-100;y: 50;z:-35),//0
(x:-100;y:-50;z:-35),//1
(x: 100;y:-50;z:-35),//2
(x: 100;y: 50;z:-35),//3
(x: 100;y: 50;z: 35),//4
(x: 100;y:-50;z: 35),//5
(x:-100;y:-50;z: 35),//6
(x:-100;y: 50;z: 35) //7
); 


var g,h:integer;
    ch:char;
    crd:array[0..7] of Tcrd;

Procedure draw(x,y:integer);
var i:integer;
begin
    for i:=0 to 6 do
    begin
        line( x+crd[i].x , y+crd[i].y , x+crd[i+1].x , y+crd[i+1].y);
    end;
    line( x+crd[0].x , y+crd[0].y , x+crd[3].x , y+crd[3].y );
    line( x+crd[0].x , y+crd[0].y , x+crd[7].x , y+crd[7].y );
    line( x+crd[1].x , y+crd[1].y , x+crd[6].x , y+crd[6].y );
    line( x+crd[2].x , y+crd[2].y , x+crd[5].x , y+crd[5].y );
    line( x+crd[4].x , y+crd[4].y , x+crd[7].x , y+crd[7].y );
end;


procedure centralProjection();
var i:integer;
begin
    ClearDevice;
    for i:=0 to 7 do
    begin
        crd[i].x:=round( v[i].x/(v[i].z/150+1) );
        crd[i].y:=round( v[i].y/(v[i].z/150+1) );
    end;
    draw(500,500);
end;

procedure ObliqueParallelAxonometry(l:real);
var i:integer;
begin
    ClearDevice;
    for i:=0 to 7 do
    begin
        crd[i].x:=round( v[i].x+v[i].z*l*cos(Pi/4) );
        crd[i].y:=round( v[i].y+v[i].z*l*sin(pi/4) );
    end;
    draw(500,500);
end;

procedure Axonometric(p1,f1:real);
var p,f:real;
    i:integer;
begin
    ClearDevice;
    p:=p1*pi/180;
    f:=f1*pi/180;
    for i:=0 to 7 do
    begin
        crd[i].x:=round( v[i].x*cos(p)+v[i].z*sin(p) );
        crd[i].y:=round( 
            v[i].x*sin(p)*sin(f)+
            v[i].y*cos(f)-
            v[i].z*sin(f)*cos(p) 
            );
    end;
    draw(500,500);
end;

procedure Front();
var i:integer;
begin
    ClearDevice;
    for i:=0 to 7 do
    begin
        crd[i].x:=round( v[i].x );
        crd[i].y:=round( v[i].y );
    end;
    draw(500,500);
end;
procedure Top();
var i:integer;
begin
    ClearDevice;
    for i:=0 to 7 do
    begin
        crd[i].x:=round( v[i].x );
        crd[i].y:=round( v[i].z );
    end;
    draw(500,500);
end;

procedure Side();
var i:integer;
begin
    ClearDevice;
    for i:=0 to 7 do
    begin
        crd[i].x:=round( v[i].z );
        crd[i].y:=round( v[i].y );
    end;
    draw(500,500);
end;

procedure action(ch:char);
begin
    case ch of
        #1: begin//одноточечная центральная проекция
            centralProjection();
        end;
        #19: begin //Кавалье
            ObliqueParallelAxonometry(1);
        end;
        #4:begin //Кабине
            ObliqueParallelAxonometry(0.5);
        end;
        #17:begin //Изометрия
            Axonometric(45,35.264);
        end;
        #23:begin //Диметрия
            Axonometric(22.208,20.705);
        end;
        #5:begin //Триметрия
            Axonometric(150,70);
        end;

        #26:begin //Спереди
            Front();
        end;
        #24:begin //Сверху
            Top();
        end;
        #3:begin //Сбоку
            Side();
        end;


    end;
end;

begin
    g := detect;
    initgraph(g,h,'');
    setcolor(10);
    
    repeat
        ch:=ReadKey();
        action(ch);

    until ch=#27;


    CloseGraph;
end.