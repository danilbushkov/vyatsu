library libbot1;

uses ubot1;

procedure setParameters(setCount: integer);
begin
    ubot1.setParameters(setCount);
end;

procedure onGameStart();
begin
    ubot1.onGameStart();
end;

procedure onSetStart();
begin
    ubot1.onSetStart();
end;

function getMap(): TMap;
begin
    Exit(ubot1.getMap());
end;

function shoot(): TCoordinates;
begin
    Exit(ubot1.shoot());
end;

procedure shotResult(resultCode: integer);
begin
    ubot1. shotResult(resultCode);
end;

procedure onOpponentShot(cell: TCoordinates);
begin
    ubot1.onOpponentShot(cell);
end;

procedure onSetEnd();
begin
    ubot1.onSetEnd();
end;

procedure onGameEnd();
begin
    ubot1.onGameEnd();
end;




exports
  setParameters, onGameStart, onSetStart, getMap,
  shoot, shotResult, onOpponentShot, onSetEnd, onGameEnd;

begin
end.