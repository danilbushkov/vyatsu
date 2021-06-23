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
          procedure choiceBonus();
          procedure view();
          constructor create();
  end;



implementation
   uses main,uFruitItem,utruck;



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
        choiceBonus();


   end;
   procedure tbonus.deactivate();
   begin
        active:=false;
        choiceBonus();
   end;

   procedure tbonus.choiceBonus();
   begin
      if typeBonus='big' then    //1
      begin
         if active then
         begin
            truck.truckImage.width:=truck.truckImage.width+70;
            truck.truckImage.height:=truck.truckImage.height+trunc(70*0.45);
            truck.NormSize();
         end
         else
         begin
            truck.truckImage.width:=truck.truckImage.Width-70;
            truck.truckImage.height:=truck.truckImage.height-trunc(70*0.45);
            truck.NormSize();
         end;
      end
      else if typeBonus='little' then  //2
      begin
         if active then
         begin
           truck.truckImage.width:=truck.truckImage.width-50;
           truck.TruckImage.height:=truck.TruckImage.Height-trunc(50*0.45);
           truck.NormSize();

         end
         else
         begin
           truck.truckImage.width:=truck.truckImage.width+50;
           truck.TruckImage.height:=truck.TruckImage.Height+trunc(50*0.45);
           truck.NormSize();

         end;

      end
      else if typeBonus='slow' then     //3
      begin
         if active then
         begin
            truck.speed:=truck.speed-5;
         end
         else
         begin
            truck.speed:=truck.speed+5;
         end;
      end
      else if typeBonus='fast' then  //4
      begin
         if active then
         begin
            truck.speed:=truck.speed+5;
         end
         else
         begin
            truck.speed:=truck.speed-5;
         end;
      end
      else if typeBonus='double' then     //5
      begin
         if active then
         begin
            Fruits.ratiopoint:=2;
         end
         else
         begin
            Fruits.ratiopoint:=1;
         end;
      end
      else if typeBonus='kit' then //6
      begin
         if active then
         begin

         end
         else
         begin

         end;
      end;
   end;

end.

