program lecture2_2;

type 
    account = record
        number: integer;
        cur: string;
        count: integer;
    end;
    accounts = array of account;

var 
    f:file of account;
    f2:file;
    a:accounts;
    i,j,c:integer;
    current:string;



begin
    Assign(f,'.\accounts.txt');
    Reset(f);
    if IOResult <> 0 then begin
        writeln('Error');
        halt;
    end;
    SetLength(a,FileSize(f));
    //writeln(FileSize(f));
    for i:=0 to FileSize(f)-1 do begin
        Seek(f,i);
        Read(f,a[i]);
        //Write(i, ' ');
        //Writeln(a[i].cur);
    end;
    c:=FileSize(f);
    Close(f);

    Sort(a);

    Assign(f2,'.\account_numbers.txt');
    Rewrite(f2);
    if IOResult <> 0 then begin
        writeln('Error');
        halt;
    end;
    j:=0;
    //current:=a[0].cur;
    // for i:=0 to c-1 do begin
    //     if a[i].cur <> current then begin
    //         current:=a[i].cur;
    //         write(f2, ' ');
    //         j:=0;
    //     end;
    //     if j=0 then Writeln(f2, current);
    //     Inc(j);
    //     Write(f2, a[i].number);
    //     if j = 5 then begin 
    //         write(f2);
    //         j:=0;
    //     end;
    // end;
    Close(f2);
end.