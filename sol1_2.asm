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
    fmt_out db "%li ", 0
    fmt_out2 db "-%li ", 0
    fmt_inp_a db "a: ", 0
    fmt_inp_b db "b: ", 0
    fmt_val db "%li", 0
    a dd ?
    b dd ?
    m dd ?
    n dd ?
    q dd ?
    r dd ?
    a1 dd 0
    a2 dd 1
    b1 dd 1
    b2 dd 0
    
;Открываем секцию кода
.code
;Точка входа в основную программу:
_main:
    invoke crt_printf, addr fmt_inp_a
    invoke crt_scanf, addr fmt_val, addr a
    invoke crt_printf, addr fmt_inp_b
    invoke crt_scanf, addr fmt_val, addr b
_loop:
    cmp b, 0
    jle _exit
    mov eax, a
    mov edx, 0
    idiv b
    mov q, eax
    mov edx, 0
    imul b
    mov ebx, a
    sub ebx, eax
    mov r, ebx
    mov eax, q
    mov edx, 0
    imul a1
    mov edx, a2
    mov m, edx
    sub m, eax
    mov eax, q
    mov edx, 0
    imul b1
    mov edx, b2
    mov n, edx
    sub n, eax
    mov edx, b
    mov a, edx
    mov edx, r
    mov b, edx
    mov edx, a1
    mov a2, edx
    mov edx, m
    mov a1, edx
    mov edx, b1
    mov b2, edx
    mov edx, n
    mov b1, edx
    jmp _loop
_exit:
    invoke crt_printf, addr fmt_out, a
    invoke crt_printf, addr fmt_out, a2
    invoke crt_printf, addr fmt_out, b2
    exit
_pre1:
    mov eax, 0
    sub eax, a2
    invoke crt_printf, addr fmt_out2, eax
    cmp b2, 0
    jl _pre2
    invoke crt_printf, addr fmt_out, b2
    exit
_pre2: 
    mov eax, 0
    sub eax, b2
    invoke crt_printf, addr fmt_out2, eax
    exit   
end _main
