unit ufruit;

 {$mode objfpc}{$H+}

interface
uses
    Classes, SysUtils, Forms, ExtCtrls,utruck;
type
   TFruit=class
     private


     public
       FruitImage: TImage;
       function goDown():boolean;
       function catch():boolean;
       procedure FruitImageFree();
       constructor Create();
   end;



const
  countfruit=50;

   //countfruit:integer=50;
   //fruit:TFruit;//array[0..countfruit] of TFruit;

implementation
    uses main;
    constructor TFruit.Create();
    begin
         FruitImage:=TImage.create(FormGame);
         FruitImage.parent:=FormGame;
         FruitImage.Picture.LoadFromFile('image\fruits\pineapple.png');

         FruitImage.Stretch:=true;
         FruitImage.Proportional:=true;
         //FruitImage.Top:=10;
         //FruitImage.left:=10;
         FruitImage.top:=-100;
         FruitImage.Width:=100;
         FruitImage.left:=random(FormGame.Width-FruitImage.Width);


         //FruitImage.Height:=200;
    end;

    function TFruit.GoDown():boolean;
    begin
         if FruitImage.top < FormGame.Height-100 then
         begin
              FruitImage.top:=FruitImage.top+25;
         end
         else
         begin
             Exit(false);
         end;
         Exit(true);
    end;

    function TFruit.catch():boolean;
    begin
        if (FruitImage.top+50 > FormGame.TruckImage.top)
           and (FruitImage.top < FormGame.TruckImage.top+50)
           and (FruitImage.Left+25 > FormGame.TruckImage.Left)
           and (FruitImage.Left < FormGame.TruckImage.Left+
               FormGame.TruckImage.width-FruitImage.width/2)
           then
               Exit(true);
        Exit(false);
    end;

    procedure TFruit.FruitImageFree();
    begin
        FruitImage.Width:=0;
        FruitImage.Free;
    end;

end.

