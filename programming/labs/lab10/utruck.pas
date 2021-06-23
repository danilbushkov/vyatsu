unit UTruck;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, ExtCtrls,Windows,usetting;

type
  TTruck = class

    private
      pictureLeft:boolean;
      procedure left(var t:TImage);
      procedure right(var t:TImage);

    public
      screenResolution:integer;
      speed:integer;
      lives:integer;
      truckImage:Timage;
      procedure normSize();
      procedure moving(key:word);
      constructor Create;


  end;
var
  truck: TTruck;

implementation
  uses main;
constructor TTruck.Create;
begin
    pictureLeft:=false;
    speed:=setting.truckspeed;

    TruckImage:=TImage.create(FormGame);
    TruckImage.parent:=FormGame;
    TruckImage.Width:=setting.truckwidth;
    normsize();

    TruckImage.Stretch:=true;
    TruckImage.Proportional:=true;
    TruckImage.left:=100;
    truckImage.Picture.LoadFromFile('image\truck_right.png');
end;

//procedure TTruck.moving(var t:TImage);
//begin
//    if (GetKeyState(39) and $8000)<>0 then
//    begin
//        right(t);
//    end
//    else if (GetKeyState(37) and $8000)<>0 then
//    begin
//        left(t);
//    end;
//
//
//end;

procedure TTruck.moving(key:word);
begin
     case ord(key) of
           39: begin //вправо
                right(truckImage);



           end;
           37: begin //влево
                left(truckImage);


           end;
      end;
end;

procedure TTruck.right(var t:TImage);
begin
      if pictureLeft then
      begin
		t.Picture.LoadFromFile('image\truck_right.png');
                pictureLeft:=false;
      end;
      if t.left<screenResolution then
      begin
           t.left:=t.left+speed;
      end;
end;

procedure TTruck.left(var t:TImage);
begin
      if not pictureLeft then
      begin
		t.Picture.LoadFromFile('image\truck_left.png');
                pictureLeft:=true;
      end;
      if t.left>0 then
      begin
           t.left:=t.left-speed;
      end;
end;

procedure Ttruck.NormSize();
begin
     TruckImage.top:=formGame.height-90-truckimage.height;
     ScreenResolution:=formgame.width-truckImage.width;
end;

end.

