unit utype;

interface
type
    TMapRow = array of integer;
    TMap = array of TMapRow;
    TCoordinates = array of integer;
    TGameProgress = array of array[1..2] of integer;
    TBadSituation = array[0..1,0..1] of integer;
    TBadSituations = array[1..7] of TBadSituation;
const
    SHOT_RESULT_EMPTY: integer = 0; // Промах
    SHOT_RESULT_DAMAGE: integer = 2; // Корабль соперника ранен (подбит)
    SHOT_RESULT_KILL: integer = 3; // Корабль соперника убит (подбиты все палубы)
    

function randomPlayer():integer;
function checkMap(m:Tmap):boolean;
procedure DisplayResultGame(correctMap:boolean;GameProgress:TGameProgress;p:integer);


function checkBadSituation(var m:Tmap;s:TBadSituation;i,j:integer):boolean;
function checkBadSituations(var m:Tmap):boolean;

implementation

const 
    S1:TBadSituation = ((1,0),
                        (0,1));

    S2:TBadSituation = ((0,1),
                        (1,0));

    S3:TBadSituation = ((1,1),
                        (0,1));

    S4:TBadSituation = ((1,0),
                        (1,1));

    S5:TBadSituation = ((1,1),
                        (1,0));

    S6:TBadSituation = ((0,1),
                        (1,1));

    S7:TBadSituation = ((1,1),
                        (1,1));
var 
    BadSituations:TBadSituations;


function checkMap(m:Tmap):boolean;
begin
    if(checkBadSituations(m)) then
    begin
        Exit(false);
    end;
    Exit(true);
end;

function checkBadSituations(var m:Tmap):boolean;
var i,j,k:integer;
begin
    for i:=0 to length(m)-2 do begin
        for j:=0 to length(m)-2 do begin
            
            for k:=1 to 7 do
            begin
                if(checkBadSituation(m,BadSituations[k],i,j))then
                begin
                    Exit(True)
                end;
            end;

        end;
    end;
    Exit(false);
end;


function checkBadSituation(var m:Tmap;s:TBadSituation;i,j:integer):boolean;
begin
    if (m[i][j]=s[0][0]) and
       (m[i][j+1]=s[0][1]) and
       (m[i+1][j]=s[1][0]) and
       (m[i+1][j+1]=s[1][1]) then
       begin
            Exit(true);
       end;
    Exit(false);
end;

procedure DisplayResultGame(correctMap:boolean;GameProgress:TGameProgress;p:integer);
begin
    if(not correctMap)then
    begin
        Write(p);
        Write(' bot bad card');
        Write('!!!');
        Exit();
    end;
end;


function randomPlayer():integer;
var a:integer;
begin
    randomize;
    a:=random(100000);
    if (a < 50000) then
    begin
        Exit(1);
    end
    else
    begin
        Exit(2);
    end;
end;

procedure Init();
begin
    BadSituations[1]:=S1;
    BadSituations[2]:=S2;
    BadSituations[3]:=S3;
    BadSituations[4]:=S4;
    BadSituations[5]:=S5;
    BadSituations[6]:=S6;
    BadSituations[7]:=S7;
end;

initialization
begin
    Init();
end;



end.
