unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, ComCtrls, boardunit, checkerunit, ubot, UTestBot, FormColor;

type

  TSetting=record
    player:integer;
    colors: array [0..1] of Tcolor;
  end;

  { TMainForm }

  TMainForm = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    SettingsMenu: TMenuItem;
    About: TMenuItem;
    Open: TMenuItem;
    Save: TMenuItem;
    ExitProgram: TMenuItem;
    ColorCheckers: TMenuItem;
    AboutProgram: TMenuItem;
    AboutAuthor: TMenuItem;
    SpeedEdit: TEdit;
    ExitButton: TButton;
    PauseButton: TButton;
    StartButton: TButton;

    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    MainTimer: TTimer;
    SpeedTrack: TTrackBar;

    procedure AboutAuthorClick(Sender: TObject);
    procedure AboutProgramClick(Sender: TObject);
    procedure ColorCheckersClick(Sender: TObject);
    procedure ExitProgramClick(Sender: TObject);
    procedure OpenClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure SettingsMenuClick(Sender: TObject);
    procedure FileMenuClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure PauseButtonClick(Sender: TObject);
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
    procedure SpeedEditChange(Sender: TObject);

    procedure SpeedEditKeyPress(Sender: TObject; var Key: char);
    procedure SpeedTrackChange(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
  private

  public

  end;



var
  MainForm: TMainForm;
  board:TBitmap;
  speed:integer=5;
  stop:boolean=true;
  pause:boolean=false;
  s:Tsetting;
  f:file of Tsetting;

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
     sColor[0]:=cllime;
     sColor[1]:=clred;
     resetActiveChecker();
     initboard(board);
     initCheckersAndCellsActive(checkers,viewActiveCells);
     mainTimer.Interval:=101-SpeedTrack.Position;
end;



procedure TMainForm.FormClick(Sender: TObject);
begin
   if not MainTimer.Enabled then
   begin
     ClickOnBoard(Sender);
   end;
end;

procedure TMainForm.PauseButtonClick(Sender: TObject);
begin
   if pause then
   begin
       pause:=false;
       pauseButton.Caption:='Пауза';
       mainTimer.Interval:=101-SpeedTrack.Position;

   end
   else
   begin
       pause:=true;
       pauseButton.Caption:='Продолжить';
       mainTimer.Interval:=0;

   end;
end;

procedure TMainForm.ExitButtonClick(Sender: TObject);
var answer:longint;
begin
   answer:=QuestionDlg('Выход', 'Вы действительно хотите выйти?',mtCustom,
                                [mrYes,'Да',mrNo,'Нет'],0);
   if  answer = mrYes then
   begin
         Close();
   end;
end;

procedure TMainForm.FileMenuClick(Sender: TObject);
begin

end;

procedure TMainForm.SettingsMenuClick(Sender: TObject);
begin

end;

procedure TMainForm.ExitProgramClick(Sender: TObject);
var answer:longint;
begin
   answer:=QuestionDlg('Выход', 'Вы действительно хотите выйти?',mtCustom,
                                [mrYes,'Да',mrNo,'Нет'],0);
   if  answer = mrYes then
   begin
         Close();
   end;
end;

procedure TMainForm.OpenClick(Sender: TObject);
begin
    if OpenDialog.Execute then begin
        s.player:=pl;
        s.colors:=sColor;
        assignfile(f, SaveDialog.FileName);
        reset(f);
        read(f,s);
        closefile(f);

        pl:=s.player;
        player:=pl;
        sColor:=s.Colors;
        Fcolor.SetColor(sColor[0],sColor[1]);

    end;
end;

procedure TMainForm.SaveClick(Sender: TObject);
begin

    if SaveDialog.Execute then begin
        s.player:=pl;
        s.colors:=sColor;
        assignfile(f, SaveDialog.FileName);
        rewrite(f);
        write(f,s);
        closefile(f);
    end;
end;

procedure TMainForm.ColorCheckersClick(Sender: TObject);
begin
  FColor.ShowModal;
end;

procedure TMainForm.AboutProgramClick(Sender: TObject);
begin
  QuestionDlg('Об игре', 'Игра "Шашки". Игрок играет против бота. Для начала игры нажмите кнопку "Начать".'
  +'Чтобы выбрать шашку для хода - нажмите на неё. Игрок может играть лишь нижними шашками.'
                               ,mtCustom,
                                [mrYes,'Ок'],0);
end;

procedure TMainForm.AboutAuthorClick(Sender: TObject);
begin

   QuestionDlg('Об авторе', 'Разработчик: Бушков Данил, '+
                             'Студент группы ИВТб-2302 ВятГУ '+ #10 +
                             'Github: https://github.com/danilbushkov'
                            ,mtCustom,
                                [mrYes,'Ок'],0);
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
   CheckerColor:=sColor[0];

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
                        CheckerColor:=sColor[1];
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
      if (mainTimer.Enabled) or (player=2) or (stop) or pause
          then
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
                //moveBot(maintimer);
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
      if (stop) then begin
           checker:=TShape.Create(self);
           checker.Parent := self;
      end;
      checker.Shape:= stCircle;
      checker.brush.Color := c;
      checker.Width := cellsize-10;
      checker.Height := checker.Width;
      checker.Top:=t;
      checker.left:=l;
      checker.OnClick:=@ClickOnBoard;
      checker.BringToFront;
      checker.visible:=true;
end;

procedure TMainForm.initCellActive(var cellActive: TShape; t,l:integer; c:Tcolor);
begin
      if( stop) then begin
                cellActive:=TShape.Create(self);
                cellActive.Parent := self;

      end;
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

        mt.anim:=true;

    end
    else
    begin


       if (mt.i<(mt.countPath)) and (not mt.anim) then
       begin
         a:=(mt.move[mt.i].cellx-mt.Startpath.cellx) div 2;
         b:=(mt.move[mt.i].celly-mt.Startpath.celly) div 2;

         checkers[location[mt.move[mt.i].cellx-a][mt.move[mt.i].celly-b]-1].visible:=false;
         location[mt.move[mt.i].cellx-a][mt.move[mt.i].celly-b]:=0;
         exchange(mt.Startpath,mt.move[mt.i]);
         mt.EndPath:=mt.move[mt.i];
         mt.anim:=true;

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
                if player = 2 then
                begin

                     moveBot(maintimer);
                     changePlayer;
                end;
         end
         else
         begin
            mt.Startpath:=mt.move[mt.i];
            inc(mt.i);
         end;
      end;


   end;
end;

procedure TMainForm.SpeedEditChange(Sender: TObject);
var e,a:integer;
begin
   val(speedEdit.text,a,e);
   if( a>100 ) then
   begin
        ShowMessage('Числа от 0 до 100!');
   end;
   if(length(speedEdit.text)>0)then
   begin
        SpeedTrack.Position:=strtoint(speedEdit.text);
   end
   else
   begin
         SpeedTrack.Position:=0;
   end;
end;



procedure TMainForm.SpeedEditKeyPress(Sender: TObject; var Key: char);
begin
   if not (key in ['0'..'9']) and (key<>#8) then
   begin
      ShowMessage('Вводить можно только цифры!');
   end;
   if (length(SpeedEdit.text)=0) then
   begin
        SpeedEdit.text:='0';
   end;

   if (key in ['0'..'9']) and (length(SpeedEdit.text)<3) then
   begin

       key:=key;
       if (SpeedEdit.text='0') then
       begin

           if key='0' then
           begin
                key:=#0;
           end;

       end;

   end
   else if key=#8 then
   begin
       key:=key;
       if (length(SpeedEdit.text)=1) then
       begin
            SpeedEdit.text:='0';
            key:=#0;
       end;
   end
   else begin
      if (key in ['0'..'9']) and (length(SpeedEdit.text)=3) then
      begin
           ShowMessage('Числа от 0 до 100!');
      end;
      key:=#0

   end;



end;

procedure TMainForm.SpeedTrackChange(Sender: TObject);
begin
   if SpeedTrack.position=0 then
   begin
        MainTimer.interval:=0;

   end
   else
   begin

        MainTimer.interval:=101-SpeedTrack.position;

   end;
   SpeedEdit.Caption:=IntToStr(SpeedTrack.position);
end;

procedure TMainForm.StartButtonClick(Sender: TObject);
begin

    if(stop)then
    begin
        player:=pl;
         StartButton.Caption:='Cтоп';
         stop:=false;
         ColorCheckers.Enabled:=false;
         if(player=2)then
         begin

           moveBot(maintimer);
           changePlayer;
         end;
    end else
    begin
        MainTimer.Enabled:=false;
        initCheckersAndCellsActive(checkers,viewActiveCells);
        stop:=true;
        StartButton.Caption:='Старт';
        ColorCheckers.Enabled:=true;

    end;
end;

end.

