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
  Classes, SysUtils,checkerunit,ExtCtrls,math;

type
  btlocations=array of tlocation;
  btmoves=record
        ms:Tmoves;
        start:tcrd;
        ls:btlocations;
        status:boolean;
        move:integer;
    end;

var tmpPlayer:integer=2;


function getmoveBot():btmoves;
function checkMoveCapture(x,y:integer;var location:tlocation):boolean;
function BGetMoveCapture(crd:tcrd;  //координаты
                 location:Tlocation; //поле
                 move:Tmove;
                 var moves:bTmoves;
                 depth:integer;   //глубина рукурсии
                 var i:integer):boolean;

function BGetLocationCapture(crd:tcrd;  //координаты
                 location:Tlocation; //поле
                 var locations:btlocations;
                 depth:integer;   //глубина рукурсии
                 var i:integer):boolean;  //количество ходов

function getSimpleLocation(crd:tcrd;var ls:btlocations;l:tlocation):boolean;
function getSimpleMove(crd:tcrd;var ms:btmoves;l:tlocation):boolean;
function checkMoveSimple(x,y:integer;var location:tlocation):boolean;
function BGetLocation(x,y:integer;var l:tlocation):bTlocations;
function BGetMove(x,y:integer;var l:tlocation):btmoves;
function minimax(location:tlocation;depth:integer;alpha,beta:integer;maxPlayer:boolean):integer;
procedure moveBot(var t:ttimer);

implementation



procedure moveBot(var t:ttimer);
var m:btmoves;
begin
     m:=getmoveBot();


     mt.Startpath:=m.start;
     mt.EndPath:=m.ms[m.move][length(m.ms[m.move])-1];
     mt.Sh:=checkers[location[m.start.cellx][m.start.celly]-1];
     mt.move:=m.ms[m.move];
     //location:=m.ls[m.move];
     mt.i:=0;
     mt.anim:=false;

     if abs(mt.EndPath.cellx - mt.Startpath.cellx) = 1 then
      begin
        mt.countPath:=0;
      end
      else
      begin
         mt.countPath:=length(mt.move);
      end;

     t.enabled:=true;

end;

//ход бота
function getmoveBot():btmoves;
var i,j,a: Integer;
    ms:btmoves;

    cap:boolean=false;
    eval:integer;
    maxEval:integer=-1000000;
    move:btmoves;
begin
     tmpplayer:=player;
     for j:=0 to 7 do
     begin
         for i:=0 to 7 do
         begin
             //проверка игрока
             if checkPlayer(location[i,j],player) then
             begin
               //проверка рубки шашки
               if checkMoveCapture(i,j,location) or checkMoveSimple(i,j,location) then
               begin
                  ms:=BGetMove(i,j,location);

                  if length(ms.ms)>0 then
                  begin
                     ms.start.cellx:=i;
                     ms.start.celly:=j;
                     //for a:=0 to length(ms.ms)-1 do
                     //begin
                     //     eval:=minimax(ms.ls[a],1,-1000000,1000000,false);
                     //     if eval>maxEval then
                     //     begin
                     //        maxEval:=eval;
                     //        move:=ms;
                     //        move.move:=a;
                     //     end;
                     //end;
                      move:=ms;
                      move.move:=0;
                  end;
               end;

             end;

         end;
     end;
     Exit(move); //вернуть ход
end;

function minimax(location:tlocation;depth:integer;alpha,beta:integer;maxPlayer:boolean):integer;
var maxEval,minEval,eval:integer;
    ls:btlocations;
    var i,j,a: Integer;
