unit ushapes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Graphics,math;

procedure line(x1,y1,x2,y2,col:integer;var t:Tbitmap);
Procedure lineBr8(x1,y1,x2,y2,col:integer;var bm:Tbitmap);
Procedure lineBr4(x1,y1,x2,y2,col:integer;var bm:Tbitmap);
procedure circle(x1,y1:integer;rad:integer;col:integer;var bm:Tbitmap);
procedure simpleCircle(x0,y0:integer;R:integer;col:Tcolor;bm:Tbitmap);

implementation

procedure line(x1,y1,x2,y2,col:integer;var t:Tbitmap);
var x:integer;
	m,y:real;

begin
	if x1<>x2 then
	begin
		m:=(y2-y1)/(x2-x1);
		y:=y1;
		for x:=x1 to x2 do
		begin
			t.Canvas.Pixels[x,round(y)]:=col;
			y:=y+m;
		end;
	end
	else
	begin
		if y1=y2 then
		begin
			t.Canvas.Pixels[x1,y1]:=col;
		end
		else
		begin
		    //вертикаль
		end;
	end;
end;

Procedure lineBr8(x1,y1,x2,y2,col:integer;var bm:Tbitmap);
var x,t,i:integer;
	e,y,dx,dy,s1,s2:integer;
	l:boolean;
begin
	x:=x1;
	y:=y1;
	dx:=abs(x2-x1);
	dy:=abs(y2-y1);
	s1:=sign(x2-x1);
	s2:=sign(y2-y1);
	if dy>dx then
	begin
		t:=dx;
		dx:=dy;
		dy:=t;
		l:=true;
	end
	else
	begin
		l:=false;
	end;
	e:=2*dy-dx;
	for i:=1 to dx do
	begin
		bm.Canvas.Pixels[x,y]:=col;
		while (e>=0) do
		begin
			if(l) then
			begin
				x:=x+s1;
			end
			else
			begin
				y:=y+s2;
			end;
			e:=e-2*dx;
		end;
		if(l) then
		begin

			y:=y+s2;
		end
		else
		begin
			x:=x+s1;
		end;
		e:=e+2*dy;
	end;

	bm.Canvas.Pixels[x,y]:=col;

end;

Procedure lineBr4(x1,y1,x2,y2,col:integer;var bm:Tbitmap);
var x,t,i:integer;
	e,y,dx,dy,s1,s2:integer;
	l:boolean;
begin
	x:=x1;
	y:=y1;
	dx:=abs(x2-x1);
	dy:=abs(y2-y1);
	s1:=sign(x2-x1);
	s2:=sign(y2-y1);
	if dy<dx then
	begin
		l:=false;
	end
	else
	begin
		t:=dx;
		dx:=dy;
		dy:=t;
		l:=true;
	end;
	e:=2*dy-dx;
	for i:=1 to dx+dy do
	begin
		bm.Canvas.Pixels[x,y]:=col;


		if e<0 then
		begin
			if l then
			begin
				y:=y+s2;
			end
			else
			begin
				x:=x+s1;
			end;
			e:=e+2*dy;
		end
		else
		begin
			if l then
			begin

				x:=x+s1;
			end
			else
			begin
				y:=y+s2;
			end;
			e:=e-2*dx;
		end;


	end;
	bm.Canvas.Pixels[x,y]:=col;
end;




procedure circle(x1,y1:integer;rad:integer;col:integer;var bm:Tbitmap);
var
	x,y:integer;
	e:integer;
begin

	x:=0;
	y:=rad;
	e:=3-2*rad;
	while x<y do
	begin
		bm.Canvas.Pixels[x1+x,y1+y]:=col;//
                bm.Canvas.Pixels[y1+y,x1+x]:=col;//
                bm.Canvas.Pixels[y1+y,x1-x]:=col;//
                bm.Canvas.Pixels[x1+x,y1-y]:=col;//

                bm.Canvas.Pixels[x1-x,y1-y]:=col; //
                bm.Canvas.Pixels[y1-y,x1-x]:=col; //
                bm.Canvas.Pixels[y1-y,x1+x]:=col;
                bm.Canvas.Pixels[x1-x,y1+y]:=col;

		if e<0 then
		begin
			e:=e+4*x+6;

		end
		else
		begin
			e:=e+4*(x-y)+10;
			y:=y-1;
		end;
		x:=x+1;

	end;
	if x=y then
	begin
           	bm.Canvas.Pixels[x1+x,y1+y]:=col;//
                bm.Canvas.Pixels[y1+y,x1+x]:=col;//
                bm.Canvas.Pixels[y1+y,x1-x]:=col;//
                bm.Canvas.Pixels[x1+x,y1-y]:=col;//

                bm.Canvas.Pixels[x1-x,y1-y]:=col; //
                bm.Canvas.Pixels[y1-y,x1-x]:=col; //
                bm.Canvas.Pixels[y1-y,x1+x]:=col;
                bm.Canvas.Pixels[x1-x,y1+y]:=col;


        end;
end;

procedure simpleCircle(x0,y0:integer;R:integer;col:Tcolor;bm:Tbitmap);
var x,y:integer;
begin
    x:=0;
    while x<=R do
    begin
            y:=round( sqrt( r*r-x*x ) );
            bm.Canvas.Pixels[x0-x,y0-y]:=col; //
            bm.Canvas.Pixels[x0-x,y0+y]:=col; //
            bm.Canvas.Pixels[x0+x,y0+y]:=col;
            bm.Canvas.Pixels[x0+x,y0-y]:=col;
            x:=x+1;
    end;
end;



end.

