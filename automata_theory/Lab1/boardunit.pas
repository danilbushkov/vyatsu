unit boardunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

const boardSize=512;
const cellsize=boardSize div 8;


procedure InitBoard(var board: TBitMap);

implementation




procedure cell(cellx,celly:integer;var board:TBitMap;color:Tcolor);
begin
     board.Canvas.Brush.Color:=color;
     board.canvas.Rectangle(cellx*cellsize,
                  celly*cellsize,
                  cellx*cellsize+cellsize,
                  celly*cellsize+cellsize);
end;






procedure DrawBoard(var board:TBitMap);
var
   i,j:integer;
begin



   board.Canvas.Brush.Color:=clwhite;
   board.canvas.Rectangle(0,0,boardSize,boardSize);
   for i:=0 to 7 do
   begin
        for j:=0 to 7 do
        begin
             if ((i mod 2 <> 0) and (j mod 2 = 0)) or
             ((i mod 2 = 0) and (j mod 2 <> 0)) then
             begin
                  cell(i,j,board,clblack);

             end;
        end;

   end;



end;





procedure InitBoard(var board: TBitMap);
begin
     board:=TBitmap.Create;
     board.Width:=boardSize;
     board.Height:=board.Width;
     DrawBoard(board);
end;



end.

