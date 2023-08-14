@ print_hangman.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global print_hangman
    .type print_hangman, %function
print_hangman:
    push {r4, r5, fp, lr}
    add fp, sp, #12

    mov r5, r0
    ldr r0, =hangman_msg
    bl printf

    mov r4, #0
loop_begin:
    cmp r4, #7
    bge loop_end

    cmp r4, r5
    blt print_char

    ldr r0, =hangman_blank
    bl printf
    b loop_inc

print_char:
    @print ith element of hangman
    ldr r0, =hangman
    ldr r1, [r0, r4]
    ldr r0, =hangman_char

    bl printf


loop_inc:
    add r4, r4, #1
    b loop_begin

loop_end:
    ldr r0, =newline_msg
    bl printf

    pop {r4, r5, fp, pc}

    .section .rodata
    .align 2

hangman_msg:
    .asciz "Hangman: "
hangman_blank:
    .asciz "- "
hangman_char:
    .asciz "%c "
hangman:
    .asciz "HANGMAN"
newline_msg:
    .asciz "\n"