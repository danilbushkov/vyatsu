unit bot1;

interface

uses utype;


const
    lib='libbot1.dll';


procedure setParameters(setCount: integer); external lib;
procedure onGameStart();external lib;
procedure onSetStart();external lib;
function getMap(): TMap;external lib;
function shoot(): TCoordinates;external lib;
procedure shotResult(resultCode: integer);external lib;
procedure onOpponentShot(cell: TCoordinates);external lib;
procedure onSetEnd();external lib;
procedure onGameEnd();external lib;


implementation




end.