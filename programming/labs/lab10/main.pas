unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,utruck;

type

  { TFormGame }

  TFormGame = class(TForm)
    Fon: TImage;
    truckImage: TImage;
    procedure CreateFormGame(Sender: TObject);
    procedure FonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure truckImageClick(Sender: TObject);
  private

  public

  end;

var
  FormGame: TFormGame;
  truck: TTruck;

implementation

{$R *.lfm}

{ TFormGame }

procedure TFormGame.truckImageClick(Sender: TObject);
begin

end;

procedure TFormGame.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
       truck.moving(truckImage,key);
end;

procedure TFormGame.FonClick(Sender: TObject);
begin

end;

procedure TFormGame.CreateFormGame(Sender: TObject);
begin
  truck:=TTruck.Create;
  truck.ScreenResolution:=width-truckImage.width;
end;

end.

