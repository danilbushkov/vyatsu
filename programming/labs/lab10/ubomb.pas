unit ubomb;

interface
uses
  Classes, SysUtils,ExtCtrls,usetting;


type
  tbomb=class
    public
          typeBomb:string[10];
          damage: integer;


          constructor create();
end;


implementation
    constructor tbomb.create();
    var i:integer;
    begin
      i:=random(100);
       if i < 60 then    //1
        begin
           typebomb:='bomb1';
           damage:=1;
        end
        else if i < 90 then  //2
        begin
           typeBomb:='bomb2';
           damage:=2;
        end
        else if i < 100 then     //3
        begin
           typeBomb:='bomb3';
           damage:=3;
        end
    end;

end.
