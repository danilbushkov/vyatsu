unit fractalModule;


interface
uses graph;
procedure fractal(x1,y1,x2,y2:real;i:integer);


implementation

procedure fractal(x1,y1,x2,y2:real;i:integer);
var
    bx,by:real;
    cx,cy:real;
    dx,dy:real;
    ex,ey:real;
    fx,fy:real;
    gx,gy:real;
    hx,hy:real;
begin
    if i=0 then 
    begin
        line(round(x1),round(y1),round(x2),round(y2));
    end
    else
    begin
        
        bx:=x1+(x2-x1)*1/4;
        by:=y1+(y2-y1)*1/4;

        ex:=x1+(x2-x1)*2/4;
        ey:=y1+(y2-y1)*2/4;

        hx:=x1+(x2-x1)*3/4;
        hy:=y1+(y2-y1)*3/4;

        cx:=bx-(-1)*(ey-by);
        cy:=by+(ex-bx)*(-1);

        dx:=cx+(ex-bx);
        dy:=cy+(ey-by);

        fx:=ex-(1)*(ey-by);
        fy:=ey+(hx-ex)*(1);

        gx:=fx+(hx-ex);
        gy:=fy+(hy-ey);

        fractal(x1,y1,bx,by,i-1);
        fractal(bx,by,cx,cy,i-1);
        fractal(cx,cy,dx,dy,i-1);
        fractal(dx,dy,ex,ey,i-1);
        fractal(ex,ey,fx,fy,i-1);
        fractal(fx,fy,gx,gy,i-1);
        fractal(gx,gy,hx,hy,i-1);
        fractal(hx,hy,x2,y2,i-1);
    end;
end;

end.