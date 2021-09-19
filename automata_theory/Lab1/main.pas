unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  boardunit, checkerunit, ubot,UTestBot;

type

  { TMainForm }

  TMainForm = class(TForm)

    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MainTimer: TTimer;

    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClickOnBoard(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure initCheckersAndCellsActive(var checkers:Tcheckers;
      var cellsActive:TviewActiveCells);
    procedure initChecker(var checker: TShape; t,l:integer;c:Tcolor);
    procedure initCellActive(var cellActive: TShape; t,l:integer; c:Tcolor);
    procedure MainTimerTimer(Sender: TObject);
    procedure MoveCheckerTimer();
    procedure AnimMove();
  private

  public

  end;



var
  MainForm: TMainForm;
  board:TBitmap;
  speed:integer=5;


implementation

{$R *.lfm}

{ TMainForm }

procedure ChangePlayer();
begin
   if player = 1 then
   begin
       player:=2;
   end
   else
   begin
       player:=1;
   end;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
     resetActiveChecker();
     initboard(board);
     initCheckersAndCellsActive(checkers,viewActiveCells);

end;



procedure TMainForm.FormClick(Sender: TObject);
begin
   if not MainTimer.Enabled then
   begin
     ClickOnBoard(Sender);
   end;
end;

procedure TMainForm.FormPaint(Sender: TObject);
begin

       MainForm.Canvas.Draw(0,0,board);

end;

procedure TMainForm.initCheckersAndCellsActive(var checkers:Tcheckers;
  var cellsActive:TviewActiveCells);
var i,j,c:integer;
    CheckerColor:Tcolor;
begin
   c:=0;
   CheckerColor:=clRed;

   for i:=7 downto 0 do begin
       for j:=0 to 7 do begin
            //location[j,i]:=0;
            if (((i mod 2 <> 0) and (j mod 2 = 0)) or
             ((i mod 2 = 0) and (j mod 2 <> 0))) then
              begin
                  initCellActive(cellsActive[j][i],
                                                   i*cellsize+3,
                                                   j*cellsize+3,
                                                   clAqua);
                  if ((i<3) or (i>4)) then
                  begin
                    if(c>11) then begin
                        CheckerColor:=clGreen;
                    end;
                    initChecker(checkers[c],i*cellsize+5,j*cellsize+5,CheckerColor);
                    inc(c);
                    location[j,i]:=c;
                  end
                  else
                  begin
                     location[j,i]:=0;
                  end;

              end
              else
              begin
                 location[j,i]:=-1;
              end;

       end;
   end;

end;

procedure TMainForm.ClickOnBoard(Sender:TObject);
var point:Tpoint;
    cellx,celly:integer;
    crd:tcrd;
    i:integer;
    a:boolean=false;
begin
     //если ход-движение запрещено
      if (mainTimer.Enabled) or (player=2) then
      begin
        Exit();
      end;

      //позиция
      point:=self.ScreenToClient(Mouse.CursorPos);
      cellx:=point.x div cellsize;
      celly:=point.y div cellsize;
      crd.cellx:=cellx;
      crd.celly:=celly;
      self.Caption:=inttostr(location[cellx][celly]);
      //if (cellx<8) and (celly<8) and
      //(((cellx mod 2 <>0) and (celly mod 2 = 0))
      //or((cellx mod 2 = 0) and (celly mod 2 <> 0)))
      //then
      //begin
      a := false;
      if ActiveCell then
      begin
         //ход, если нажали на активные
         i:=0;

         while((i<activeCells.len) and (not a)) do
         begin
            if(activeCells.cells[i].cellx = cellx) and
            (activeCells.cells[i].celly = celly) then
            begin
                a:=true;
                checkerMove(checkers[location[activeChecker.cellx]
                [activeChecker.celly]-1],crd,maintimer);
                ClearActiveCells(ActiveCells);
                ClearActiveCells(PathCells);
                changePlayer;
                moveBot();
            end;
            Inc(i);
         end;
         //if ((cellx <> activeChecker.cellx) and
         //(celly<>activeChecker.celly)) then
         //begin
         //    ClearActiveCalls();
         //
         //end;
         //a:=false;

      end;
      //Возможные ходы
      if (not a) and ((cellx <> activeChecker.cellx) or
         (celly<>activeChecker.celly))  then
      begin
         DeleteMoves();
         ClearActiveCells(ActiveCells);
         ClearActiveCells(PathCells);
         if checkPlayer(location[cellx][celly],player) then
         begin
              ActiveCell:=true;
              possibility(player,crd);


         end;
      end;


      //checkers[5].visible:=false;
      //board.
      //MainForm.Canvas.Draw(0,0,board);
      //mainForm.Canvas.Dr
      //checkers[0].BringToFront;

end;

procedure TMainForm.initChecker(var checker: TShape; t,l:integer; c:Tcolor);
begin
      checker:=TShape.Create(self);
      checker.Parent := self;
      checker.Shape:= stCircle;
      checker.brush.Color := c;
      checker.Width := cellsize-10;
      checker.Height := checker.Width;
      checker.Top:=t;
      checker.left:=l;
      checker.OnClick:=@ClickOnBoard;
      checker.BringToFront;
end;

procedure TMainForm.initCellActive(var cellActive: TShape; t,l:integer; c:Tcolor);
begin
      cellActive:=TShape.Create(self);
      cellActive.Parent := self;
      cellActive.Shape:= stRectangle;
      cellActive.brush.style := bsClear;
      cellActive.Width := cellsize-6;
      cellActive.Height := cellActive.Width;
      cellActive.Top:=t;
      cellActive.left:=l;
      cellActive.OnClick:=@ClickOnBoard;
      cellActive.BringToFront;
      cellActive.pen.Color:=c;
      cellActive.pen.style:=psSolid;
      cellActive.pen.width:=2;
      cellActive.visible:=false;
end;

procedure TMainForm.MainTimerTimer(Sender: TObject);
var
    i:integer;
begin
    MoveCheckerTimer();
    AnimMove;

end;

//ход шашки
procedure TMainForm.MoveCheckerTimer;
var //i,j:integer;
  a,b:integer;
  //tmpcrd:tcrd;
  //move:tmove;
begin
    if mt.countPath=0 then
    begin
        exchange(mt.Startpath,mt.EndPath);
        //t.Enabled:=true;
        mt.anim:=true;
        //AnimMove();
        //sh.top:=crd.celly*cellsize+5;
        //sh.left:=crd.cellx*cellsize+5;
        //animMove(sh,crd);
    end
    else
    begin
      //tmpcrd:=activeChecker;
      //move:=getMove(crd);
      //if i:=1 to length(move)-1 do
      //begin

       if (mt.i<(mt.countPath)) and (not mt.anim) then
       begin
         a:=(mt.move[mt.i].cellx-mt.Startpath.cellx) div 2;
         b:=(mt.move[mt.i].celly-mt.Startpath.celly) div 2;
         //caption:=inttostr(location[mt.move[mt.i].cellx-a][mt.move[mt.i].celly-b]);
         checkers[location[mt.move[mt.i].cellx-a][mt.move[mt.i].celly-b]-1].visible:=false;
         location[mt.move[mt.i].cellx-a][mt.move[mt.i].celly-b]:=0;
         exchange(mt.Startpath,mt.move[mt.i]);
         mt.EndPath:=mt.move[mt.i];
         mt.anim:=true;
         //AnimMove();
         //mt.Startpath:=mt.move[mt.i];
         //inc(mt.i);
         ////sh.top:=move[i].celly*cellsize+5;
         ////sh.left:=move[i].cellx*cellsize+5;
         ////animMove(sh,move[i]);
         //startpath:=tmpcrd;
         //endPath:=move[i];
         //ash:=sh;
         //t.Enabled:=true;
         ////timerWork:=true;
         //
         ////
         //exchange(move[i],tmpcrd);
         //tmpcrd:=move[i];

      //end;
       end;

    end;

end;

procedure TMainForm.AnimMove();
var pl,pt:integer;
  condition:boolean;
begin
   if mt.Anim then
   begin
     // timerWork:=true;
      if(abs(mt.startPath.cellx-mt.endPath.cellx) = 1) then
      begin
          pl:= mt.startPath.cellx-mt.endPath.cellx;
          pt:= mt.startPath.celly-mt.endPath.celly;
      end
      else
      begin
          pl:= (mt.startPath.cellx-mt.endPath.cellx)div 2;
          pt:= (mt.startPath.celly-mt.endPath.celly)div 2;
      end;

      if pl > 0 then
      begin
         condition:=mt.sh.left > ((mt.endPath.cellx*cellsize+5)+speed)
      end
      else
      begin
         condition:=mt.sh.left < ((mt.endPath.cellx*cellsize+5)-speed)
      end;

      if (condition)
      then
      begin
         mt.sh.left:=mt.sh.left-pl*speed;
         mt.sh.top:=mt.sh.top-pt*speed;
        // sleep(2);

      end
      else
      begin
         mt.sh.left:=mt.endPath.cellx*cellsize+5;
         mt.sh.top:=mt.endPath.celly*cellsize+5;
         //MainTimer.Enabled:=false;
         mt.anim:=false;



         if (mt.countPath=0) or (mt.i>=mt.countPath-1) then
         begin
                MainTimer.Enabled:=false;
         end
         else
         begin
            mt.Startpath:=mt.move[mt.i];
            inc(mt.i);
         end;
      end;
      //ash.left:=endPath.cellx*cellsize+5;
      //ash.top:=endPath.celly*cellsize+5;

   end;
end;

end.

