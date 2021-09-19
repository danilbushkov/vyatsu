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
function checkMove(x,y:integer;var location:tlocation):boolean;

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
               if checkMove(i,j,location) then
               begin

               end;
             end;
         end;
     end;

end;


//Проверить на ход
function checkMove(x,y:integer;var location:tlocation):boolean;
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

