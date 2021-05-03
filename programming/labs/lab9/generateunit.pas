unit GenerateUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  Generate;

type

  { TGenerateForm }

  TGenerateForm = class(TForm)
    ButtonGenerate: TButton;
    ButtonSelectFile: TButton;
    OpenDialog: TOpenDialog;

    procedure ButtonGenerateClick(Sender: TObject);
    procedure ButtonSelectFileClick(Sender: TObject);
  private

  public
      sourceFileName: String;
      workingArea: String;
  end;

var
  GenerateForm: TGenerateForm;


implementation

{$R *.lfm}

{ TGenerateForm }

procedure TGenerateForm.ButtonSelectFileClick(Sender: TObject);
begin
    if OpenDialog.Execute then
    begin
      sourceFileName := OpenDialog.FileName;
      workingArea := OpenDialog.InitiaLDir;
      ButtonGenerate.Enabled:=true;
    end;
end;

procedure TGenerateForm.ButtonGenerateClick(Sender: TObject);
begin
       GenerateFile(sourceFileName);
end;



end.

