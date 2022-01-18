unit checkerunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Forms,Graphics,ExtCtrls,boardUnit;

type
Tcheckers= array[0..23] of TShape;
TviewActiveCells = array[0..7,0..7] of  TShape;
TLocation = array[0..7,0..7] of integer;

TCrd=record
   cellx:integer;
   celly:integer;
end;
TActiveCells=record
    cells:array of TCrd;
    len:integer;
end;
Tmove=array of TCrd;
Tmoves=array of Tmove;

TMoveTimer=record
   Startpath:tcrd;
   EndPath:Tcrd;
   Sh:Tshape;
   move:Tmove;
   i:integer;
   countPath:integer;//количество ходов
   anim:boolean;
end;

var
  checkers: Tcheckers;
  viewActiveCells: TviewActiveCells;
  location:Tlocation;

  activeCell:boolean=False;
  activeChecker:TCrd;
  activeCells:TActiveCells;
  pathCells:TActiveCells;
  moves:Tmoves;
  player:integer=1;

  mt:TMoveTimer;//информация для перехода
  prompt:boolean=false;
  promptColor:Tcolor=clAqua ;//clAqua
  promptColor2:Tcolor=clTeal;//clTeal
  capturePlayer:boolean=false;

function checkPlayer(current:integer;Player:integer):boolean;
procedure possibility(player:integer;crd:tcrd);
procedure AddActiveCells(var activeCells:TactiveCells;cellx,celly:integer;c:Tcolor;A:boolean);
Procedure ClearActiveCells(var ActiveCells:TActiveCells);
procedure resetActiveChecker();
procedure checkerMove(var sh:TShape;crd:Tcrd;var t:ttimer);
function checkMoveCapturePlayer(x,y:integer;var location:tlocation):boolean;
function checkCapturePlayer():boolean;
function compareCoordinates(crd,crd2:tcrd;cx,cy:integer):boolean;
procedure DeleteMoves();
function GetMove(crd:tcrd):tmove;
procedure exchange(var crd,crd2:tcrd);

implementation



procedure resetActiveChecker();
begin
   activeChecker.cellx:=-1;
   activeChecker.celly:=-1;
end;

procedure exchange(var crd,crd2:tcrd);
var j:integer;
begin
   j:=location[crd.cellx][crd.celly];
   location[crd.cellx][crd.celly]:=location[crd2.cellx][crd2.celly];
   location[crd2.cellx][crd2.celly]:=j;
end;


procedure AddActiveCells(var activeCells:TactiveCells;cellx,celly:integer;c:Tcolor;a:boolean);
begin

    viewActiveCells[cellx][celly].pen.Color:=c;

    activeCells.len:=activeCells.len+1;
    setlength(activeCells.cells,activeCells.len);
    activeCells.cells[activeCells.len-1].cellx:=cellx;
    activeCells.cells[activeCells.len-1].celly:=celly;
    //if a then begin
       viewActiveCells[cellx][celly].visible:=true;
    //end;
end;



//анимация перехода
procedure animMove(var sh:Tshape;crd:tcrd;var t:ttimer);
var pl,pt:integer;
  i:integer;
begin

end;

//ход шашки
procedure checkerMove(var sh:TShape;crd:Tcrd; var t:ttimer);
begin
    mt.Startpath:=activeChecker;
    mt.EndPath:=crd;
    mt.Sh:=sh;
    mt.move:=getMove(crd);
    mt.i:=1;
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


function checkCapture(location:tlocation;crd:tcrd;dx,dy:integer):boolean;
var a:boolean;
begin
   if (crd.cellx+2*dx<8) and (crd.cellx+2*dx>=0)
   and (crd.cellx+dx<8) and (crd.cellx+dx>=0)
   and (crd.celly+2*dy<8) and (crd.celly+2*dy>=0)
   and (crd.celly+dy<8) and (crd.celly+dy>=0)
   then
   begin
    a:=(location[crd.cellx+dx][crd.celly+dy]>=1) and
    (not checkPlayer(location[crd.cellx+dx][crd.celly+dy],player)) and
    (location[crd.cellx+2*dx][crd.celly+2*dy]=0);// and
    //(crd.cellx+2*dx<8) and (crd.celly+2*dy>=0);
     Exit(a);
   end;
   Exit(False);
end;

function compareCoordinates(crd,crd2:tcrd;cx,cy:integer):boolean;
begin
    Exit(
    (crd.cellx=crd2.cellx+2*cx) and (crd.celly=crd2.celly+2*cy)
    );
