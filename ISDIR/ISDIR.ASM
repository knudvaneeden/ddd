;께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께
;께? Program:       IsDir.asm                                               께?
;께꽜袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴呱께
;께? Date:          07/25/94                                                께?
;께꼼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캉께
;께? Author:        RW Klein (Edmonton Alberta Canada)                      께?
;께?                Compuserve ID = 73364,451                               께?
;께꼼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캉께
;께? Description:   TSE bin file to determine if passed string is the name  께?
;께?                of a directory.                                         께?
;께꼼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캉께
;께? Compiler:      MASM 6.00                                               께?
;께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께께
.MODEL Huge,Pascal
.CODE

;굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇?
;굇? Align each jump on a 3 byte boundary. 굇?
;굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇?
JUMP MACRO dest                 ;; Force a 3 byte jump
        db      0e9h            ;; jmp opcode
        dw      offset dest - $ - 2
ENDM    JUMP

;굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
;굇? Create Jump Table                                굇?
;굇?  - needed if more than one procedure in BIN file 굇?
;굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
JUMP    IsDir      ;; [0] checks if filename is a directory

;栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢
;栢? module:        IsDir                                                   栢?
;栢盃袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴谷栢
;栢? parameters:    DirName 컴 string                                       栢?
;栢俳컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콕栢
;栢? returns:       1 컴 DirName is the name of a directory                 栢?
;栢?                0 컴 DirName is NOT the name of a directory             栢?
;栢俳컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콕栢
;栢? description:   Determines if DirName is a directory.                   栢?
;栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢栢
IsDir PROC DirName:dWord
;賽賽賽賽賽賽賽賽賽賽賽?
lds si,DirName        ;; DS:SI = string structure
xor bx,bx
mov bl,Byte Ptr [si]  ;; BL = length of string
inc si
inc si                ;; DS:SI = string start (skip length byte & reserved byte)
mov dx,si             ;; DS:DX = start of string

;굇굇굇굇굇굇굇굇굇굇굇굇굇?
;굇? Make DirName ASCIIz 굇?
;굇굇굇굇굇굇굇굇굇굇굇굇굇?
add si,bx           ;; ds:si = last char of string + 1
mov bl,[si]         ;; save char after string (so it can be null terminated)
mov Byte Ptr [si],0 ;; null terminate the string (make it ASCIIz)

;굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇?
;굇? Get File Attribute of DS:DX 굇?
;굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇?
mov ax,4300h
int 21h                 ;; get file attrib of ds:dx
.if carry?
    xor ax,ax           ;; error
.else
    xor ax,ax           ;; set return value (0=not a directory)
    test cx,00010000b   ;; is it a directory?
    .if !zero?
        inc ax          ;; set return value (1=directory)
    .endif
.endif

mov Byte Ptr [si],bl    ;; restore char after string (replace zero in ASCIIz)

xor dx,dx               ;; set high return word to zero (dx:ax is returned)
ret
;複複複複複複
IsDir ENDP ;?
;賽賽賽賽賽賽
END
