unit QueueStruct;

interface

type
TypeValue = integer;
    node = record
        data: TypeValue;
        next: ^node;
    end;
    Queue = record
        beginQ,endQ:^node;
    end;

procedure InitQueue(var q:queue);
function Empty(var q:Queue):boolean;
procedure InsertQ(var q:Queue;d:TypeValue);
function Remove(var q:Queue;var n:TypeValue):boolean;
procedure ShowQueue(var q:Queue);
procedure Clear(var q:Queue);

    


implementation

procedure InitQueue(var q:queue);
begin
    q.beginQ:=nil;
    q.endQ:=nil;
end;

function Empty(var q:Queue):boolean;
begin
    Exit(q.beginQ=nil);
end;

procedure InsertQ(var q:Queue;d:TypeValue);
begin
    if q.beginQ = nil then
    begin
        new(q.beginQ);
        q.endQ:=q.beginQ;
    end
    else
    begin
        new(q.endQ^.next);
        q.endQ:=q.endQ^.next;
    end;
    q.EndQ^.data:=d;
    q.EndQ^.next:=nil;
end;

function Remove(var q:Queue;var n:TypeValue):boolean;
var t:^node;
begin
    if Empty(q) then
    begin
        Exit(false);
    end;
    n:=q.beginQ^.data;
    t:=q.beginQ;
    q.beginQ:=q.beginQ^.next;
    if q.beginQ=nil then
        q.endQ:=nil;
    dispose(t);
    Exit(true);
end;

procedure ShowQueue(var q:Queue);
var t:^node;
begin
    if Empty(q) then
    begin
        Write('The queue is empty.');
        Exit();
    end;
    t:=q.beginQ;
    while t<>nil do
    begin
        write(t^.data,' ');
        t:=t^.next;
    end;
end;

procedure Clear(var q:Queue);
var e:TypeValue;
begin
    while Remove(q,e) do;
end;

end.