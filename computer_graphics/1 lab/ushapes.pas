unit ushapes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Graphics,math;

procedure line(x1,y1,x2,y2,col:integer);
Procedure lineBr8(x1,y1,x2,y2,col:integer);
Procedure lineBr4(x1,y1,x2,y2,col:integer);
procedure circle(x1,y1:integer;rad:integer;col:integer);
procedure simpleCircle(x0,y0:integer;R:integer;col:Tcolor);
procedure Uline(x1,y1,x2,y2,col:integer);
procedure star(x1,y1,len,col:integer);

implementation
uses main;

procedure line(x1,y1,x2,y2,col:integer);
var x:integer;
	m,y:real;
        yt:integer;

begin
	if x1<>x2 then
	begin
		m:=(y2-y1)/(x2-x1);
		y:=y1;
		for x:=x1 to x2 do
		begin
			Form1.bm.Canvas.Pixels[x,round(y)]:=col;
                        sleep(5);
                        Form1.Canvas.Draw(0,0,Form1.bm);
			y:=y+m;
		end;
	end
	else
	begin
		if y1=y2 then
		begin
			Form1.bm.Canvas.Pixels[x1,y1]:=col;
		end
		else
		begin
		    //вертикаль
                        if y1 > y2 then
                        begin
                            for yt:=y2 to y1 do
                            begin
                                Form1.bm.Canvas.Pixels[x1,yt]:=col;
                                Form1.Canvas.Draw(0,0,Form1.bm);
                                sleep(5);
                            end;

                        end
                        else
                        begin
                            for yt:=y1 to y2 do
                            begin
                                Form1.bm.Canvas.Pixels[x1,yt]:=col;
                                Form1.Canvas.Draw(0,0,Form1.bm);
                                sleep(5);
                            end;
                        end;


		end;
	end;
end;


procedure Uline(x1,y1,x2,y2,col:integer);
var //x:integer;
	x,m,y,k1,k2:real;
        i:integer;
        dx,dy,d:integer;
begin
      x:=x1;
      y:=y1;
      dx:=x2-x1;
      dy:=y2-y1;
      d:=(max(abs(dx),abs(dy)));
      k1:=real(dx)/d;
      k2:=real(dy)/d;
      i:=0;
      while i<d do
      begin
          x:=x+k1;
          y:=y+k2;
          Form1.bm.Canvas.Pixels[round(x),round(y)]:=col;
          sleep(5);
          Form1.Canvas.Draw(0,0,Form1.bm);
          I:=I+1;
      end;

end;

Procedure lineBr8(x1,y1,x2,y2,col:integer);
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
		Form1.bm.Canvas.Pixels[x,y]:=col;
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
                sleep(5);
                Form1.Canvas.Draw(0,0,Form1.bm);
		e:=e+2*dy;
	end;

	Form1.bm.Canvas.Pixels[x,y]:=col;

end;

Procedure lineBr4(x1,y1,x2,y2,col:integer);
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
		Form1.bm.Canvas.Pixels[x,y]:=col;


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

                sleep(5);
                Form1.Canvas.Draw(0,0,Form1.bm);

	end;
	Form1.bm.Canvas.Pixels[x,y]:=col;
end;




procedure circle(x1,y1:integer;rad:integer;col:integer);
var
	x,y:integer;
	e:integer;
begin

	x:=0;
	y:=rad;
	e:=3-2*rad;
	while x<y do
	begin
		Form1.bm.Canvas.Pixels[x1+x,y1+y]:=col;//
                Form1.bm.Canvas.Pixels[X1+y,Y1+x]:=col;//
                Form1.bm.Canvas.Pixels[X1+y,Y1-x]:=col;//
                Form1.bm.Canvas.Pixels[x1+x,y1-y]:=col;//

                Form1.bm.Canvas.Pixels[x1-x,y1-y]:=col; //
                Form1.bm.Canvas.Pixels[X1-y,Y1-x]:=col; //
                Form1.bm.Canvas.Pixels[X1-y,Y1+x]:=col;
                Form1.bm.Canvas.Pixels[x1-x,y1+y]:=col;

		if e<0 then
		begin
			e:=e+4*x+6;

		end
		else
		begin
			e:=e+4*(x-y)+10;
			y:=y-1;
		end;
                sleep(5);
                Form1.Canvas.Draw(0,0,Form1.bm);
		x:=x+1;

	end;
	if x=y then
	begin
           	Form1.bm.Canvas.Pixels[x1+x,y1+y]:=col;//
                Form1.bm.Canvas.Pixels[X1+y,Y1+x]:=col;//
                Form1.bm.Canvas.Pixels[X1+y,Y1-x]:=col;//
                Form1.bm.Canvas.Pixels[x1+x,y1-y]:=col;//

                Form1.bm.Canvas.Pixels[x1-x,y1-y]:=col; //
                Form1.bm.Canvas.Pixels[X1-y,Y1-x]:=col; //
                Form1.bm.Canvas.Pixels[X1-y,Y1+x]:=col;
                Form1.bm.Canvas.Pixels[x1-x,y1+y]:=col;


        end;
end;

procedure simpleCircle(x0,y0:integer;R:integer;col:Tcolor);
var x,y:integer;
begin
    x:=0;
    while x<=R do
    begin
            y:=round( sqrt( r*r-x*x ) );
            Form1.bm.Canvas.Pixels[x0-x,y0-y]:=col; //
            Form1.bm.Canvas.Pixels[x0-x,y0+y]:=col; //
            Form1.bm.Canvas.Pixels[x0+x,y0+y]:=col;
            Form1.bm.Canvas.Pixels[x0+x,y0-y]:=col;
            sleep(5);
            Form1.Canvas.Draw(0,0,Form1.bm);
            x:=x+1;
    end;
end;


procedure star(x1,y1,len,col:integer);
var step:real;
    i:integer;
    angle:real;
    x,y:real;
begin
      step:=pi/10;
      for i:=0 to 20 do
      begin
          angle:=i*step;
          x:=cos(angle) * len + x1;
          y:=sin(angle) * len + y1;

          lineBr4(x1,y1,round(x),round(y),col);
          //sleep(10);
          //Form1.Canvas.Draw(0,0,Form1.bm);
      end;

end;

end.

