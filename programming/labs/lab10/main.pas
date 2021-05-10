unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TFormGame }

  TFormGame = class(TForm)
    truck: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure truckClick(Sender: TObject);
  private

  public

  end;

var
  FormGame: TFormGame;

implementation

{$R *.lfm}

{ TFormGame }

procedure TFormGame.truckClick(Sender: TObject);
begin

end;

procedure TFormGame.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if ord(Key) = 37 then
      truck.left := truck.left+10;
      switch ord(key)
end;

end.

