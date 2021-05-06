unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ShowUnit;

type

  { TMainForm }

  TMainForm = class(TForm)
    ChooseButton: TButton;
    OpenDialog: TOpenDialog;
    ShowButton: TButton;
    procedure ChooseButtonClick(Sender: TObject);
    procedure ShowButtonClick(Sender: TObject);
  private

  public
     sourceFileName: String;
      workingArea: String;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.ChooseButtonClick(Sender: TObject);
begin
    if OpenDialog.Execute then
    begin
      sourceFileName := OpenDialog.FileName;
      workingArea := OpenDialog.InitiaLDir;
    end;
end;

procedure TMainForm.ShowButtonClick(Sender: TObject);
begin
    FormShow.ShowFile(sourceFileName);
    FormShow.ShowModal();
end;

end.

