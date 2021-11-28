program test;

type Tcell=record
    a,b:integer;
end;

    TMapRow = array of integer;
    TMap = array of TMapRow;
    TCoordinates = array of integer;

Tships=array[0..19] of Tcell;

var ships:Tships;
    map:TMap;

procedure print(ships:Tships);
var i:integer;
begin
    for i:=0 to 19 do
    begin
        write(ships[i].a:3);
        
    end;
    writeln();
    for i:=0 to 19 do
    begin
        write(ships[i].b:3);
       
    end;
    writeln();
end;

procedure init();
begin
    map := TMap.Create(
        TMapRow.Create(1, 0, 1, 0, 1, 0, 1, 0, 0, 0),
        TMapRow.Create(0, 0, 1, 0, 1, 0, 1, 0, 0, 0),
        TMapRow.Create(1, 0, 0, 0, 1, 0, 1, 0, 0, 0),
        TMapRow.Create(0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
        TMapRow.Create(1, 0, 1, 0, 0, 0, 0, 0, 0, 0),
        TMapRow.Create(0, 0, 1, 0, 1, 0, 0, 0, 0, 0),
        TMapRow.Create(1, 0, 0, 0, 1, 0, 0, 0, 0, 0),
        TMapRow.Create(0, 0, 1, 0, 1, 0, 0, 0, 0, 0),
        TMapRow.Create(0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
        TMapRow.Create(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    );

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



function getShips(cells:Tships):Tships;
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
                    //write(1);
                // end
                // else if ((ships[i].a = ships[j].a) and
                //     (ships[i].b = ships[j].b+1)) or
                //     ((ships[i].a = ships[j].a+1) and
                //     (ships[i].b = ships[j].b)) then
                // begin
                //     cell:=ships[j];
                //     for k:=j downto i+2 do
                //     begin
                //         ships[j]:=ships[j-1];
                //     end;
                //     ships[i+1]:=ships[i];
                //     ships[i]:=cell;
                    
                //     w:=false;
                    
                end;
                inc(j);
            end;
            
        end;
        
        Inc(i);
    end;
    Exit(ships);
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




begin
    init();
    ships:=getCells(map);
    print(ships);
    ships:=getShips(ships);
    print(ships);
    ships:=sortShips(ships);
    print(ships);

end.