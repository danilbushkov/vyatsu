unit UTruck;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, ExtCtrls;

type
  TTruck = class

    private
    pictureLeft:boolean;
    procedure left(var t:TImage);
    procedure right(var t:TImage);

    public
    screenResolution:integer;
    procedure moving(var t:TImage;key:word);
    constructor Create;


  end;
const
  speed=10;


implementation

constructor TTruck.Create;
begin
    pictureLeft:=false;
end;

procedure TTruck.moving(var t:TImage;key:word);
begin
     case ord(key) of
           39: begin //вправо
                right(t);

              

           end;
           37: begin //влево
                left(t);

               
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

end.

