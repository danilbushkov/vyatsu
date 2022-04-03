%assign max 25 ;масимальное значение массива

section .data
    ;массив для цвета вершин
    ;0 - белая (не посещенная)
    ;1 - серая (в стеке)
    ;2 - черная (посещенная)
    mass TIMES max DD 0
    size DD 0
    index DD 0
    target DD 0

section .text
    global _DFS
    extern  _printf

_DFS:
    push ebp 
    mov ebp, esp ;получаем вершину стека
    mov ecx, 0 ;обнуляем счетчик
    
    mov eax, 0
    null:;обнуляем массив
        mov dword [mass+eax], 0
        inc eax
    cmp eax, max
    jne null



    mov edx, [ebp+16] ;получаем массив
    mov eax, [ebp+20] ;получение размера массива
    mov [size], eax
    mov eax, [ebp+12] ;цель
    mov [target], eax
    

    mov edi, [ebp+8]
    push edi ;заносим первую вершину в стек
    inc ecx

    check_node:
        pop esi
        dec ecx

        ;mov eax, [mass]
        mov dword [mass+esi], 2 ;вершина метится черным цветом

        mov eax, 0
        imul edi, esi, max*4
        for_check:
            
            mov ebx, [edx+edi]

            cmp ebx, 1 ;если есть переход в вершину
            jne end_check
                cmp eax, [target]
                jne check_visit
                    mov eax,1 
                    jmp check_stack

                check_visit:
                mov ebx, [mass+eax]
                cmp ebx, 0
                jg end_check
                    mov dword [mass+eax], 1 ;метится серым цветом
                    push eax
                    inc ecx

            end_check:
            inc eax
            add edi, 4
        cmp eax, [size]
        jne for_check

    cmp ecx, 0
    jne check_node

    
    mov eax, 0 ;возвращаемое значени 0
    jmp check_stack

    clean:
        pop edx
        dec ecx
    check_stack:
    cmp ecx, 0
    jg clean

    pop ebp
    ret