begin
    if depth=0 then //добавить проверку на ход
    begin
       Exit(1);//оценка
    end;

    if maxPlayer then
    begin
       maxEval:=-1000000;
       tmpPlayer:=2;
       for j:=0 to 7 do
       begin
           for i:=0 to 7 do
           begin
               //проверка игрока
               if checkPlayer(location[i,j],tmpplayer) then
               begin
                 //проверка рубки шашки
                 if checkMoveCapture(i,j,location) or checkMoveSimple(i,j,location) then
                 begin
                     ls:=bgetlocation(i,j,location);
                     if length(ls) > 0 then
                     begin
                        for a:=0 to length(ls)-1 do
                        begin
                            eval:=minimax(ls[a],depth-1,alpha,beta,false);
                            maxEval := max(maxEval,eval);
                            //alpha=max(alpha,eval);
                            //if beta<=alpha

                        end;
                     end;
                 end;

               end;

           end;
       end;
       Exit(maxEval);
    end
    else
    begin



       minEval:=1000000;
       tmpPlayer:=1;
       for j:=0 to 7 do
       begin
           for i:=0 to 7 do
           begin
               //проверка игрока
               if checkPlayer(location[i,j],tmpplayer) then
               begin
                 //проверка рубки шашки
                 if checkMoveCapture(i,j,location) or checkMoveSimple(i,j,location) then
                 begin
                     ls:=bgetlocation(i,j,location);
                     if length(ls) > 0 then
                     begin
                        for a:=0 to length(ls)-1 do
                        begin
                            eval:=minimax(ls[a],depth-1,alpha,beta,true);
                            minEval := min(minEval,eval);
                            //alpha=max(alpha,eval);
                            //if beta<=alpha

                        end;
                     end;
                 end;

               end;

           end;
       end;

       Exit(minEval);
    end;
end;

function BGetLocation(x,y:integer;var l:tlocation):bTlocations;
var ls:btlocations;
    i:integer=0;
    crd:tcrd;
begin
     crd.cellx:=x;
     crd.celly:=y;
     BGetLocationCapture(crd,l,ls,0,i);
     if(length(ls)=0) then
     begin
         getSimpleLocation(crd,ls,l);
     end;
     Exit(ls);
end;


function BGetMove(x,y:integer;var l:tlocation):btmoves;
var ms:btmoves;
    i:integer=0;
    crd:tcrd;
    move:tmove;
begin
     crd.cellx:=x;
     crd.celly:=y;
     BGetMoveCapture(crd,l,move,ms,0,i);
     if(length(ms.ms)=0) then
     begin
         getSimpleMove(crd,ms,l);
     end;
     Exit(ms);
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



       a:=BGetLocationCapture(crd,l,locations,depth+1,i);
       if(not a) then
       begin
           setlength(locations,i+1);
           locations[i]:=l;

           inc(i);
           //добавить локацию
       end;
end;





