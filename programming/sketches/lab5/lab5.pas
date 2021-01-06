program lab5;
uses WorkWithFile,
     WorkWithArr,   
     Comprtr,
     Sort;
var 
    f: text;
    path: string;
    arr: numbers;
    method: integer;
begin
    Write('Enter the path to the file: ');
    Readln(path);
    Writeln('1 - Bubble Sort');
    Writeln('2 - Insertion Sort');
    Writeln('Select the sorting method: ');
    Readln(method);
    Assign(f,path);
    ReadFile(arr,f);
    case method of 
        1: BubbleSort(arr, @ASC);
        2: InsertionSort(arr, @ASC);
    end;
    ShowSortedArray(arr);
    arr:=nil;

end.