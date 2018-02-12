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
    debug db "!!!", 10, 0
    format_out db "%.5lf", 10, 0
    format_inp db "%lf", 0
    tmp dq ?
    one dq 1.0
    deg dq 1.0
    fact dq 1.0
    eps dq ?
    e dq 1.0
    next dq 1.0
.code
_main: 
    invoke crt_scanf, addr format_inp, addr eps
    finit

    fld e
    
    _loop:
        fld next
        fadd st(1), st(0)
        
        fld eps
        fcompp

        fstsw ax
        sahf   

        jae _end
        
        fld next
        fld deg
        fmulp st(1), st(0)
        
        fld fact
        fld one
        faddp st(1), st(0)
        fst fact

        fdivp st(1), st(0)    
        fstp next

        jmp _loop
    _end:

    fstp e
    
    invoke crt_printf, addr format_out, e

    exit
end _main