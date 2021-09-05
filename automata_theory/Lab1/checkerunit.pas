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

function checkPlayer(current:integer;Player:integer):boolean;
procedure possibility(player:integer;crd:tcrd);
procedure AddActiveCells(cellx,celly:integer);
Procedure ClearActiveCalls();
procedure resetActiveChecker();
procedure checkerMove(sh:TShape;crd:Tcrd);


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
end;

//ход шашки
procedure checkerMove(sh:TShape;crd:Tcrd);
var i:integer;
begin
   sh.top:=crd.celly*cellsize+5;
   sh.left:=crd.cellx*cellsize+5;
   i:=location[crd.cellx][crd.celly];
   location[crd.cellx][crd.celly]:=location[activeChecker.cellx][activeChecker.celly];
   location[activeChecker.cellx][activeChecker.celly]:=i;

end;


//Показать возможные ходы
procedure possibility(player:integer;crd:TCrd);
var direction:integer=1;
begin
  if player=1 then
  begin
     direction:=-1;
  end;
  //activeCells.len:=0;
  //setlength(activeCells.cells,activeCells.len);

  activeChecker:=crd;
  viewActiveCells[Crd.cellx][Crd.celly].visible:=true;

  if location[Crd.cellx+1][Crd.celly+direction]=0 then
  begin
       AddActiveCells(Crd.cellx+1,Crd.celly+direction);


       viewActiveCells[Crd.cellx+1][Crd.celly+direction].visible:=true;
  end;
  if location[Crd.cellx-1][Crd.celly+direction]=0 then
  begin
       AddActiveCells(Crd.cellx-1,Crd.celly+direction);

       viewActiveCells[Crd.cellx-1][Crd.celly+direction].visible:=true;

  end;
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

