; Program BubbleSorting
.MODEL SMALL
.STACK 100H

.DATA
    ARRAY   DW 5, 1, 4, 2, 8
    UKURAN  DW (($ - ARRAY) / 2)

    MSG_BEFORE DB 'Array sebelum diurutkan: $'
    MSG_AFTER  DB 13, 10, 'Array setelah diurutkan: $'
    NEWLINE    DB 13, 10, '$'
    SPASI      DB ' $'

.CODE

MAIN PROC
    ; Inisialisasi Data Segment
    MOV AX, @DATA
    MOV DS, AX

    ; =================================
    ; MENAMPILKAN ARRAY SEBELUM SORTING
    ; =================================

    LEA DX, MSG_BEFORE
    MOV AH, 09H
    INT 21H

    CALL PRINT_ARRAY

    ; =================================
    ; PROSES BUBBLE SORT
    ; =================================

    MOV CX, UKURAN
    DEC CX

    ; Jika jumlah elemen kurang dari 2
    JZ SELESAI_SORT

LOOP_LUAR:
    MOV BX, CX
    MOV SI, 0

LOOP_DALAM:
    ; Mengambil dua elemen berdekatan
    MOV AX, ARRAY[SI]
    MOV DX, ARRAY[SI+2]

    ; Membandingkan kedua elemen
    CMP AX, DX
    JLE TIDAK_TUKAR

    ; Menukar elemen jika tidak berurutan
    MOV ARRAY[SI], DX
    MOV ARRAY[SI+2], AX

TIDAK_TUKAR:
    ADD SI, 2

    DEC BX
    JNZ LOOP_DALAM

    LOOP LOOP_LUAR

SELESAI_SORT:

    ; =================================
    ; MENAMPILKAN ARRAY SETELAH SORTING
    ; =================================

    LEA DX, MSG_AFTER
    MOV AH, 09H
    INT 21H

    CALL PRINT_ARRAY

    ; =================================
    ; KELUAR DARI PROGRAM
    ; =================================

    MOV AH, 4CH
    INT 21H

MAIN ENDP


; =====================================
; PROSEDUR PRINT_ARRAY
; Menampilkan seluruh isi array
; =====================================

PRINT_ARRAY PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DX

    MOV CX, UKURAN
    MOV SI, 0

CETAK_ARRAY:
    MOV AX, ARRAY[SI]

    CALL PRINT_NUMBER

    ; Menampilkan spasi
    LEA DX, SPASI
    MOV AH, 09H
    INT 21H

    ADD SI, 2

    LOOP CETAK_ARRAY

    ; Baris baru
    LEA DX, NEWLINE
    MOV AH, 09H
    INT 21H

    POP DX
    POP SI
    POP CX
    POP BX
    POP AX

    RET
PRINT_ARRAY ENDP


; =====================================
; PROSEDUR PRINT_NUMBER
; Menampilkan bilangan desimal unsigned
; Input: AX = angka yang akan dicetak
; =====================================

PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX, CX
    MOV BX, 10

    ; Pemeriksaan angka nol
    CMP AX, 0
    JNE KONVERSI

    MOV DL, '0'
    MOV AH, 02H
    INT 21H

    JMP SELESAI_CETAK

KONVERSI:
    XOR DX, DX
    DIV BX

    PUSH DX
    INC CX

    CMP AX, 0
    JNE KONVERSI

CETAK_DIGIT:
    POP DX

    ADD DL, '0'

    MOV AH, 02H
    INT 21H

    LOOP CETAK_DIGIT

SELESAI_CETAK:
    POP DX
    POP CX
    POP BX
    POP AX

    RET

PRINT_NUMBER ENDP

END MAIN
