program lab2;

uses graph,math;

type 
	coordinates=record
		x,y:integer;
	end;

	points=array of coordinates;

var g, h,c,i: integer;
	P:points;
	
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
		
		putpixel(x,y,col);

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
	putpixel(x,y,col);
end;




procedure Bez(m:integer;P:points);
var
  x,y:integer;
  step,t:real;
  R:points;
  j,i:integer;

begin
   x:=P[0].x;
   y:=P[0].y;
   step:=0.01;
   t:=0;
   repeat
   R:=P;

   for j:= m downto 2 do begin
       for i:=1 to (j-1) do begin
         R[i-1].x := R[i-1].x + round(t * (R[i].x-R[i-1].x));
         R[i-1].y := R[i-1].y + round(t*(R[i].y-R[i-1].y));
       end;
   end;
   for i:=1 to m-1 do begin
	 lineBr4(R[i-1].x, R[i-1].y,R[i].x, R[i].y,10);
   end;
    lineBr4(x, y, R[0].x, R[0].y,10);
    //sleep(5);
    t:= t +step;
    x:=R[0].x;
    y:=R[0].y;
    until(t>1);
end;



begin
	writeln('Enter count points:');
	readln(c);
	setlength(p,c);
	for i:=0 to c-1 do
	begin
		write('Enter the X coordinate at the ',i+1,' point: ');
		readln(p[i].x);
		write('Enter the Y coordinate at the ',i+1,' point: ');
		readln(p[i].y);
	end;

	g := detect;
    initgraph(g,h,'');
 
    setcolor(10);
    Bez(c,p);
	
	readln();
end.