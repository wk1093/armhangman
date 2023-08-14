@ main.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global main
    .type main, %function
main:
    push {r4, r5, fp, lr}
    add fp, sp, #12

    cmp r0, #2
    beq correct_args

    ldr r0, =error_msg
    ldr r1, [r1]
    bl printf
    mov r0, #1
    b exit

correct_args:
    push {r1}
    bl seed_random
    pop {r1}
    ldr r0, [r1, #4]
    bl get_random_word
    mov r5, r0 @ r5 = word
    bl lowercase
    mov r0, r5
    bl get_word_length
    mov r1, r0 @ r4 = word_length
    mov r0, r5
    bl play_hangman

    mov r0, #0
exit:

    pop {r4, r5, fp, pc}

    .section .rodata
    .align 2
error_msg:
    .asciz "Usage: %s <wordlist>\n"