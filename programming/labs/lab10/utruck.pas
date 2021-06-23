unit UTruck;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, ExtCtrls,usetting;

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
      livesImage:array[1..10] of Timage;
      truckImage:Timage;
      procedure countinglives();
      procedure viewLives();
      procedure CreateLive(id:integer);
      procedure normSize();
      procedure moving(key:word);
      procedure DeleteLives();
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
    ViewLives();
    lives:=setting.truckMaxLives;


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

procedure tTruck.ViewLives();
var i:integer;
begin
     for i:=1 to setting.truckMaxLives do
     begin
          CreateLive(i);

     end;
end;

procedure ttruck.countinglives();
var i:integer;
begin
     if(lives >= 0) then begin
       for i:=lives+1 to setting.truckMaxLives do
       begin
            if livesImage[i] <> nil then
            freeandnil(livesImage[i]);

       end;

     end;
end;

procedure tTruck.CreateLive(id:integer);
begin
    livesImage[id]:=TImage.create(FormGame);
    livesImage[id].parent:=FormGame;
    livesImage[id].Width:=30;


    livesImage[id].Stretch:=true;
    livesImage[id].Proportional:=true;
    livesImage[id].top:=10;
    livesImage[id].left:=100+40*(id);
    livesImage[id].Picture.LoadFromFile('image\live.png');
end;

procedure tTruck.DeleteLives();
var i:integer;
begin
    for i:=1 to 10 do
    begin
       livesImage[i].free;
    end;
end;

end.

