program lab4;

uses graph,crt,wincrt,math;

type
    TCrd=record
        x,y:integer;

    end;
    PStack = ^TStack;	
    TStack = record
        x, y: integer;
        prev: PStack;
    end;
    TPoly=array[1..5] of TCrd;

var g,h: integer;
    ch:char;
    poly:array[1..6] of TCrd;
    poly2:TPoly;

    stack, tmp: PStack;

procedure push(x, y: integer);
begin
    tmp := stack;
    new(stack);
    stack^.x := x;
    stack^.y := y;
    stack^.prev := tmp;
end;

procedure pop(var x, y: integer);
begin
    x := stack^.x;
    y := stack^.y;
    tmp := stack;
    stack := stack^.prev;
    dispose(tmp);
end;

procedure drawBrush(x0, y0, ci, cb: integer);
var x, y, xw, xb, xr, xl, j: integer;
fl: boolean;
begin
push(x0, y0);
while stack^.prev <> nil do
begin
    crt.delay(10);
    pop(x, y);
    putPixel(x, y, ci);
    xw := x;
    inc(x);
    while getPixel(x, y) <> cb do
    begin
        putPixel(x, y, ci);
        inc(x);
    end;
    xr := x - 1;
    x := xw - 1;
    dec(x);
    while getPixel(x, y) <> cb do
    begin
        putPixel(x, y, ci);
        dec(x);
    end;
    xl := x + 1;
    j := -1;
    repeat
        x := xl;
        y := y + j;
        while x <= xr do
        begin
            fl := false;
            while (getPixel(x, y) <> cb) and (getPixel(x, y) <> ci) and (x < xr) do
            begin
                inc(x);
                fl := true;
            end;
            if fl then
            begin
                if(x = xr) and (getPixel(x, y) <> cb) and (getPixel(x, y) <> ci) then
                    push(x, y)
                else
                    push(x - 1, y);
                fl := false;
            end;
            xb := x;
            while(getPixel(x, y) = cb) or (getPixel(x, y) = ci) and (x < xr) do
                inc(x);
            if (x = xb) then
                inc(x);
        end;
        j := j + 3;
    until j > 2;
end;   
end;

procedure BrushPoly2(poly:TPoly;col:integer);
var minY,maxY:integer;
    i,j:integer;
    x1,x2:integer;
    //l:boolean=true;
begin
    minY:=poly[1].y;
    maxY:=poly[1].y;
    x1:=poly[1].x;
    x2:=x1;
    for i:=2 to 5 do
    begin
        if (maxY<poly[i].y) then
        begin
            maxY:=poly[i].y;
            
        end;
        if (minY>poly[i].y) then
        begin
            minY:=poly[i].y;
            x1:=poly[i].x;
            x2:=x1;
        end;
    end;
    
    for i:=minY+1 to maxY do
    begin
        j:=x1+((x2-x1) div 2);
        crt.delay(10);
        while getPixel(j,i) <> col do
        begin
            Dec(j);
        end;
        x1:=j;
        j:=x1+1;
        While getPixel(j,i) <> col do
        begin
            Inc(j);
        end;
        x2:=j;
        line(x1,i,x2,i);
    end;
end;





procedure InitPolys();
var i:integer;
begin
    poly[1].x := 250;
    poly[1].y := 110;
    poly[2].x := 390;
    poly[2].y := 150;
    poly[3].x := 500;
    poly[3].y := 120;
    poly[4].x := 460;
    poly[4].y := 300;
    poly[5].x := 330;
    poly[5].y := 320;
    poly[6].x := 250;
    poly[6].y := 110;


    poly2[1].x := 700;
    poly2[1].y := 290;
    poly2[2].x := 750;
    poly2[2].y := 300;
    poly2[3].x := 800;
    poly2[3].y := 390;
    poly2[4].x := 600;
    poly2[4].y := 430;
    poly2[5].x := 650;
    poly2[5].y := 310;

    for i:= 1 to 5 do
    begin
        line(poly[i].x,poly[i].y,poly[i+1].x,poly[i+1].y);
    end;

    for i:= 1 to 4 do
    begin
        line(poly2[i].x,poly2[i].y,poly2[i+1].x,poly2[i+1].y);
    end;
    line(poly2[5].x,poly2[5].y,poly2[1].x,poly2[1].y);

    moveto(400,190);
    lineto(450,210);
    lineto(400,220);
    lineto(395,200);
    lineto(400,190);

    moveto(340,210);
    lineto(320,190);
    lineto(355,200);
    lineto(340,210);

end;



begin
    g := detect;
    initgraph(g,h,'');
    setcolor(10);

    InitPolys();
    
    repeat
        ch:=ReadKey();
        if ch = #1 then
        begin
            new(stack);
            stack^.Prev := nil;
            drawBrush(480, 135, 11, 10);
            dispose(stack);
        end;
        if ch = #2 then
        begin
            setcolor(11);
            BrushPoly2(poly2,10);
        end;
    until (ch=#27);
    closeGraph();
end.