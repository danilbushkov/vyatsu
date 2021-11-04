program lab7;

uses graph,wincrt,math;

type
TXYZ=record 
    x,y,z:integer; 
end; 
Tcrd=record
    x,y:integer;
end;


const 
A:array[0..7] of TXYZ= (
(x:0;y: 250;z:0),//0
(x:0;y:0;z:0),//1
(x: 200;y:0;z:0),//2
(x: 200;y: 250;z:0),//3
(x: 200;y: 250;z: 200),//4
(x: 200;y:0;z: 200),//5
(x:0;y:0;z: 200),//6
(x:0;y: 250;z: 200) //7
); 


V:array[0..7] of TXYZ= (
(x:0;y: 250;z:0),//0
(x:0;y:0;z:0),//1
(x: 200;y:0;z:0),//2
(x: 200;y: 250;z:0),//3
(x: 200;y: 250;z: 200),//4
(x: 200;y:0;z: 200),//5
(x:0;y:0;z: 200),//6
(x:0;y: 250;z: 200) //7
); 
Axis:array[0..3] of TXYZ= (
    (x:0;y: 0;z: 0),
    (x:1000;y: 0;z:0),//0
    (x:0;y:-1000;z:0),//1
    (x:0;y:0;z:-1000)
);

q=40;
w=20;

var g,h:integer;
    ch:char;
    crd:array[0..7] of Tcrd;
    b:array[0..7] of TXYZ;



Procedure DrawAxis(x,y:integer;p1,f1:real);
var a:array[0..3] of Tcrd;
    p,f:real;
    i:integer;
begin
    setcolor(5);
    p:=p1*pi/180;
    f:=f1*pi/180;
    for i:=0 to 3 do
    begin
        a[i].x:=round( Axis[i].x*cos(p)+Axis[i].z*sin(p) );
        a[i].y:=round( 
            Axis[i].x*sin(p)*sin(f)+
            Axis[i].y*cos(f)-
            Axis[i].z*sin(f)*cos(p) 
            );
    end;
    line(x+a[0].x , y+a[0].y , x+a[1].x , y+a[1].y);
    line(x+a[0].x , y+a[0].y , x+a[2].x , y+a[2].y);
    line(x+a[0].x , y+a[0].y , x+a[3].x , y+a[3].y);
    setcolor(11);
end;

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

    DrawAxis(x,y,q,w);
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

procedure Move(m,n,l:integer);
var i:integer;
begin
    for i:=0 to 7 do
    begin
        v[i].x:=v[i].x+m;
        v[i].y:=v[i].y+n;
        v[i].z:=v[i].z+l;
    end;
end;

procedure Symmetry(m,n,l:integer);
var i:integer;
begin
    for i:=0 to 7 do
    begin
        v[i].x:=m*v[i].x;
        v[i].y:=n*v[i].y;
        v[i].z:=l*v[i].z;
    end;
end;

procedure Scaling(k1,k2,k3:real;p:TXYZ);
var i:integer;
    m,n,l:integer;
begin
    m:=p.x;
    n:=p.y;
    l:=p.z;
    for i:=0 to 7 do
    begin
        v[i].x:=round(k1*v[i].x -m*k1+m);
        v[i].y:=round(k2*v[i].y -n*k2+n);
        v[i].z:=round(k3*v[i].z -l*k3+l);
    end;
end;

procedure rotationAxisX(angle:integer);
var i:integer;
    r:real;
begin
    b:=v;
    r:=angle*Pi/180;
    for i:=0 to 7 do
    begin
        v[i].y:=round(b[i].y*cos(r)-b[i].z*sin(r));
        v[i].z:=round(b[i].y*sin(r)+b[i].z*cos(r));
    end;
    
    
end;

procedure rotationAxisY(angle:integer);
var i:integer;
    r:real;
begin
    b:=v;
    r:=angle*Pi/180;
    for i:=0 to 7 do
    begin
        v[i].x:=round(b[i].x*cos(r)+b[i].z*sin(r));
        v[i].z:=round(-b[i].x*sin(r)+b[i].z*cos(r));
    end;
    
    
end;

procedure rotationAxisZ(angle:integer);
var i:integer;
    r:real;
