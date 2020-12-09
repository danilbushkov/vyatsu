program lab4;
uses Graph,crt;
var
grDriver, grMode,i,x: integer;
begin
grDriver:=detect; 
InitGraph(grDriver,grMode,''); 
line(20,453,1250,453); 
x:=100;
for i:=0 to 100 do begin
Setcolor(0); { Стирание}
rectangle(x-150,430,x+150,340);
circle(x-100,430,20);
circle(x+100,430,20);
x:=x+10; { Вычисление новой координаты}
Setcolor(11); { Рисование}
rectangle(x-150,430,x+150,340);
circle(x-100,430,20);
circle(x+100,430,20);
delay(100); { задержка}
end;
readln;
closegraph;
end.