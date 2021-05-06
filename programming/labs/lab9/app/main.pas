unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, GenerateUnit,
  Sort;

type

  { TForm1 }

  { TMainForm }

  TMainForm = class(TForm)
    ButtonMerge: TButton;
    SortButton: TButton;
    ShowButton: TButton;
    ButtonGenerate: TButton;
    procedure ButtonMergeClick(Sender: TObject);
    procedure SortButtonClick(Sender: TObject);
    //procedure ShowButtonClick(Sender: TObject);
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

//procedure TMainForm.ShowButtonClick(Sender: TObject);
//begin
//   FormShow.ShowFile(GenerateForm.sourceFileName);
//   FormShow.ShowModal();
//end;

procedure TMainForm.SortButtonClick(Sender: TObject);
begin
    SplitFile(GenerateForm);
end;

procedure TMainForm.ButtonMergeClick(Sender: TObject);
begin
  merge(GenerateForm);
end;


end.

