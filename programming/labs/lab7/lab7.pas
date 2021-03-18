program lab7;
uses graph,math,wincrt,fractalModule;
const   eps=1e-6;
        step=10.0;
        scale=10.0;
var 
    d,m:integer;
    x,y:real;
    x1,x2,y1,y2:real;
    ch:char;
    code:integer;
    depth:integer;
    s:Boolean=true;


procedure ShowInfo();
begin
    OutTextXY(10,10,'Minkowski Curve');
    OutTextXY(10,20,'<up> - move to the up');
    OutTextXY(10,30,'<down> - move to the down');
    OutTextXY(10,40,'<right> - move to the right');
    OutTextXY(10,50,'<left> - move to the left');
    OutTextXY(10,60,'<q> - increase the depth');
    OutTextXY(10,70,'<a> - reduce the depth');
    OutTextXY(10,80,'<w> - zoom in');
    OutTextXY(10,90,'<s> - zoom out');
    OutTextXY(10,100,'<Esc> - Exit');
end;



begin
    d:=detect;
    initgraph(d,m,'');
    x:=getMaxX;
    y:=getMaxY;

    
    x1:=x/5;
    x2:=(x/5)*4;

    y1:=y/2;
    y2:=y/2;
    depth:=4;
    repeat 
        if s then
        begin
            cleardevice;
            fractal(x1, y1, x2 ,y2,depth);
            ShowInfo();
        end;

        s:=true;
        ch:=readkey();
        code:=ord(ch);

        if code = 0 then
        begin
            ch:=readkey();
            code:=ord(ch);
            case code of
                72 : // up
                begin
                    if y1 < getmaxy()+100 then
                    begin
                        y1:=y1+step;
                        y2:=y2+step;
                    end;
                end;
                    
                80 : // down
                begin
                    if y1 > -100 then
                    begin
                        y1:=y1-step;
                        y2:=y2-step;
                    end;
                end;
                75 : // left
                    if x2 < getmaxx()+200 then
                    begin
                        x1:=x1+step;
                        x2:=x2+step;
                    end;
                    
                77 : // right
                begin
                    if x1 > -200 then
                    begin
                        x1:=x1-step;
                        x2:=x2-step;
                    end;
                end;
                else
                begin
                    s:=false;
                end;
            end;
        end
        else 
        case code of
            113://q увеличить глубину прорисовки
                begin
                    if depth<7 then
                    begin
                        depth:=depth+1;
                    end 
                    else
                    begin
                        s := false;
                    end;
                    
                end;
            97://a уменьшить глубину прорисовки
                begin
                    if depth>0 then
                    begin
                        depth:=depth-1;
                    end
                    else
                    begin
                        s := false;
                    end;
                    
                end;
            119: // w - увеличить
                begin
                    
                    if(x2-x1)<10000 then
                    begin
                        y1:=y1-scale*((y/2)-y1)/((x2-x1)/2);
                        y2:=y1;
                        x1:=x1-scale*2*((x/2)-x1)/((x2-x1));
                        x2:=x2+scale*2*(x2-(x/2))/((x2-x1));
                    end;
                    
                end;
            115: // s - уменьшить
                begin
                    if x2-scale*10>x1+eps then
                    begin
                        y1:=y1+scale*((y/2)-y1)/((x2-x1)/2);
                        y2:=y1;
                        x1:=x1+scale*2*((x/2)-x1)/((x2-x1));
                        x2:=x2-scale*2*(x2-(x/2))/((x2-x1));
                        
                    end else
                    begin
                        s := false;
                    end;
                end;
            99: // c - сброс
                begin
                    x1:=x/5;
                    x2:=(x/5)*4;

                    y1:=y/2;
                    y2:=y/2;
                    depth:=4;
                end;
            else
                s := false;
        end;

    until code = 27;
    CloseGraph;
end.