@ get_file_size.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global get_file_size
    .type get_file_size, %function
get_file_size:
    push {r4, r5, fp, lr}
    add fp, sp, #12

    mov r4, r0
    mov r1, #0
    mov r2, #2
    bl fseek
    mov r0, r4
    bl ftell
    add r5, r0, #1
    mov r0, r4
    mov r1, #0
    mov r2, #0
    bl fseek
    mov r0, r5

    pop {r4, r5, fp, pc}
