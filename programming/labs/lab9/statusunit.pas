unit StatusUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls;

type

  { TFormStatus }

  TFormStatus = class(TForm)
    ProgressBar: TProgressBar;
  private

  public

  end;

var
  FormStatus: TFormStatus;

implementation

{$R *.lfm}

end.

