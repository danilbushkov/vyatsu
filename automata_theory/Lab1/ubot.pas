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

type
  btlocations=array of tlocation;
  btmoves=record
        ms:Tmoves;
        start:tcrd;
        ls:btlocations;
    end;

var tmpPlayer:integer;


procedure moveBot();
function checkMoveCapture(x,y:integer;var location:tlocation):boolean;
function BGetMoveCapture(crd:tcrd;  //координаты
                 location:Tlocation; //поле
                 move:Tmove;
                 var moves:bTmoves;
                 depth:integer;   //глубина рукурсии
                 var i:integer):boolean;

function BGetLocation(crd:tcrd;  //координаты
                 location:Tlocation; //поле
                 var locations:btlocations;
                 depth:integer;   //глубина рукурсии
                 var i:integer):boolean;  //количество ходов


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



procedure BLocationCapture(crd:tcrd;  //координаты
                 var l:Tlocation; //поле
                 var locations:btlocations;
                 var depth:integer;   //глубина рукурсии
                 var i:integer;
                 dx,dy:integer);
var a:boolean;
begin
       //НАЧАЛЬНУЮ ШАШКУ ТОЖЕ НУЖНО ЗАНЕСТИ


       l[crd.cellx+2*dx,crd.celly+2*dy]:=l[crd.cellx,crd.celly];
       l[crd.cellx,crd.celly]:=0;
       l[crd.cellx+dx,crd.celly+dy]:=0;

       crd.cellx:=crd.cellx+dx*2;
       crd.celly:=crd.celly+dy*2;



       a:=BGetLocation(crd,l,locations,depth+1,i);
       if(not a) then
       begin
           setlength(locations,i+1);
           locations[i]:=l;

           inc(i);
           //добавить локацию
       end;
end;





//Получить возможную локацию рубки
function BGetLocation(crd:tcrd;  //координаты
                 location:Tlocation; //поле
                 var locations:btlocations;
                 depth:integer;   //глубина рукурсии
                 var i:integer):boolean;  //количество ходов
var x,y:integer;
  a:boolean;
begin
     a:=false;
     x:=crd.cellx;
     y:=crd.celly;
     //левый верхний угол
     if( (x-2)>=0 ) and ( (y-2)>=0 ) then
     begin
        if(location[x-2,y-2] = 0) and (checkPlayer(location[x-1,y-1],1)) then
        begin
           BlocationCapture(crd,location,locations,depth,i,-1,-1);
           a:=true;
        end;
     end;

     //правый верхний угол
     if( (x+2)<8 ) and ( (y-2)>=0 ) then
     begin
        if(location[x+2,y-2] = 0) and (checkPlayer(location[x+1,y-1],1)) then
        begin
            BlocationCapture(crd,location,locations,depth,i,1,-1);
            a:=true;
        end;
     end;

     //левый нижний угол
     if( (x-2)>=0 ) and ( (y+2)<8 ) then
     begin
        if(location[x-2,y+2] = 0) and (checkPlayer(location[x-1,y+1],1)) then
        begin
            BlocationCapture(crd,location,locations,depth,i,-1,1);
            a:=true;
        end;
     end;

     //правый нижний угол
     if( (x+2)<8 ) and ( (y+2)<8 ) then
     begin
        if(location[x+2,y+2] = 0) and (checkPlayer(location[x+1,y+1],1)) then
        begin

             BlocationCapture(crd,location,locations,depth,i,1,1);
             a:=true;
        end;
     end;


     Exit(a);
end;





















procedure BCapture(crd:tcrd;  //координаты
                 var l:Tlocation; //поле
                 var move:Tmove;
                 var moves:bTmoves;
                 var depth:integer;   //глубина рукурсии
                 var i:integer;
                 dx,dy:integer);
var a:boolean;
begin
       //НАЧАЛЬНУЮ ШАШКУ ТОЖЕ НУЖНО ЗАНЕСТИ


       l[crd.cellx+2*dx,crd.celly+2*dy]:=l[crd.cellx,crd.celly];
       l[crd.cellx,crd.celly]:=0;
       l[crd.cellx+dx,crd.celly+dy]:=0;

       crd.cellx:=crd.cellx+dx*2;
       crd.celly:=crd.celly+dy*2;

       setlength(move,depth+1);
       move[depth]:=crd;

       a:=BGetMoveCapture(crd,l,move,moves,depth+1,i);
       if(not a) then
       begin
           setlength(moves.ms,i+1);
           setlength(moves.ls,i+1);
           moves.ms[i]:=move;
           moves.ls[i]:=l;

           inc(i);
           //добавить локацию
       end;
end;
















//Получить возможную рубку
function BGetMoveCapture(crd:tcrd;  //координаты
                 location:Tlocation; //поле
                 move:Tmove;
                 var moves:bTmoves;
                 depth:integer;   //глубина рукурсии
                 var i:integer):boolean;  //количество ходов
var x,y:integer;
  a:boolean;