end;

function Capture(l:tlocation;crd:tcrd;dx,dy:integer):tlocation;
begin
    l[crd.cellx+2*dx,crd.celly+2*dy]:=l[crd.cellx,crd.celly];
    l[crd.cellx,crd.celly]:=0;
    l[crd.cellx+dx,crd.celly+dy]:=0;
    Exit(l);
end;

//поиск возможных захватов
function possibleCapture(crd:tcrd;l:tlocation;move:tmove;depth:integer;var i:integer):boolean;
var a,b:boolean;
    crd2:tcrd;

begin
    a:=false;
    if (checkCapture(l,crd,-1,1)) //not (compareCoordinates(crd,crd2,1,-1))
    then
    begin

        crd2.cellx:=crd.cellx-2;
        crd2.celly:=crd.celly+2;

        setLength(move,depth+2);
        move[depth+1]:=crd2;
        b:=possibleCapture(crd2,capture(l,crd,-1,1),move,depth+1,i);

        AddActiveCells(pathCells,Crd.cellx-1,Crd.celly+1,promptColor2,true);
        if not b then
        begin
           move[0]:=crd2;
           inc(i);
           setLength(moves,i);
           moves[i-1]:=move;
           AddActiveCells(ActiveCells,Crd.cellx-2,Crd.celly+2,promptColor,prompt);
        end else
        begin
            AddActiveCells(pathCells,Crd.cellx-2,Crd.celly+2,promptColor2,prompt);

        end;

        a:=true;
    end;
    if (checkCapture(l,crd,+1,1))  //not (compareCoordinates(crd,crd2,-1,-1))
    then
    begin

        crd2.cellx:=crd.cellx+2;
        crd2.celly:=crd.celly+2;

        setLength(move,depth+2);
        move[depth+1]:=crd2;

        b:=possibleCapture(crd2,capture(l,crd,1,1),move,depth+1,i);

        AddActiveCells(pathCells,Crd.cellx+1,Crd.celly+1,promptColor2,true);
        if not b then
        begin
            move[0]:=crd2;
            inc(i);
            setLength(moves,i);
            moves[i-1]:=move;
            AddActiveCells(ActiveCells,Crd.cellx+2,Crd.celly+2,promptColor,prompt);
        end else
        begin
            AddActiveCells(pathCells,Crd.cellx+2,Crd.celly+2,promptColor2,true);

        end;
        a:=true;
    end;
    if (checkCapture(l,crd,-1,-1))   //not (compareCoordinates(crd,crd2,1,1))
    then
    begin

        crd2.cellx:=crd.cellx-2;
        crd2.celly:=crd.celly-2;

        setLength(move,depth+2);
        move[depth+1]:=crd2;


        b:=possibleCapture(crd2,capture(l,crd,-1,-1),move,depth+1,i);

        AddActiveCells(pathCells,Crd.cellx-1,Crd.celly-1,promptColor2,true);
        if not b then
        begin
            move[0]:=crd2;
            inc(i);
            setLength(moves,i);
            moves[i-1]:=move;
            AddActiveCells(ActiveCells,Crd.cellx-2,Crd.celly-2,promptColor,prompt);
        end else
        begin
            AddActiveCells(pathCells,Crd.cellx-2,Crd.celly-2,promptColor2,true);

        end;
        a:=true;
    end;
    if (checkCapture(l,crd,+1,-1))   //not (compareCoordinates(crd,crd2,-1,1))
    then
    begin
        crd2.cellx:=crd.cellx+2;
        crd2.celly:=crd.celly-2;

        setLength(move,depth+2);
        move[depth+1]:=crd2;

        b:=possibleCapture(crd2,capture(l,crd,1,-1),move,depth+1,i);

        AddActiveCells(pathCells,Crd.cellx+1,Crd.celly-1,promptColor2,true);
        if not b then
        begin
            move[0]:=crd2;
            inc(i);
            setLength(moves,i);
            moves[i-1]:=move;
           AddActiveCells(ActiveCells,Crd.cellx+2,Crd.celly-2,promptColor,prompt);
        end else
        begin
            AddActiveCells(pathCells,Crd.cellx+2,Crd.celly-2,promptColor2,true);
        end;
        a:=true;
    end;
    Exit(a);
end;
//Показать возможные ходы
procedure possibility(player:integer;crd:TCrd);
var direction:integer=1;
    i:integer;
  tmpcrd:tcrd;
  a:boolean;
  move:tmove;
  //взятие
