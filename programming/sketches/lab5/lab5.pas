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
    Writeln('6 - Quick Sort');
    Writeln('7 - Marge Sort');
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
        6: QuickSort(arr,0,length(arr)-1 ,@ASC);
        7: MergeSort(arr,0,length(arr)-1, @ASC);
        
    end;
    ShowSortedArray(arr);
    arr:=nil;

end.