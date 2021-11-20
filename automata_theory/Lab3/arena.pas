program arena;

uses bot1,bot2,utype;


const 
    numPlayer:array[0..1] of integer=(1,2);

var 
    mapBot1,mapBot2:TMap;
    countSets:integer;
    i:integer;
    FirstPlayerSet:integer;
    correctMap:boolean;
    GameProgress:TGameProgress;
    ErrorPlayer:integer=0;
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
       
        //Сет
        //GameSet(GameProgress,i);

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