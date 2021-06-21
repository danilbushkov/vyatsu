unit ufruit;

 {$mode objfpc}{$H+}

interface
uses
    Classes, SysUtils, Forms, ExtCtrls,utruck;
type
   TFruit=class
     private
       procedure getApple();
       procedure getPineApple();
       procedure getGrape();
       procedure getWatermelon();
       procedure getOrange();
       procedure getBanana();
       procedure GetRandomFruits();

     public
       FruitImage: TImage;
       points:integer;
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
         //FruitImage:=TImage.create(FormGame);
         //FruitImage.parent:=FormGame;
         //FruitImage.Picture.LoadFromFile('image\fruits\pineapple.png');
         //
         //FruitImage.Stretch:=true;
         //FruitImage.Proportional:=true;
         ////FruitImage.Top:=10;
         ////FruitImage.left:=10;
         //FruitImage.top:=-100;
         //FruitImage.Width:=100;
         //FruitImage.left:=random(FormGame.Width-FruitImage.Width);
         GetRandomFruits();

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



    procedure TFruit.GetRandomFruits();
    const
        j=100;
    var i:integer;
    begin
          i:=random(j);
          FruitImage:=TImage.create(FormGame);
          FruitImage.parent:=FormGame;


          if i < 23 then    //1
          begin
             GetGrape();
          end
          else if i < 46 then  //2
          begin
             GetOrange();
          end
          else if i < 69 then     //3
          begin
             GetBanana();
          end
          else if i < 82 then  //4
          begin
            GetApple();
          end
          else if i < 95 then     //5
          begin
            GetPineApple();
          end
          else //6
          begin
            GetWatermelon();
          end;

          //case i of
          //  0:begin
          //    GetApple();
          //  end;
          //  1:begin
          //    GetPineApple();
          //  end;
          //  2:begin
          //    GetGrape();
          //  end;
          //  3:begin
          //    GetWatermelon();
          //  end;
          //  4:begin
          //    GetBanana();
          //  end;
          //  5:begin
          //    GetOrange();
          //  end;
          //end;

          FruitImage.top:=-100;
          FruitImage.Width:=100;
          FruitImage.Stretch:=true;
          FruitImage.Proportional:=true;
          FruitImage.left:=random(FormGame.Width-FruitImage.Width div 2);

    end;

    procedure TFruit.GetPineapple();
    begin
         FruitImage.Picture.LoadFromFile('image\fruits\pineapple.png');
         points:=2;
    end;

    procedure TFruit.GetApple();
    begin
         FruitImage.Picture.LoadFromFile('image\fruits\apple.png');
         points:=2;
    end;

    procedure TFruit.GetWatermelon();
    begin
         FruitImage.Picture.LoadFromFile('image\fruits\watermelon.png');
         points:=3;
    end;

    procedure TFruit.GetOrange();
    begin
         FruitImage.Picture.LoadFromFile('image\fruits\orange.png');
         points:=1;
    end;
    procedure TFruit.GetBanana();
    begin
         FruitImage.Picture.LoadFromFile('image\fruits\banana.png');
         points:=1;
    end;
    procedure TFruit.GetGrape();
    begin
         FruitImage.Picture.LoadFromFile('image\fruits\grape.png');
         points:=1;
    end;

end.

