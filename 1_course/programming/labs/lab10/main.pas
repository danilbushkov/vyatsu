unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  utruck, ufruit, uFruitItem, usetting,ubonus;

type

  { TFormGame }

  TFormGame = class(TForm)
    Fon: TImage;
    GameOverL: TLabel;
    Label1: TLabel;
    pointsLabel: TLabel;
    MainTimer: TTimer;

    procedure CreateFormGame(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MainTimerTimer(Sender: TObject);
    procedure truckImageClick(Sender: TObject);
    procedure gameover();
    procedure Delete();
    procedure CCreate();

  private

  public
    time:longint;
  end;

var
  FormGame: TFormGame;


implementation

{$R *.lfm}

{ TFormGame }

procedure TFormGame.truckImageClick(Sender: TObject);
begin

end;

procedure TFormGame.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if MainTimer.Enabled then
       truck.moving(key);
     if not MainTimer.Enabled then
     begin
        if ord(key) = 13 then
        begin
           Delete();
           cCreate();
        end;
     end;
end;








procedure TFormGame.MainTimerTimer(Sender: TObject);//таймер
begin
       if time = 300 then
          Fruits.RandomFruits();

       Fruits.GoDown();
    //fruit.GoDown();
   // truck.moving(truckImage,key);
       if time > 300 then
       begin
          time:=0;
       end;
       time:=time+MainTimer.Interval
end;


procedure TFormGame.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
     Delete();

   //pointsLabel.Free;
   //fon.free;
end;

procedure TFormGame.Delete();
begin
    fruits.deletebonuses();
   fruits.deleteFruits();
   //truckImage.free;
   truck.deleteLives();
   truck.truckimage.free;
   truck.Free;
   fruits.free;
   setting.Free;
end;




procedure TFormGame.CreateFormGame(Sender: TObject);
begin
      cCreate();
end;

procedure TFormGame.CCreate;
begin
    setting:=Tsetting.Create();
  truck:=TTruck.Create;
  truck.ScreenResolution:=width-truck.truckImage.width;
  Fruits:=TFruits.Create();
   MainTimer.enabled:=true;
   GameOverL.visible:=false;
   Label1.visible:=false;

end;

procedure TFormGame.GameOver();
begin
  MainTimer.enabled:=false;
  GameOverL.visible:=true;
  Label1.visible:=true;
end;

end.

