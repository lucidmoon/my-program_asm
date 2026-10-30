.model small
.stack 100h
.data
    ; Deklarasi string "Halo dari Assembly di VS Code!" dengan karakter '\n' dan '\r'
    msg db 'Halo dari Assembly di VS Code!$', 0Dh, 0Ah

.code
main proc
    ; Menginisialisasi DS dengan nilai @data yang telah ditentukan
    mov ax, @data
    mov ds, ax
   

    ; Memanggil fungsi int 21h (print string) untuk menampilkan "Halo dari Assembly di VS Code!"
    lea dx, msg          ; Load address of msg into DX register
    mov ah, 09h         ; Load function number 09h to AH register
    int 21h            ; Call interrupt 21h

    ; Memanggil fungsi int 21h (exit program) untuk keluar dari program
    mov ah, 4Ch          ; Load function number 4Ch to AH register
    int 21h            ; Call interrupt 21h
main endp
end main
