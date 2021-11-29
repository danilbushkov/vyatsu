unit utype;

interface
type

    Tcell=record
        a,b:integer;
    end;
    TMapRow = array of integer;
    TMap = array of TMapRow;
    TCoordinates = array of integer;
    TGameProgress = array of array[1..2] of integer;
    TBadSituation = array[0..1,0..1] of integer;
    TBadSituations = array[1..7] of TBadSituation;

    Tships=array[0..19] of Tcell;
    TshipsStatus=array[0..19] of integer;
const
    SHOT_RESULT_EMPTY: integer = 0; // Промах
    SHOT_RESULT_DAMAGE: integer = 2; // Корабль соперника ранен (подбит)
    SHOT_RESULT_KILL: integer = 3; // Корабль соперника убит (подбиты все палубы)
    

function randomPlayer():integer;
function checkMap(m:Tmap):boolean;
procedure DisplayResultGame(correctMap:boolean;GameProgress:TGameProgress;p:integer);
function getCells(map:Tmap):Tships;
function checkShip(ships:Tships;j,d:integer):boolean;
function sortShips(ships:Tships):Tships;
function getShips(ships:Tships):Tships;
function checkKillShip(sh:TshipsStatus;n:integer):boolean;
function checkDefeat(s:TshipsStatus):boolean;
procedure InitShipStatus(var shipstatus:TshipsStatus);
function checkBungShip(var shipstatus:TshipsStatus;ships:Tships;c:TCoordinates):integer;


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
var i:integer;
    bot1,bot2:integer;
begin
    bot1:=0;
    bot2:=0;
    if(not correctMap)then
    begin
        Write(p);
        Write(' bot bad card');
        Write('!!!');
        Exit();
    end;
    for i:=0 to length(GameProgress)-1 do
    begin
        write('Set '); write(GameProgress[i][1]);write(' - ');writeln(GameProgress[i][2]);
        if(GameProgress[i][2]=1)then
        begin
            Inc(bot1);
        end
        else
        begin
            Inc(bot2);
        end;
    end;
    Write('Bot1 - '); Writeln(bot1);
    Write('Bot2 - '); Writeln(bot2);
    
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

function getCells(map:Tmap):Tships;
var i,j,k:integer;
    cells:Tships;
begin
    k:=0;
    for i:=0 to 9 do
    begin
        for j:=0 to 9 do
        begin
            if map[i][j]=1 then
            begin
                cells[k].a:=i;
                cells[k].b:=j;
                Inc(k);
            end;
        end;
    end;
    Exit(cells);
end;

function checkShip(ships:Tships;j,d:integer):boolean;
var i:integer;
    k:integer;
begin
    k:=0;
    for i:=0 to d do
    begin
        if ((ships[j].a=ships[j+i].a) and (ships[j].b=ships[j+i].b-i))
        then
        begin
            Inc(k);
        end
        
    end;
    if(k=d+1) then Exit(True);
    k:=0;
    for i:=0 to d do
    begin
        if ((ships[j].a=ships[j+i].a-i) and (ships[j].b=ships[j+i].b))
                then
        begin
            Inc(k);
        end
        
    end;
    if(k=d+1) then Exit(True);
        
    
    Exit(false);
end;

function sortShips(ships:Tships):Tships;
var i,j,l,r,y:integer;
    M:Tships;
    k,d:integer;
    w:boolean;
begin
    k:=1;
    d:=3;
    r:=0;
    i:=0;
    while i<10 do
    begin
        j:=0;
        y:=0;
        w:=true;
        while (j<20) and w do
        begin
            //writeln(ships[j].a);
            //writeln(ships[j+d].a);
            

            if (d<>0) and checkShip(ships,j,d)
                 then
            begin
                inc(y);
                inc(i);
                for l:=j to j+d do
                begin
                    M[r]:=ships[l];
                    inc(r);
                    
                    ships[l].a:=-1;
                    ships[l].b:=-1;

                end;
                //print(ships);
                if(y=k)then
                begin
                    w:=false;
                    inc(k);
                    dec(d);
                    
                end;
            end 
            else
            if d=0 then
            begin
                if ( ships[j].a>-1 ) then
                begin
                    M[r]:=ships[j];
                    inc(r);
                    inc(i);
                    writeln(d);
                end;
                if(r=20) then
                begin
                    w:=false;
                end;
            end;
            inc(j);
           
        end; 
       
    end;
    Exit(M);
end;



function getShips(ships:Tships):Tships;
var i,j,k:integer;
    w:boolean=true;
    cell:Tcell;
   
begin
    i:=0;
    while i<20 do  
    begin
        
        if not (((ships[i].a = ships[i+1].a) and
            (ships[i].b = ships[i+1].b-1)) or
            ((ships[i].a = ships[i+1].a-1) and
            (ships[i].b = ships[i+1].b))) then
        begin
            j:=i+1;
            w:=true;
            while (j<20)and w do
            begin
                if ((ships[i].a = ships[j].a) and
                (ships[i].b = ships[j].b-1)) or
                ((ships[i].a = ships[j].a-1) and
                (ships[i].b = ships[j].b)) then
                begin
                    cell:=ships[j];
                    for k:=j downto i+1 do
                    begin
                        ships[k]:=ships[k-1];
                    end;
                    ships[i+1]:=cell;
                    w:=false;
                    
                end;
                inc(j);
            end;
            
        end;
        
        Inc(i);
    end;
    Exit(ships);
end;

function checkBungShip(var shipstatus:TshipsStatus;ships:Tships;c:TCoordinates):integer;
var i:integer;
    //cell:Tcell;
begin
    for i:=0 to 19 do
    begin
        if (ships[i].a = c[0]) and (ships[i].b=c[1] ) then
        begin
            shipstatus[i]:=1;
            Exit(i);
        end;
    end;
    Exit(-1);
end;


function checkKillShip(sh:TshipsStatus;n:integer):boolean;
var i:integer;
    s,d:integer;
begin
    if n <=3 then
    begin
        d:=3;
        s:=0;
    end else 
    if n <=6 then
    begin
        d:=2;
        s:=4;
    end
    else if n <=9 then
    begin
        d:=2;
        s:=7;
    end
    else if n <= 11 then
    begin
        d:=1;
        s:=10;
    end
    else if n <= 13 then
    begin
        d:=1;
        s:=12;
    end
    else if n <= 15 then
    begin
        d:=1;
        s:=14;
    end
    else 
    begin
        if sh[n] = 1 then
        begin
            Exit(true);
        end else
        begin
            Exit(false);
        end;
    end;

    for i:=s to s+d do
    begin
        if sh[i]=0 then
        begin
            Exit(false);
        end;
    end;

    Exit(true);
end;

function checkDefeat(s:TshipsStatus):boolean;
var i:integer;
begin
    for i:=0 to 19 do
    begin
        if (s[i]=0) then Exit(false);
    end;
    Exit(true);
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

procedure InitShipStatus(var shipstatus:TshipsStatus);
var i:integer;
begin
    for i:=0 to 19 do
    begin
        shipstatus[i]:=0;
    end;
end;

initialization
begin
    Init();
end;



end.