//Получить возможную локацию рубки
function BGetLocationCapture(crd:tcrd;  //координаты
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
        if(location[x-2,y-2] = 0) and (checkPlayer(location[x-1,y-1],3-tmpPlayer)) then
        begin
           BlocationCapture(crd,location,locations,depth,i,-1,-1);
           a:=true;
        end;
     end;

     //правый верхний угол
     if( (x+2)<8 ) and ( (y-2)>=0 ) then
     begin
        if(location[x+2,y-2] = 0) and (checkPlayer(location[x+1,y-1],3-tmpPlayer)) then
        begin
            BlocationCapture(crd,location,locations,depth,i,1,-1);
            a:=true;
        end;
     end;

     //левый нижний угол
     if( (x-2)>=0 ) and ( (y+2)<8 ) then
     begin
        if(location[x-2,y+2] = 0) and (checkPlayer(location[x-1,y+1],3-tmpPlayer)) then
        begin
            BlocationCapture(crd,location,locations,depth,i,-1,1);
            a:=true;
        end;
     end;

     //правый нижний угол
     if( (x+2)<8 ) and ( (y+2)<8 ) then
     begin
        if(location[x+2,y+2] = 0) and (checkPlayer(location[x+1,y+1],3-tmpPlayer)) then
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
           moves.status:=true;
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
     moves.status:=false;
     //левый верхний угол
     if( (x-2)>=0 ) and ( (y-2)>=0 ) then
     begin
        if(location[x-2,y-2] = 0) and (checkPlayer(location[x-1,y-1],3-tmpPlayer)) then
        begin
           BCapture(crd,location,move,moves,depth,i,-1,-1);
           a:=true;
        end;
     end;

     //правый верхний угол
     if( (x+2)<8 ) and ( (y-2)>=0 ) then
     begin
        if(location[x+2,y-2] = 0) and (checkPlayer(location[x+1,y-1],3-tmpPlayer)) then
        begin
            BCapture(crd,location,move,moves,depth,i,1,-1);
            a:=true;
        end;
     end;

     //левый нижний угол
     if( (x-2)>=0 ) and ( (y+2)<8 ) then
     begin
        if(location[x-2,y+2] = 0) and (checkPlayer(location[x-1,y+1],3-tmpPlayer)) then
        begin
            BCapture(crd,location,move,moves,depth,i,-1,1);
            a:=true;
        end;
     end;

     //правый нижний угол
     if( (x+2)<8 ) and ( (y+2)<8 ) then
     begin
        if(location[x+2,y+2] = 0) and (checkPlayer(location[x+1,y+1],3-tmpPlayer)) then
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
        if(location[x-2,y-2] = 0) and (checkPlayer(location[x-1,y-1],3-tmpPlayer)) then
        begin
             Exit(true);
        end;
     end;

     //правый верхний угол
     if( (x+2)<8 ) and ( (y-2)>=0 ) then
     begin
        if(location[x+2,y-2] = 0) and (checkPlayer(location[x+1,y-1],3-tmpPlayer)) then
        begin
             Exit(true);
        end;
     end;

     //левый нижний угол
     if( (x-2)>=0 ) and ( (y+2)<8 ) then
     begin
        if(location[x-2,y+2] = 0) and (checkPlayer(location[x-1,y+1],3-tmpPlayer)) then
        begin
             Exit(true);
        end;
     end;

     //правый нижний угол
     if( (x+2)<8 ) and ( (y+2)<8 ) then
     begin
        if(location[x+2,y+2] = 0) and (checkPlayer(location[x+1,y+1],3-tmpPlayer)) then
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
           tmpCrd.celly:=tmpCrd.celly+d;

           tmpl[tmpCrd.cellx,tmpCrd.celly]:=l[x,y];
           tmpl[x,y]:=0;

           setLength(ls,i+1);
           ls[i]:=l;
           inc(i);

        end;
     end;
     tmpL:=l;
     tmpcrd:=crd;
     if( (x+1)<8 ) and ( ((y+d)<8) and ((y+d)>=0) ) then
     begin
        if(l[x+1,y+d] = 0) then
        begin
           tmpCrd.cellx:=tmpCrd.cellx+1;
           tmpCrd.celly:=tmpCrd.celly+d;

           tmpl[tmpCrd.cellx,tmpCrd.celly]:=l[x,y];
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
           tmpCrd.celly:=tmpCrd.celly+d;

            tmpl[tmpCrd.cellx,tmpCrd.celly]:=l[x,y];
            tmpl[x,y]:=0;

           setLength(ms.ls,i+1);
           setLength(ms.ms,i+1);
           setLength(ms.ms[i],1);
           ms.ls[i]:=tmpl;
           ms.ms[i][0]:=tmpCrd;
           inc(i);

        end;
     end;
     tmpL:=l;
     tmpcrd:=crd;
     if( (x+1)<8 ) and ( ((y+d)<8) and ((y+d)>=0) ) then
     begin
        if(l[x+1,y+d] = 0) then
        begin
           tmpCrd.cellx:=tmpCrd.cellx+1;
           tmpCrd.celly:=tmpCrd.celly+d;

           tmpl[tmpCrd.cellx,tmpCrd.celly]:=l[x,y];
           tmpl[x,y]:=0;

           setLength(ms.ls,i+1);
           setLength(ms.ms,i+1);
           setLength(ms.ms[i],1);
           ms.ls[i]:=tmpl;
           ms.ms[i][0]:=tmpCrd;
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

function checkMoveSimple(x,y:integer;var location:tlocation):boolean;
begin
     //проверка шага
     //левый нижний угол
     if( (x-1)>=0 ) and ( (y+1)<8 ) then
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

