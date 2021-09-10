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

var
  checkers: Tcheckers;
  viewActiveCells: TviewActiveCells;
  location:Tlocation;

  activeCell:boolean=False;
  activeChecker:TCrd;
  activeCells:TActiveCells;
  player:integer=1;

function checkPlayer(current:integer;Player:integer):boolean;
procedure possibility(player:integer;crd:tcrd);
procedure AddActiveCells(cellx,celly:integer);
Procedure ClearActiveCalls();
procedure resetActiveChecker();
procedure checkerMove(sh:TShape;crd:Tcrd);
function checkCapture(crd:tcrd;dx,dy:integer):boolean;
function compareCoordinates(crd,crd2:tcrd;cx,cy:integer):boolean;

implementation



procedure resetActiveChecker();
begin
   activeChecker.cellx:=-1;
   activeChecker.celly:=-1;
end;


procedure AddActiveCells(cellx,celly:integer);
begin
    activeCells.len:=activeCells.len+1;
    setlength(activeCells.cells,activeCells.len);
    activeCells.cells[activeCells.len-1].cellx:=cellx;
    activeCells.cells[activeCells.len-1].celly:=celly;
    viewActiveCells[cellx][celly].visible:=true;

end;




//ход шашки
procedure checkerMove(sh:TShape;crd:Tcrd);
var i:integer;
  a,b:integer;
begin
   a:=(crd.cellx-activeChecker.cellx) div 2;
   b:=(crd.celly-activeChecker.celly) div 2;
   sh.top:=crd.celly*cellsize+5;
   sh.left:=crd.cellx*cellsize+5;
   if abs(crd.cellx - activeChecker.cellx) > 1 then
   begin
     checkers[location[crd.cellx-a][crd.celly-b]-1].visible:=false;
     location[crd.cellx-a][crd.celly-b]:=0;
   end;
   i:=location[crd.cellx][crd.celly];
   location[crd.cellx][crd.celly]:=location[activeChecker.cellx][activeChecker.celly];
   location[activeChecker.cellx][activeChecker.celly]:=i;

end;


function checkCapture(crd:tcrd;dx,dy:integer):boolean;
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


//показать возможный захват
function possibleCapture(crd,Crd2:tcrd):boolean;
var a:boolean;

begin
    a:=false;
    if (checkCapture(crd,-1,1)) and not (compareCoordinates(crd,crd2,1,-1))
    then
    begin
        crd2.cellx:=crd.cellx-2;
        crd2.celly:=crd.celly+2;
        possibleCapture(crd2,crd);

        AddActiveCells(Crd.cellx-2,Crd.celly+2);
        a:=true;
    end;
    if (checkCapture(crd,+1,1)) and not (compareCoordinates(crd,crd2,-1,-1))
    then
    begin

        crd2.cellx:=crd.cellx+2;
        crd2.celly:=crd.celly+2;
        possibleCapture(crd2,crd);
         AddActiveCells(Crd.cellx+2,Crd.celly+2);
         a:=true;
    end;
    if (checkCapture(crd,-1,-1)) and  not (compareCoordinates(crd,crd2,1,1))
    then
    begin

        crd2.cellx:=crd.cellx-2;
        crd2.celly:=crd.celly-2;
        possibleCapture(crd2,crd);
         AddActiveCells(Crd.cellx-2,Crd.celly-2);
         a:=true;
    end;
    if (checkCapture(crd,+1,-1)) and  not (compareCoordinates(crd,crd2,-1,1))
    then
    begin
        crd2.cellx:=crd.cellx+2;
        crd2.celly:=crd.celly-2;
        possibleCapture(crd2,crd);
         AddActiveCells(Crd.cellx+2,Crd.celly-2);
         a:=true;
    end;
    Exit(a);
end;
//Показать возможные ходы
procedure possibility(player:integer;crd:TCrd);
var direction:integer=1;
  tmpcrd:tcrd;
  a:boolean;
  //взятие
begin
  if player=1 then
  begin
     direction:=-1;
  end;
  //activeCells.len:=0;
  //setlength(activeCells.cells,activeCells.len);

  activeChecker:=crd;
  viewActiveCells[Crd.cellx][Crd.celly].visible:=true;

  a:=true;

  //проверка
  //while a do
  //begin
  //  if checkCapture(crd.cellx,crd.celly,direction,1) then
  //  begin
  //
  //  end else
  //  begin
  //      a:=false;
  //  end;
  //end;
  //
    tmpcrd.cellx:=-1;
    tmpcrd.celly:=-1;
    a:=possibleCapture(crd,tmpcrd);


    if {not} true then
    begin
      if (location[Crd.cellx+1][Crd.celly+direction]=0) and
      (Crd.cellx+1<8)
      then
      begin
           AddActiveCells(Crd.cellx+1,Crd.celly+direction);


           //viewActiveCells[Crd.cellx+1][Crd.celly+direction].visible:=true;
      end;
      if (location[Crd.cellx-1][Crd.celly+direction]=0)  and
      (Crd.cellx-1>=0)
      then
      begin
           AddActiveCells(Crd.cellx-1,Crd.celly+direction);

           //viewActiveCells[Crd.cellx-1][Crd.celly+direction].visible:=true;

      end;

    end;

    //if checkCapture(crd,-1,direction)
    //then
    //begin
    //    AddActiveCells(Crd.cellx-2,Crd.celly+2*direction);
    //
    //end;
    //if checkCapture(crd,+1,direction)
    //then
    //begin
    //     AddActiveCells(Crd.cellx+2,Crd.celly+2*direction);
    //end;
    //if checkCapture(crd,-1,-direction)
    //then
    //begin
    //     AddActiveCells(Crd.cellx-2,Crd.celly-2*direction);
    //end;
    //if checkCapture(crd,+1,-direction)
    //then
    //begin
    //     AddActiveCells(Crd.cellx+2,Crd.celly-2*direction);
    //end;


 // end;



end;



//Стереть возможные ходы
Procedure ClearActiveCalls();
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

end.