begin
     a:=false;
     x:=crd.cellx;
     y:=crd.celly;
     //левый верхний угол
     if( (x-2)>=0 ) and ( (y-2)>=0 ) then
     begin
        if(location[x-2,y-2] = 0) and (checkPlayer(location[x-1,y-1],1)) then
        begin
           BCapture(crd,location,move,moves,depth,i,-1,-1);
           a:=true;
        end;
     end;

     //правый верхний угол
     if( (x+2)<8 ) and ( (y-2)>=0 ) then
     begin
        if(location[x+2,y-2] = 0) and (checkPlayer(location[x+1,y-1],1)) then
        begin
            BCapture(crd,location,move,moves,depth,i,1,-1);
            a:=true;
        end;
     end;

     //левый нижний угол
     if( (x-2)>=0 ) and ( (y+2)<8 ) then
     begin
        if(location[x-2,y+2] = 0) and (checkPlayer(location[x-1,y+1],1)) then
        begin
            BCapture(crd,location,move,moves,depth,i,-1,1);
            a:=true;
        end;
     end;

     //правый нижний угол
     if( (x+2)<8 ) and ( (y+2)<8 ) then
     begin
        if(location[x+2,y+2] = 0) and (checkPlayer(location[x+1,y+1],1)) then
        begin

             BCapture(crd,location,move,moves,depth,i,1,1);
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
     if( (x-2)>=0 ) and ( (y-2)>=0 ) then
     begin
        if(location[x-2,y-2] = 0) and (checkPlayer(location[x-1,y-1],1)) then
        begin
             Exit(true);
        end;
     end;

     //правый верхний угол
     if( (x+2)<8 ) and ( (y-2)>=0 ) then
     begin
        if(location[x+2,y-2] = 0) and (checkPlayer(location[x+1,y-1],1)) then
        begin
             Exit(true);
        end;
     end;

     //левый нижний угол
     if( (x-2)>=0 ) and ( (y+2)<8 ) then
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


function getSimpleLocation(crd:tcrd;var ls:btlocations;l:tlocation):boolean;
var d:integer=1;
    tmpCrd:tcrd;
    var i:integer=0;
    var x,y:integer;
    var tmpl:tlocation;
begin
     if(tmpPlayer=1) then
     begin
        d:=-1;
     end;
     tmpCrd:=crd;
     x:=crd.cellx;
     y:=crd.celly;
     tmpL:=l;
     if( (x-1)>=0 ) and ( ((y+d)<8) and ((y+d)>=0) ) then
      begin
        if(l[x-1,y+d] = 0) then
        begin
           tmpCrd.cellx:=tmpCrd.cellx-1;
           tmpCrd.cellx:=tmpCrd.cellx+d;

           tmpl[crd.cellx,crd.celly]:=l[x,y];
           tmpl[x,y]:=0;

           setLength(ls,i+1);
           ls[i]:=l;
           inc(i);

        end;
     end;
     tmpL:=l;
     if( (x+1)<8 ) and ( ((y+d)<8) and ((y+d)>=0) ) then
     begin
        if(l[x+1,y+d] = 0) then
        begin
           tmpCrd.cellx:=tmpCrd.cellx+1;
           tmpCrd.cellx:=tmpCrd.cellx+d;

           tmpl[crd.cellx,crd.celly]:=l[x,y];
           tmpl[x,y]:=0;

           setLength(ls,i+1);
           ls[i]:=l;

           inc(i);
        end;
     end;
     if(i=0) then
     begin
        Exit(false);
     end
     else
     begin
        Exit(true);
     end;
end;



function getSimpleMove(crd:tcrd;var ms:btmoves;l:tlocation):boolean;
var d:integer=1;
    tmpCrd:tcrd;
    var i:integer=0;
    var x,y:integer;
    var tmpl:tlocation;
begin
     if(tmpPlayer=1) then
     begin
        d:=-1;
     end;
     tmpL:=l;
     tmpCrd:=crd;
     x:=crd.cellx;
     y:=crd.celly;

     if( (x-1)>=0 ) and ( ((y+d)<8) and ((y+d)>=0) ) then
      begin
        if(l[x-1,y+d] = 0) then
        begin
           tmpCrd.cellx:=tmpCrd.cellx-1;
           tmpCrd.cellx:=tmpCrd.cellx+d;

            tmpl[crd.cellx,crd.celly]:=l[x,y];
            tmpl[x,y]:=0;

           setLength(ms.ls,i+1);
           setLength(ms.ms,i+1);
           setLength(ms.ms[i],1);
           ms.ls[i]:=l;
           ms.ms[i][i]:=tmpCrd;
           inc(i);

        end;
     end;
     tmpL:=l;
     if( (x+1)<8 ) and ( ((y+d)<8) and ((y+d)>=0) ) then
     begin
        if(l[x+1,y+d] = 0) then
        begin
           tmpCrd.cellx:=tmpCrd.cellx+1;
           tmpCrd.cellx:=tmpCrd.cellx+d;

           tmpl[crd.cellx,crd.celly]:=l[x,y];
           tmpl[x,y]:=0;

           setLength(ms.ls,i+1);
           setLength(ms.ms,i+1);
           setLength(ms.ms[i],1);
           ms.ls[i]:=l;
           ms.ms[i][i]:=tmpCrd;
           inc(i);
        end;
     end;
     if(i=0) then
     begin
        Exit(false);
     end
     else
     begin
        Exit(true);
     end;
end;

//function checkMoveSimple(x,y:integer;var location:tlocation):boolean;
//begin
//     //проверка шага
//     //левый нижний угол
//     if( (x-1)>=0 ) and ( (y+1)<8 ) then
//     begin
//        if(location[x-1,y+1] = 0) then
//        begin
//             Exit(true);
//        end;
//     end;
//
//     if( (x+1)<8 ) and ( (y+1)<8 ) then
//     begin
//        if(location[x+1,y+1] = 0) then
//        begin
//             Exit(true);
//        end;
//     end;
//
//
//     Exit(false);
//
//end;




end.

