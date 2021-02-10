program lecture1;
type 
    student = record 
        student_name: string;
        score: array[1..6] of integer;
    end;
const 
    scores: set of char= ['1' .. '5'];
var 
    f: text;
    s: string;
    students: array of student;
    i,j: integer;

function getStudent(str:string): student;
var l,i,j: integer;
    x: integer;
    e: integer;
    s: student;
begin
    s.student_name:='';
    j:=1;
    l:=pos(' ',str);
    for i:=1 to l-1 do begin

        s.student_name:=s.student_name+str[i];
    end; 
    for i:=l+1 to length(str) do begin
        if (str[i] in scores) then begin
            val(str[i],x,e);
            s.score[j]:=x;
            inc(j);
        end; 
    end;
    Exit(s);
end;

procedure WriteFile(var s: array of student);
var 
    f: text;
    i,j: integer;
    st: boolean;
begin
    assign(f, '.\output.txt');
    Rewrite(f);
    if ioResult<>0 then begin
        close(f);
        writeln('Error');
        halt;
    end;
    for i:=0 to High(s) do begin
        st:=true;
        for j:=1 to 6 do begin
            if s[i].score[j]=2 then begin
                st:=false;
            end; 
        end;
        if st then writeln(f,s[i].student_name);
    end;
    close(f);
end;

begin
    assign(f, '.\input.txt');
    reset(f);
    if ioResult<>0 then begin
        close(f);
        writeln('Error');
        halt;
    end;
    i:=1;
    while not eof(f) do begin
        readln(f,s);
        setLength(students,i);
        students[i-1]:=getStudent(s);
        Inc(i);
    end;
    

    WriteFile(students);
    students:=nil;
    close(f);
    
end.

