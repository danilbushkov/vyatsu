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
    Writeln('3 - Selection Sort');
    Writeln('4 - Counting Sort');
    Writeln('5 - Heap Sort');
    Writeln('Select the sorting method: ');
    
    Readln(method);
    Assign(f,path);
    ReadFile(arr,f);
    case method of 
        1: BubbleSort(arr, @ASC);
        2: InsertionSort(arr, @ASC);
        3: SelectionSort(arr, @ASC);
        4: CountingSort(arr);
        5: HeapSort(arr, @ASC);
    end;
    ShowSortedArray(arr);
    arr:=nil;

end.