begin
  if player=1 then
  begin
     direction:=-1;
  end;


  activeChecker:=crd;
  AddActiveCells(pathCells,Crd.cellx,Crd.celly,clTeal,true);


  a:=true;


    tmpcrd.cellx:=-1;
    tmpcrd.celly:=-1;
    i:=0;
    a:=possibleCapture(crd,location,move,0,i);


    if not a  then
    begin

      if (location[Crd.cellx+1][Crd.celly+direction]=0) and
      (Crd.cellx+1<8)
      then
      begin
        if(not capturePlayer) then
        begin
           AddActiveCells(ActiveCells,Crd.cellx+1,Crd.celly+direction,promptColor,prompt);
        end
        else
        begin
            AddActiveCells(pathCells,Crd.cellx+1,Crd.celly+direction,clblack,false);
        end;



      end;
      if (location[Crd.cellx-1][Crd.celly+direction]=0)  and
      (Crd.cellx-1>=0)
      then
      begin
        if(not capturePlayer) then
        begin
           AddActiveCells(ActiveCells,Crd.cellx-1,Crd.celly+direction,promptColor,prompt);
        end
        else
        begin
           AddActiveCells(pathCells,Crd.cellx-1,Crd.celly+direction,clblack,false);
        end;

      end;

    end;





end;



//Стереть возможные ходы
Procedure ClearActiveCells(var ActiveCells:TActiveCells);
var i:integer;
begin
  for i:=0 to ActiveCells.len-1 do
  begin
       viewActiveCells[ActiveCells.Cells[i].cellx][ActiveCells.Cells[i].celly].visible:=false;

  end;
  if activeCell then begin
      viewActiveCells[activeChecker.cellx][activeChecker.celly].visible:=false;
  end;

  ActiveCell:=false;
  activeCells.len:=0;
  setlength(activeCells.cells,activeCells.len);
  resetActiveChecker();
end;

//проверить игрока ли шашка
function checkPlayer(current:integer;Player:integer):boolean;
begin
  if(current>0)then
  begin
    if(current<=12) and (Player=1)then
    begin
      Exit(True);
    end;
    if ((12<current) and (current<=24)) and (Player=2) then
    begin
      Exit(True);
    end;
  end;
  Exit(False);
end;

//удалить возможные пути
procedure DeleteMoves();
var i:integer;
begin
    for i:=0 to length(moves)-1 do
    begin
        setlength(moves[i],0);
    end;
    setlength(moves,0);
end;

//Получить нужный ход, должны передать конечную точку
function GetMove(crd:tcrd):tmove;
var move:tmove;
var
    i:integer;
begin
   i:=0;
   while(i<length(moves))do
   begin
       if (moves[i][0].cellx=crd.cellx) and (moves[i][0].celly=crd.celly) then
       begin
           move:=moves[i];
           DeleteMoves();
           Exit(move);
       end;
       Inc(i);
   end;
end;

function checkCapturePlayer():boolean;
var i,j:integer;
begin
    for i:=0 to 7 do
    begin
        for j:=0 to 7 do
        begin
            if(checkPlayer(location[j,i],1)) then
            begin
                 if(checkMoveCapturePlayer(j,i,location)) then
                 begin
                     Exit(true);
                 end;

            end;
        end;
    end;
    exit(false);
end;




function checkMoveCapturePlayer(x,y:integer;var location:tlocation):boolean;
begin
     //проверить рубку

     //левый верхний угол
     if( (x-2)>=0 ) and ( (y-2)>=0 ) then
     begin
        if(location[x-2,y-2] = 0) and (checkPlayer(location[x-1,y-1],2)) then
        begin
             Exit(true);
        end;
     end;

     //правый верхний угол
     if( (x+2)<8 ) and ( (y-2)>=0 ) then
     begin
        if(location[x+2,y-2] = 0) and (checkPlayer(location[x+1,y-1],2)) then
        begin
             Exit(true);
        end;
     end;

     //левый нижний угол
     if( (x-2)>=0 ) and ( (y+2)<8 ) then
     begin
        if(location[x-2,y+2] = 0) and (checkPlayer(location[x-1,y+1],2)) then
        begin
             Exit(true);
        end;
     end;

     //правый нижний угол
     if( (x+2)<8 ) and ( (y+2)<8 ) then
     begin
        if(location[x+2,y+2] = 0) and (checkPlayer(location[x+1,y+1],2)) then
        begin
             Exit(true);
        end;
     end;


     Exit(false);

end;





end.

