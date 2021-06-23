unit usetting;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  Tsetting = class
     public
       truckSpeed:integer;
       truckWidth:integer;
       truckHeight:integer;
       fruitSpeed:integer;
       fruitWidth:integer;
       ratioPoint:integer;
       truckMaxLives:integer;
       bonusSpeed:integer;
       bonusTime:longint;
      // bonusWidthA:integer;
       constructor Create();
  end;

  var setting:Tsetting;

implementation
      constructor tsetting.create();
      begin
         truckSpeed:=14;
         truckWidth:=200;
         truckHeight:=trunc(200*0.45);
         truckMaxLives:=5;
         fruitSpeed:=25;
         fruitWidth:=100;
         ratioPoint:=1;
         bonusSpeed:=30;
         bonusTime:=700;
         //bonusWidthA:=0;
      end;
end.