begin
    b:=v;
    r:=angle*Pi/180;
    for i:=0 to 7 do
    begin
        v[i].x:=round(b[i].x*cos(r)-b[i].y*sin(r));
        v[i].y:=round(b[i].x*sin(r)+b[i].y*cos(r));
    end;
    
    
end;

procedure rotation(n1,n2,n3:real;angle:integer);
var i:integer;
    r:real;
begin
    b:=v;
    r:=angle*Pi/180;
    for i:=0 to 7 do
    begin
        v[i].x:=round( 
            b[i].x*(n1*n1+(1-n1*n1)*cos(r))+
            b[i].y*( n1*n2*(1-cos(r))-n3*sin(r)) +
            b[i].z*( n1*n3*(1-cos(r))+n2*sin(r)) 
        );
        v[i].y:=round(
            b[i].x*(n1*n2*(1-cos(r))+n3*sin(r))+
            b[i].y*( n2*n2+(1-n2*n2)*cos(r) ) +
            b[i].z*( n2*n3*(1-cos(r))-n1*sin(r)) 
        );
        v[i].z:=round(
            b[i].x*( n1*n3*(1-cos(r))-n2*sin(r)) +
            b[i].y*( n2*n3*(1-cos(r))+n1*sin(r)) + 
            b[i].z*( n3*n3+(1-n3*n3)*cos(r) )
            
        );
    end;

end;

procedure rotationDiagonal(n:integer;angle:integer);
begin
    rotation(
                v[n].x/sqrt(sqr(v[n].x)+sqr(v[n].y)+sqr(v[n].z)),
                v[n].y/sqrt(sqr(v[n].x)+sqr(v[n].y)+sqr(v[n].z)),
                v[n].z/sqrt(sqr(v[n].x)+sqr(v[n].y)+sqr(v[n].z)),
                angle
            );
end;



procedure Action(ch:char);
begin
    case ch of
        #0:
        begin
            ch:=ReadKey();
            case ch of
                #77:begin//вправо
                    Move(10,0,0);
                    Axonometric(q,w);
                end;
                #75:begin//влево
                    Move(-10,0,0);
                    Axonometric(q,w);
                end;
                #72:begin//вверх
                    Move(0,-10,0);
                    Axonometric(q,w);
                end;
                #80:begin//вниз
                    Move(0,10,0);
                    Axonometric(q,w);
                end;  
                #73:begin
                    Move(0,0,10);
                    Axonometric(q,w);
                end;
                #81:begin
                    Move(0,0,-10);
                    Axonometric(q,w);
                
                end;  
            end;
        end;
        
        #49:begin
            Symmetry(-1,1,1);
            Axonometric(q,w);
            
        end;
        #50:begin
            Symmetry(1,-1,1);
            Axonometric(q,w);
            
        end;
        #51:begin
            Symmetry(1,1,-1);
            Axonometric(q,w);
        end;


        #26:begin
            Scaling(0.9,1,1,v[0]);
            Axonometric(q,w);
            
        end;
        #1:begin
            Scaling(1.1,1,1,v[0]);
            Axonometric(q,w);
            
        end;
        #24:begin
            Scaling(1,0.9,1,v[0]);
            Axonometric(q,w);
            
        end;
        #19:begin
            Scaling(1,1.1,1,v[0]);
            Axonometric(q,w);
            
        end;
        #3:begin
            Scaling(1,1,0.9,v[0]);
            Axonometric(q,w);
            
        end;
        #4:begin
            Scaling(1,1,1.1,v[0]);
            Axonometric(q,w);
            
        end;
        #52:begin
            rotationAxisX(30);
            Axonometric(q,w);
        end;
        #53:begin
            rotationAxisY(30);
            Axonometric(q,w);
        end;
        #54:begin
            rotationAxisZ(30);
            Axonometric(q,w);
        end;
        #55:begin
            rotationDiagonal(6,30);
            Axonometric(q,w);
        end;
        #56:begin
            rotationDiagonal(3,30);
            Axonometric(q,w);
        end;
        #57:begin
            rotationDiagonal(4,30);
            Axonometric(q,w);
        end;
        #18:begin
            v:=a;
            Axonometric(q,w);
        end;


    end;
end;


begin
    
    g := detect;
    initgraph(g,h,'');
    setcolor(11);
    Axonometric(q,w);
    repeat
        ch:=ReadKey();
        Action(ch);

    until ch=#27;




    CloseGraph();
end.