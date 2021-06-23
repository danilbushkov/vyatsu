unit ufruit;

 {$mode objfpc}{$H+}

interface
uses
    Classes, SysUtils, Forms, ExtCtrls,MMSystem,usetting,utruck,ubonus,ubomb;
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
       procedure getBonus();
       procedure GetBomb();

     public
       FruitImage: TImage;
       points:integer;
       lives:integer;
       speed:integer;
       catchBomb:boolean;
       typeFruit:string[10];
       Bonus:Tbonus;
       Bomb:Tbomb;
       function goDown():boolean;
       function catch():boolean;
       procedure FruitFree();
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
         catchBomb:=false;
         GetRandomFruits();
         speed:=setting.fruitSpeed;
    end;

    function TFruit.GoDown():boolean;
    begin
         if (FruitImage.top < FormGame.Height-170) and (not catchBomb) then
         begin
              FruitImage.top:=FruitImage.top+speed;
         end
         else if (lives = 100) and (typefruit<>'bonus') and (typefruit<>'bomb')then
         begin
            FruitImage.Picture.LoadFromFile('image\fruits\'+typeFruit+'fell.png');
            FruitImage.top:=FruitImage.top+40;
            lives:=lives-5;
            //sndPlaySound('sounds/fell.wav',SND_ASYNC);
         end
         else if (lives = 25) and (typefruit='bomb') then
         begin
            FruitImage.Picture.LoadFromFile('image\bombs\fell.png');
            lives:=lives-5;
         end
         else if lives > 1 then
         begin
            lives:=lives-5;
         end
         else
         begin
           Exit(false);
         end;
         Exit(true);
    end;

    function TFruit.catch():boolean;
    begin
        if (FruitImage.top+50 > truck.TruckImage.top)
           and (FruitImage.top < truck.TruckImage.top+50)
           and (FruitImage.Left+25 > truck.TruckImage.Left)
           and (FruitImage.Left < truck.TruckImage.Left+
               truck.TruckImage.width-FruitImage.width/2)
           and ((lives>0) or (typefruit='bonus'))
           then
               Exit(true);
        Exit(false);
    end;

    procedure TFruit.FruitFree();
    begin
        FruitImage.Width:=0;
        FruitImage.Free;
        bonus.free;
        bomb.free;
    end;



    procedure TFruit.GetRandomFruits();
    const
        j=120;
    var i:integer;
    begin
          i:=random(j);
          FruitImage:=TImage.create(FormGame);
          FruitImage.parent:=FormGame;
          lives:=100;

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
          else if i < 100 then //6
          begin
            GetWatermelon();
          end
          else if i < 103 then
          begin
            GetBonus();
            lives:=0;
          end
          else
          begin
             GetBomb();
             lives:=25;
          end;

          FruitImage.top:=-100;
          FruitImage.Width:=setting.fruitwidth;
          FruitImage.Stretch:=true;
          FruitImage.Proportional:=true;
          FruitImage.left:=random(FormGame.Width-FruitImage.Width div 2);

    end;

    procedure TFruit.GetBomb();
    begin
         bomb:=tbomb.create;
         FruitImage.Picture.LoadFromFile('image\bombs\'+bomb.typeBomb+'.png');

         typeFruit:='bomb';
    end;

    procedure TFruit.getBonus();
    begin
         bonus:=tbonus.create;

         FruitImage.Picture.LoadFromFile('image\bonuses\'+bonus.typeBonus+'.png');

         typeFruit:='bonus';
    end;


    procedure TFruit.GetPineapple();
    begin
         FruitImage.Picture.LoadFromFile('image\fruits\pineapple.png');
         points:=2;
         typeFruit:='pineapple';
    end;

    procedure TFruit.GetApple();
    begin
         FruitImage.Picture.LoadFromFile('image\fruits\apple.png');
         points:=2;
         typeFruit:='apple';
    end;

    procedure TFruit.GetWatermelon();
    begin
         FruitImage.Picture.LoadFromFile('image\fruits\watermelon.png');
         points:=3;
         typeFruit:='watermelon';
    end;

    procedure TFruit.GetOrange();
    begin
         FruitImage.Picture.LoadFromFile('image\fruits\orange.png');
         points:=1;
         typeFruit:='orange';
    end;
    procedure TFruit.GetBanana();
    begin
         FruitImage.Picture.LoadFromFile('image\fruits\banana.png');
         points:=1;
         typeFruit:='banana';
    end;
    procedure TFruit.GetGrape();
    begin
         FruitImage.Picture.LoadFromFile('image\fruits\grape.png');
         points:=1;
         typeFruit:='grape';
    end;

end.

