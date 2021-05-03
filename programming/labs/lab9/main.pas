unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, GenerateUnit,
  showUnit;

type

  { TForm1 }

  { TMainForm }

  TMainForm = class(TForm)
    ShowButton: TButton;
    ButtonGenerate: TButton;
    procedure ShowButtonClick(Sender: TObject);
    procedure ButtonGenerateClick(Sender: TObject);
  private

  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TForm1 }



{ TMainForm }

procedure TMainForm.ButtonGenerateClick(Sender: TObject);
begin
   GenerateForm.ShowModal();
end;

procedure TMainForm.ShowButtonClick(Sender: TObject);
begin
   FormShow.ShowFile(GenerateForm.sourceFileName);
   FormShow.ShowModal();
end;

end.

