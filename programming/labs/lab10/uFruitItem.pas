unit uFruitItem;


interface
uses ufruit,SysUtils;


type
     fruitItemPtr=^fruitItem;
     fruitItem=record
       data:TFruit;
       prev,next: fruitItemPtr;
     end;
     tfruits=class
       public
         points:integer;
         firstf,lastf:fruitItemPtr;
         procedure addNewFruit();
         procedure deleteFruit(var current:fruitItemPtr);
         procedure goDown();
         procedure randomFruits();
         procedure deleteFruits();
         constructor create();
     end;

var
   Fruits:tfruits;
implementation
    uses main;
   constructor TFruits.create();
   begin
       firstf:=nil;
       lastf:=nil;
       points:=0;
   end;

   procedure TFruits.addNewFruit();
   var
     tmp:fruitItemPtr;
   begin
      new(tmp);
      tmp^.data:=TFruit.Create();
      tmp^.prev:=lastf;
      tmp^.next:=nil;

      if lastf=nil then
      begin
         firstf:=tmp;
      end
      else
      begin
         lastf^.next:=tmp;
      end;
      lastf:=tmp;
   end;

   procedure TFruits.deleteFruit(var current:fruitItemPtr);
   begin


        if current^.prev = nil then
           firstf:=current^.next
        else
           current^.prev^.next:=current^.next;

        if current^.next = nil then
           lastf:=current^.prev
        else
           current^.next^.prev:=current^.prev;

        if current<>nil then
        begin
           current^.data.FruitImageFree();
           current^.data.Free;
        end;
        //current^.data.FruitImage.Picture:=nil;
        dispose(current);

   end;

   procedure TFruits.deleteFruits();
   var tmp:fruitItemPtr;
   begin
       while firstf<>nil do
       begin
             firstf^.data.FruitImageFree();
             firstf^.data.free;
             tmp:=firstf^.next;
             dispose(firstf);
             firstf:=tmp;
       end;
   end;

    procedure TFruits.goDown();
    var tmp,tmp2:fruitItemPtr;
      a,b:boolean;
    begin
       a:=false;
       tmp:=firstf;
       while tmp<>nil do
       begin
          b:=tmp^.data.goDown();
          if tmp^.data.catch() then
          begin
              a:=true;
              points:=points+tmp^.data.points;
              FormGame.pointsLabel.caption:='points: ' + IntToStr(points);
          end;

          if not b or a then
          begin
             tmp2:=tmp^.next;
             deleteFruit(tmp);
             tmp:=tmp2;
             a:=false;
          end
          else
          begin
             tmp:=tmp^.next;
          end;


       end;
    end;

    procedure TFruits.randomFruits();
    var i,j:integer;
    begin
        j:=random(0);
        for i:=0 to j do
        begin
           addNewFruit();
        end;
    end;




end.
