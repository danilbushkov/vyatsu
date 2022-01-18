program lab5;

uses graph, wincrt;

type 
    Tline=record
        x1,y1,x2,y2:integer;
    end;
    TWindow=record
        xl,
        ya,
        xr,
        yb:integer;
    end;

var ch:char;
    g,h:integer;
    lines:array[1..5] of Tline;
    window:TWindow;
    


function kod (x, y: integer; xl, ya, xr, yb: integer): byte;
var kp: byte;
begin
    kp := 0;
  	if x < xl then kp := kp or $01;
  	if y < ya then kp := kp or $02;
  	if x > xr then kp := kp or $04;
  	if y > yb then kp := kp or $08;
 	kod := kp;
end;



procedure clipping(xl, ya, xr, yb: integer; x1, y1, x2, y2: integer);
var p1, p2: byte;
    x, y: integer;
begin
  repeat
  begin
    
    p1 := kod(x1,y1,xl,ya,xr,yb);
    p2 := kod(x2,y2,xl,ya,xr,yb);
    if (p1 and p2) <> 0 then 
    exit; 
    
    if (p1=0) and (p2=0) then
    begin
      line(x1,y1,x2,y2);
      exit;
    end
    
    else
    begin
      
      if (p1 = 0) then
      begin
        x  := x1; 
        x1 := x2; 
        x2 := x;
        y  := y1; 
        y1 := y2; 
        y2 := y;
        p1 := p2;
      end;
      if (p1 = $01) then
      begin
        y1 := y1 + (y2 - y1)*(xl - x1) div (x2 - x1);
        x1 := xl;
      end
      else
      begin
        if (p1 = $02) then
        begin
          x1 := x1 + (x2 - x1)*(ya - y1) div (y2 - y1); 
          y1 := ya;
        end
        else
        begin
          if (p1 = $04) then
          begin
            y1 := y1 + (y2 - y1)*(xr - x1) div (x2 - x1); 
            x1 := xr;
          end
          else
          begin
            if (p1 = $08) then
            begin
              x1 := x1 + (x2 - x1)*(yb - y1) div (y2 - y1); 
              y1 := yb;
            end;
          end;
        end;
      end;
    end;
  end
  until (p1 = 0) and (p2 = 0); 
end;


procedure init();
var i:integer;
begin
    lines[1].x1:=200;
    lines[1].y1:=10;
    lines[1].x2:=800;
    lines[1].y2:=400;

    lines[2].x1:=820;
    lines[2].y1:=160;
    lines[2].x2:=250;
    lines[2].y2:=250;

    lines[3].x1:=200;
    lines[3].y1:=10;
    lines[3].x2:=200;
    lines[3].y2:=400;

    lines[4].x1:=700;
    lines[4].y1:=360;
    lines[4].x2:=500;
    lines[4].y2:=600;

    lines[5].x1:=400;
    lines[5].y1:=100;
    lines[5].x2:=300;
    lines[5].y2:=400;

    for i:=1 to 5 do
    begin
        line(Round(lines[i].x1),
        Round(lines[i].y1),
        Round(lines[i].x2),
        Round(lines[i].y2));
    end;

    window.xl:=170;
    window.ya:=70;
    window.xr:=600;
    window.yb:=500;

    rectangle(window.xl, window.ya, window.xr, window.yb);
end;


begin
    g := detect;
    initgraph(g,h,'');
    setcolor(10);
    init();
    setcolor(12);
    repeat
        ch:=ReadKey();
        if ch = #1 then
        begin
            
            clipping(window.xl,
                    window.ya,
                    window.xr,
                    window.yb,
                    lines[1].x1,
                    lines[1].y1,
                    lines[1].x2,
                    lines[1].y2);
            
        end;
        if ch = #2 then
        begin
            clipping(window.xl,
                    window.ya,
                    window.xr,
                    window.yb,
                    lines[2].x1,
                    lines[2].y1,
                    lines[2].x2,
                    lines[2].y2);
        end;
        if ch = #3 then
        begin
            clipping(window.xl,
                    window.ya,
                    window.xr,
                    window.yb,
                    lines[3].x1,
                    lines[3].y1,
                    lines[3].x2,
                    lines[3].y2);
        end;
        if ch = #4 then
        begin
            clipping(window.xl,
                    window.ya,
                    window.xr,
                    window.yb,
                    lines[4].x1,
                    lines[4].y1,
                    lines[4].x2,
                    lines[4].y2);
        end;
        if ch = #5 then
        begin
            clipping(window.xl,
                    window.ya,
                    window.xr,
                    window.yb,
                    lines[5].x1,
                    lines[5].y1,
                    lines[5].x2,
                    lines[5].y2);
        end;
    until (ch=#27);

    CloseGraph;
end.