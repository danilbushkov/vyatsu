unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  boardunit, checkerunit;

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
      var cellsActive:TcellsActive);
    procedure initChecker(var checker: TShape; t,l:integer;c:Tcolor);
    procedure initCellActive(var cellActive: TShape; t,l:integer; c:Tcolor);

  private

  public

  end;



var
  MainForm: TMainForm;
  board:TBitmap;


implementation

{$R *.lfm}

{ TMainForm }



procedure TMainForm.FormCreate(Sender: TObject);
begin

     initboard(board);
     initCheckersAndCellsActive(checkers,cellsActive);

end;



procedure TMainForm.FormClick(Sender: TObject);
begin
     ClickOnBoard(Sender);
end;

procedure TMainForm.FormPaint(Sender: TObject);
begin

       MainForm.Canvas.Draw(0,0,board);

end;

procedure TMainForm.initCheckersAndCellsActive(var checkers:Tcheckers;
  var cellsActive:TcellsActive);
var i,j,c:integer;
    CheckerColor:Tcolor;
begin
   c:=0;
   CheckerColor:=clRed;

   for i:=0 to 7 do begin
       for j:=0 to 7 do begin
            if (((i mod 2 <> 0) and (j mod 2 = 0)) or
             ((i mod 2 = 0) and (j mod 2 <> 0))) then
              begin
                  initCellActive(cellsActive[i][j],
                                                   j*cellsize+3,
                                                   i*cellsize+3,
                                                   clAqua);
                  if ((i<3) or (i>4)) then
                  begin
                    if(c>11) then begin
                        CheckerColor:=clGreen;
                    end;
                    initChecker(checkers[c],i*cellsize+5,j*cellsize+5,CheckerColor);
                    inc(c);
                  end;
              end;

       end;
   end;

end;

procedure TMainForm.ClickOnBoard(Sender:TObject);
var point:Tpoint;
    cellx,celly:integer;
begin
      point:=self.ScreenToClient(Mouse.CursorPos);
      cellx:=point.x div cellsize;
      celly:=point.y div cellsize;
      self.Caption:=inttostr(celly);
      if (cellx<8) and (celly<8) and
      (((cellx mod 2 <>0) and (celly mod 2 = 0))
      or((cellx mod 2 = 0) and (celly mod 2 <> 0)))
      then
      begin
           cellsActive[cellx][celly].visible:=true;
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


end.

