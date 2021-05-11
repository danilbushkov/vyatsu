unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Sort,
  Generate;

type

  { TForm1 }

  { TMainForm }

  TMainForm = class(TForm)
    ButtonSort: TButton;
    ButtonSelectFile: TButton;
    ButtonCheck: TButton;
    LabelCheck: TLabel;
    OpenDialog: TOpenDialog;
    ButtonGenerate: TButton;
    procedure ButtonCheckClick(Sender: TObject);
    procedure ButtonGenerateClick(Sender: TObject);
    //procedure ButtonMergeClick(Sender: TObject);
    procedure ButtonSelectFileClick(Sender: TObject);
    procedure ButtonSortClick(Sender: TObject);
    //procedure FormCreate(Sender: TObject);
    //procedure SortButtonClick(Sender: TObject);
    //procedure ShowButtonClick(Sender: TObject);
    //procedure ButtonGenerateClick(Sender: TObject);
  private

  public
    sourceFileName: String;
    workingArea: String;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TForm1 }



{ TMainForm }

//procedure TMainForm.ButtonGenerateClick(Sender: TObject);
//begin
//   GenerateForm.ShowModal();
//end;

//procedure TMainForm.ShowButtonClick(Sender: TObject);
//begin
//   FormShow.ShowFile(GenerateForm.sourceFileName);
//   FormShow.ShowModal();
//end;

//procedure TMainForm.SortButtonClick(Sender: TObject);
//begin
//    SplitFile(GenerateForm);
//end;
//
//procedure TMainForm.ButtonMergeClick(Sender: TObject);
//begin
//  merge(GenerateForm);
//end;

procedure TMainForm.ButtonSelectFileClick(Sender: TObject);
begin
    if OpenDialog.Execute then
    begin
      sourceFileName := OpenDialog.FileName;
      workingArea := OpenDialog.InitiaLDir;
      ButtonGenerate.Enabled:=true;
    end;
end;

procedure TMainForm.ButtonSortClick(Sender: TObject);
begin
    SplitFile(sourceFileName,workingArea);
    Merge(workingArea);
    ButtonCheck.Enabled:=true;
end;



procedure TMainForm.ButtonCheckClick(Sender: TObject);
var b: boolean;
begin
   b:=CheckFile(workingArea);
   if b then
   begin
      labelCheck.caption:='Отсортирован';
   end
   else
   begin
      labelCheck.caption:='Не отсортирован';
   end;
end;

procedure TMainForm.ButtonGenerateClick(Sender: TObject);
begin
  GenerateFile(sourceFileName);
  ButtonSort.Enabled:=true;
end;


end.

