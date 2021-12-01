program arena;

uses bot1,bot2,utype;


const 
    numPlayer:array[0..1] of integer=(1,2);

var 
    mapBot1,mapBot2:TMap;
    shipsBot1,shipsBot2:Tships;
    StatusBot1,StatusBot2:TshipsStatus;
    countSets:integer;
    i:integer;
    FirstPlayerSet:integer;
    correctMap:boolean;
    GameProgress:TGameProgress;
    ErrorPlayer:integer=0;
    crd:TCoordinates;

procedure GameSet(var GameProgress:TGameProgress;i:integer);
var game:boolean=true;
    player:integer;
    n:integer;
    status:integer;
    win:integer;
begin
    player:=FirstPlayerSet;
    setLength(GameProgress,i);
    while (game) do
    begin
        if(player=1) then
        begin
            crd:=bot1.shoot();
            checkRepeatMove(player,mapBot2,crd);
            bot2.onOpponentShot(crd);
            n:=checkBungShip(StatusBot2,shipsBot2,crd);
            if(n>=0)then
            begin
                if(checkKillShip(StatusBot2,n))then
                begin
                    status:=3;
                end
                else
                begin
                    status:=2;
                end;
            end
            else
            begin
                status:=0;
                player:=2;
            end;
            bot1.shotResult(status);
            if(checkDefeat(StatusBot2)) then
            begin
                win:=1;
                game:=false;
            end;
        end 
        else
        begin
            crd:=bot2.shoot();
            checkRepeatMove(player,mapBot1,crd);
            bot1.onOpponentShot(crd);
            n:=checkBungShip(StatusBot1,shipsBot1,crd);
            if(n>=0)then
            begin
                if(checkKillShip(StatusBot1,n))then
                begin
                    status:=3;
                end
                else
                begin
                    status:=2;
                end;
            end
            else
            begin
                status:=0;
                player:=1;
            end;
            bot2.shotResult(status);
            if(checkDefeat(StatusBot1)) then
            begin
                win:=2;
                game:=false;
            end;
        end;
        
    end;
    
    GameProgress[i-1][1]:=i;
    GameProgress[i-1][2]:=win;
end;


begin
    //Ввод сетов
    Write('Enter count sets: ');
    readln(countSets);
    setLength(GameProgress,countSets);

    //Начинаем игру
    bot1.onGameStart();
    bot2.onGameStart();
    
    

    //Передаем количество сетов
    bot1.setParameters(countSets);
    bot2.setParameters(countSets);
    
    //Выбор пергого игрока
    FirstPlayerSet:=randomPlayer();

    //Сеты
    for i:=1 to countSets do
    begin
        InitShipStatus(StatusBot1);
        InitShipStatus(StatusBot2);

        //Инициализация сета
        bot1.onSetStart();
        bot2.onSetStart();

        //Получить карты
        mapBot1:=bot1.getMap();
        mapBot2:=bot2.getMap();
       


        //Проверка карт участников;
        correctMap:=checkMap(mapBot1);
        if not correctMap then
        begin
            ErrorPlayer:=1;
            break;
        end;
        correctMap:=checkMap(mapBot1);
         if not correctMap then
        begin
            ErrorPlayer:=2;
            break;
        end;
         //Сформировать массив кораблей
        shipsBot1:= sortShips( GetShips( getCells(mapBot1) ));
        shipsBot2:= sortShips( GetShips( getCells(mapBot2) ));


       
        //Сет
        GameSet(GameProgress,i);

        //Очистка сетов
        bot1.onSetEnd();
        bot2.onSetEnd();

        //Переход хода
        FirstPlayerSet:=numPlayer[FirstPlayerSet mod 2];
    end;

    //Подвести итоги игры
    DisplayResultGame(correctMap,GameProgress,ErrorPlayer);

    //Завершаем
    bot1.onGameEnd();
    bot2.onGameEnd();

end.