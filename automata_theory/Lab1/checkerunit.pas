unit checkerunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Forms,Graphics,ExtCtrls;

type
Tcheckers= array[0..23] of TShape;
TcellsActive = array[0..7,0..7] of  TShape;
var checkers: Tcheckers;
  cellsActive: TcellsActive;




implementation


end.

