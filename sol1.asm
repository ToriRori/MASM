.386                    
.model flat, stdcall    
option casemap: none    

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib
include \masm32\macros\macros.asm

.data
    format_enter db " ", 10, 0
    format_out db "%hu ", 0
    fmt_inp_x db "x: ", 0
    fmt_inp_q db "q: ", 0
    fmt_val db "%hu", 0
    
    x dw ?
    q dw ?
    tmp dw 1
    arr dw 32 dup(0) 

.code
_main:
    invoke crt_printf, addr fmt_inp_x
    invoke crt_scanf, addr fmt_val, addr x
    invoke crt_printf, addr fmt_inp_q
    invoke crt_scanf, addr fmt_val, addr q
    
    mov tmp, 1
    
_loop:

    cmp x, 0
    je _exit

    mov dx, 0
    mov ax, x
    div q
    mov x, ax
    
    mov eax, offset arr
    movzx ebx, tmp
    mov [eax + 2*ebx], dx 
        
    inc tmp
    
    jmp _loop
    
_exit:

    dec tmp

_loop1:

    cmp tmp, 0
    je _end1

    mov eax, offset arr
    movzx edx, tmp
    mov bx, [eax + 2*edx]
    invoke crt_printf, addr format_out, ebx

    dec tmp

    jmp _loop1
    
_end1:

    invoke crt_printf, addr format_enter
    jmp _main
    
end _main
