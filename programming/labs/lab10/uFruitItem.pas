unit uFruitItem;


interface
uses ufruit,SysUtils,MMSystem,ubonus,usetting;


type
     fruitItemPtr=^fruitItem;
     fruitItem=record
       data:TFruit;
       prev,next: fruitItemPtr;
     end;
     tfruits=class
       private
         //l:integer;
         bonuses:array[1..6] of Tbonus;


       public
         points:integer;
         firstf,lastf:fruitItemPtr;
         procedure changePriority();
         procedure offset();
         procedure activateBonus(var bonus:TBonus);
         procedure activeBonus;
         procedure addNewFruit();
         procedure deleteFruit(var current:fruitItemPtr);
         procedure goDown();
         procedure randomFruits();
         procedure deleteFruits();
         procedure deletebonuses();
         constructor create();
     end;

var
   Fruits:tfruits;

implementation
    uses main;
   constructor TFruits.create();
   var i:integer;
   begin
       firstf:=nil;
       lastf:=nil;
       points:=0;
       for i:=1 to 6 do
       begin
         bonuses[i]:=tbonus.create();
       end;

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
           current^.data.FruitFree();
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
             firstf^.data.FruitFree();
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
          if (tmp^.data.catch()) and (tmp^.data.typeFruit<>'bonus') then
          begin
              a:=true;
              points:=points+tmp^.data.points;
              FormGame.pointsLabel.caption:='points: ' + IntToStr(points);
              sndPlaySound('sounds/catch.wav',SND_ASYNC);
          end
          else if (tmp^.data.catch()) and (tmp^.data.typeFruit='bonus') then
          begin
              a:=true;
              ActivateBonus(tmp^.data.bonus);
              sndPlaySound('sounds/catch.wav',SND_ASYNC);
          end;
          ActiveBonus();
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
    procedure Tfruits.activateBonus(var bonus:TBonus);
    begin

        if (not bonuses[bonus.id].active) then
        begin
            bonuses[bonus.id].typeBonus:=bonus.typeBonus;
            bonuses[bonus.id].time:=setting.bonusTime;
            bonuses[bonus.id].activate();

            bonuses[bonus.id].View();
            //bonuses[bonus.id].BonusImage.Left:=700+p*50;
            ChangePriority();
            offset();

        end
        else
        begin
            bonuses[bonus.id].time:=bonuses[bonus.id].time+setting.bonusTime;
            ChangePriority();
            offset();


        end;

    end;
    procedure tfruits.ChangePriority();
    var i,j,t:integer;
    begin
        j:=0;
        for i:=1 to 6 do
        begin
           if bonuses[i].active then
           begin
             bonuses[i].priority:=j;
             inc(j);
           end;
        end;
        //if j > 1 then begin
          for i:=1 to 5 do
          begin
             if bonuses[i].active then
             begin
                  j:=i+1;
                  while j<=6 do
                  begin
                       if bonuses[j].active then
                       begin
                            if (bonuses[i].time > bonuses[j].time)
                            and (bonuses[i].priority > bonuses[j].priority) then
                            begin
                               t:=bonuses[i].priority;
                               bonuses[i].priority:=bonuses[j].priority;
                               bonuses[j].priority:=t;
                            end;
                       end;
                       inc(j);
                  end;
             end;
          //end;

        end;
    end;

    Procedure Tfruits.ActiveBonus();
    var i:integer;
    begin
        for i:=1 to 6 do
        begin
               if bonuses[i].time > 0 then
               begin
                 bonuses[i].time:=bonuses[i].time-1;
               end
               else if bonuses[i].active then
               begin
                 bonuses[i].deactivate();
                 bonuses[i].BonusImage.free;

                 ChangePriority();
                 offset();
               end;

        end;
    end;

    procedure tfruits.offset();
    var i:integer;
    begin
        for i:=1 to 6 do
        begin
            if bonuses[i].active then
            begin
             bonuses[i].BonusImage.left:=700+bonuses[i].priority*50;
            end;
        end;
    end;

    procedure tfruits.deletebonuses();
    var i:integer;
    begin
       for i:=1 to 6 do
       begin
          bonuses[i].free;
       end;
    end;

end.
