unit comprtr;

interface
type comparator=function(a,b:integer):boolean;

function DESC (a,b:integer):boolean;
function ASC(a,b:integer):boolean;

implementation

function DESC (a,b:integer):boolean;
begin
    Exit(a<b);
end;

function ASC(a,b:integer):boolean;
begin
    Exit(a>b);
end;

end.