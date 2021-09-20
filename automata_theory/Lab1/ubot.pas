unit UBot;

{$mode objfpc}{$H+}


                        //x
     //location[x,y]    // 0 1 2 3 4 5 6 7
                        // 1 21          24
                        // 2 17
                        // 3
                  //y   // 4
                        // 5
                        // 6
                        // 7 1


interface

uses
  Classes, SysUtils,checkerunit;

procedure moveBot();
function checkMoveCapture(x,y:integer;var location:tlocation):boolean;

implementation



//ход бота
procedure moveBot();
var i,j: Integer;
begin
     for j:=0 to 7 do
     begin
         for i:=0 to 7 do
         begin
             if checkPlayer(location[i,j],player) then
             begin
               //if checkMove(i,j,location) then
               //begin
               //
               //end;
             end;
         end;
     end;

end;

procedure BCapture(var crd:tcrd;  //координаты
                 var location:Tlocation; //поле
                 var move:Tmove;
                 var moves:Tmoves;
                 var depth:integer;   //глубина рукурсии
                 var i:integer);
begin


end;

//Получить возможную рубку
function GetMove(crd:tcrd;  //координаты
                 location:Tlocation; //поле
                 move:Tmove;
                 moves:Tmoves;
                 depth:integer;   //глубина рукурсии
                 var i:integer):boolean;  //количество ходов
var x,y:integer;
  a:boolean;
begin
     a:=false;
     x:=crd.cellx;
     y:=crd.celly;
     //левый верхний угол
     if( (x-2)>0 ) and ( (y-2)>0 ) then
     begin
        if(location[x-2,y-2] = 0) and (checkPlayer(location[x-1,y-1],1)) then
        begin
           BCapture(crd,location,move,moves,depth,i);
           a:=true;
        end;
     end;

     //правый верхний угол
     if( (x+2)<8 ) and ( (y-2)>0 ) then
     begin
        if(location[x+2,y-2] = 0) and (checkPlayer(location[x+1,y-1],1)) then
        begin
            BCapture(crd,location,move,moves,depth,i);
            a:=true;
        end;
     end;

     //левый нижний угол
     if( (x-2)>0 ) and ( (y+2)<8 ) then
     begin
        if(location[x-2,y+2] = 0) and (checkPlayer(location[x-1,y+1],1)) then
        begin
            BCapture(crd,location,move,moves,depth,i);
            a:=true;
        end;
     end;

     //правый нижний угол
     if( (x+2)<8 ) and ( (y+2)<8 ) then
     begin
        if(location[x+2,y+2] = 0) and (checkPlayer(location[x+1,y+1],1)) then
        begin
             BCapture(crd,location,move,moves,depth,i);
             a:=true;
        end;
     end;


     Exit(a);
end;


//Проверить на Рубку
function checkMoveCapture(x,y:integer;var location:tlocation):boolean;
begin
     //проверить рубку

     //левый верхний угол
     if( (x-2)>0 ) and ( (y-2)>0 ) then
     begin
        if(location[x-2,y-2] = 0) and (checkPlayer(location[x-1,y-1],1)) then
        begin
             Exit(true);
        end;
     end;

     //правый верхний угол
     if( (x+2)<8 ) and ( (y-2)>0 ) then
     begin
        if(location[x+2,y-2] = 0) and (checkPlayer(location[x+1,y-1],1)) then
        begin
             Exit(true);
        end;
     end;

     //левый нижний угол
     if( (x-2)>0 ) and ( (y+2)<8 ) then
     begin
        if(location[x-2,y+2] = 0) and (checkPlayer(location[x-1,y+1],1)) then
        begin
             Exit(true);
        end;
     end;

     //правый нижний угол
     if( (x+2)<8 ) and ( (y+2)<8 ) then
     begin
        if(location[x+2,y+2] = 0) and (checkPlayer(location[x+1,y+1],1)) then
        begin
             Exit(true);
        end;
     end;


     Exit(false);

end;

function checkMoveSimple(x,y:integer;var location:tlocation):boolean;
begin
     //проверка шага
     //левый нижний угол
     if( (x-1)>0 ) and ( (y+1)<8 ) then
     begin
        if(location[x-1,y+1] = 0) then
        begin
             Exit(true);
        end;
     end;

     if( (x+1)<8 ) and ( (y+1)<8 ) then
     begin
        if(location[x+1,y+1] = 0) then
        begin
             Exit(true);
        end;
     end;


     Exit(false);

end;




end.

