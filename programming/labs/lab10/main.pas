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
    pointsLabel: TLabel;
    MainTimer: TTimer;

    procedure CreateFormGame(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pointsLabelClick(Sender: TObject);
    procedure MainTimerTimer(Sender: TObject);
    procedure truckImageClick(Sender: TObject);
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
       truck.moving(key);
end;

procedure TFormGame.pointsLabelClick(Sender: TObject);
begin

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
   fruits.deletebonuses();
   fruits.deleteFruits();
   //truckImage.free;
   truck.Free;
   fruits.free;
   setting.Free;

   //pointsLabel.Free;
   //fon.free;
end;

procedure TFormGame.CreateFormGame(Sender: TObject);
begin
  setting:=Tsetting.Create();
  truck:=TTruck.Create;
  truck.ScreenResolution:=width-truck.truckImage.width;
  Fruits:=TFruits.Create();
end;

end.

