unit UTestBot;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

  TTestBot= class(TTestCase)
  published
    procedure TestHookUp;
  end;

implementation

procedure TTestBot.TestHookUp;
begin


  Fail('Напишите ваш тест');
end;



initialization

  RegisterTest(TTestBot);
end.

