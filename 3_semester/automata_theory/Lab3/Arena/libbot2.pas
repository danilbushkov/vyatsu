library libbot2;

uses ubot2;

procedure setParameters(setCount: integer);
begin
    ubot2.setParameters(setCount);
end;

procedure onGameStart();
begin
    ubot2.onGameStart();
end;

procedure onSetStart();
begin
    ubot2.onSetStart();
end;

function getMap(): TMap;
begin
    Exit(ubot2.getMap());
end;

function shoot(): TCoordinates;
begin
    Exit(ubot2.shoot());
end;

procedure shotResult(resultCode: integer);
begin
    ubot2. shotResult(resultCode);
end;

procedure onOpponentShot(cell: TCoordinates);
begin
    ubot2.onOpponentShot(cell);
end;

procedure onSetEnd();
begin
    ubot2.onSetEnd();
end;

procedure onGameEnd();
begin
    ubot2.onGameEnd();
end;



exports
  setParameters, onGameStart, onSetStart, getMap,
  shoot, shotResult, onOpponentShot, onSetEnd, onGameEnd;

begin
end.