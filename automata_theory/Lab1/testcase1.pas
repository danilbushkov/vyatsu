unit TestCase1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry,checkerunit,ubot;

type

  TTestCase1= class(TTestCase)
  published
    procedure TestHookUp;
  end;

implementation
                                  //x
var m: Tlocation=((-1,  21, -1,  22, -1,  23, -1,  24),
                  ( 17, -1, 18, -1,  19, -1,  20, -1),
                  (-1,  13, -1,  14, -1,  15, -1,  16),
                  ( 0, -1,  0, -1,  0, -1,  0, -1),     //y
                  (-1,  0, -1,  0, -1,  0, -1,  0),
                  ( 9, -1,  10, -1,  11, -1,  12, -1),
                  (-1,  5, -1,  6, -1,  7, -1,  8),
                  ( 1, -1,  2, -1,  3, -1,  4, -1));


procedure TTestCase1.TestHookUp;
var i:integer;
  a,b,c:boolean;
begin
  b:=checkMove(2,3,m);

  AssertEquals(b,true);
  //Fail('Напишите ваш тест');
end;



initialization

  RegisterTest(TTestCase1);
end.

