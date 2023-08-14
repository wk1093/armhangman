@ is_game_over.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global is_game_over
    .type is_game_over, %function
is_game_over:
    push {fp, lr}
    add fp, sp, #4

    @ cmp r0, #7
    @ moveq r0, #1
    @ movne r0, #0

    @ cool way to do it
    sub r0, r0, #7 @ r0 = r0 - 7
    clz r0, r0     @ r0 = count_leading_zeroes(r0)
    lsr r0, r0, #5 @ r0 = r0 >> 5 (divide by 32)

    pop {fp, pc}
