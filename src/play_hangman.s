@ play_hangman.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global play_hangman
    .type play_hangman, %function
play_hangman:
    push {r4, r5, fp, lr}
    add fp, sp, #12

    

    pop {r4, r5, fp, pc}
