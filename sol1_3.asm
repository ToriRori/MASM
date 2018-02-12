.386                    ;Указываем тип процессора
.model flat, stdcall    ;Указываем используемую модель памяти и соглашение о вызовах
option casemap: none    ;Сохраняет регистр имен, заданных пользователем

;Подключаем вспомогательные модули
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib
include \masm32\macros\macros.asm

;Открываем секцию данных
.data
    fmt_out db "%lu ", 0
    fmt_inp_a db "a: ", 0
    fmt_val db "%lu", 0
    a dd ?
    i dd ?
    cnt dd 0
    
;Открываем секцию кода
.code
;Точка входа в основную программу:
_main:
    invoke crt_printf, addr fmt_inp_a
    invoke crt_scanf, addr fmt_val, addr a
    mov i, 1
_loop:
    inc i
    mov eax, i
    mov edx, 0
    mul i
    cmp eax, a
    jg _pre
_res:
    mov edx, 0
    mov eax, a
    div i
    cmp edx, 0
    jne _loop
    push i
    inc cnt
    mov a, eax
    jmp _res
_pre:
    push a
    inc cnt      
_exit:
    cmp cnt, 0
    je _end
    pop eax
    dec cnt
    invoke crt_printf, addr fmt_out, eax
    jmp _exit
_end:
    exit
end _main
