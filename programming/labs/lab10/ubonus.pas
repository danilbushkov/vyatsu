unit ubonus;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,ExtCtrls,usetting;

type
  tbonus=class
    public
          id:integer;
          typeBonus:string[10];
          BonusImage:timage;
          time:longint;
          priority:integer;
          active:boolean;
          procedure activate();
          procedure deactivate();
          procedure view();
          constructor create();
  end;



implementation
   uses main;



   constructor tbonus.create();
   const
        j=47;
   var i:integer;
   begin

         i:=random(j);
         if i < 10 then    //1
          begin
             typeBonus:='big';
             id:=1;
          end
          else if i < 20 then  //2
          begin
             typeBonus:='little';
             id:=2;
          end
          else if i < 30 then     //3
          begin
             typeBonus:='slow';
             id:=3;
          end
          else if i < 38 then  //4
          begin
             typeBonus:='fast';
             id:=4;
          end
          else if i < 46 then     //5
          begin
             typeBonus:='double';
             id:=5;
          end
          else //6
          begin
             typeBonus:='kit';
             id:=6;
          end;
          active:=false;
   end;

   procedure tbonus.view();
   begin
        BonusImage:=TImage.create(FormGame);
        BonusImage.parent:=FormGame;
        bonusImage.picture.LoadFromFile('image\bonuses\'+typeBonus+'.png');
        BonusImage.top:=FormGame.height-50;
          BonusImage.Width:=40;
          BonusImage.Stretch:=true;
         BonusImage.Proportional:=true;

   end;
   procedure tbonus.activate();
   begin
        active:=true;
   end;
   procedure tbonus.deactivate();
   begin
        active:=false;
   end;

end.

