program random_account;
type 
    account = record
        number: integer;
        cur: string;
        count: integer;
    end;

const 
    cu:array[1..5] of string = ('Euro','Rub','Dollar','Lek','Yen ');

var
    f: file of account;
    a:account;
    c,i: integer;

function rand(min:integer;max:integer):integer;
begin
    Exit(random(max-min+1)+min);
end;

begin
    Assign(f, '.\accounts.txt');
    Reset(f);
    if IOResult <> 0 then begin
        writeln('Error');
        halt;
    end;
    Seek(f, FileSize(f));
    Writeln('Enter count accounts:');
    readln(c);
    for i:=1 to c do begin
        with a do begin
            number:=rand(1,12332);
            cur:=cu[rand(1,5)];
            count:=rand(1,32744);
        end;
        write(f,a);
    end;

    Close(f);
end.