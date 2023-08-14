@ seed_random.s

@ void seed_random() { srand(time(NULL)); }

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global seed_random
    .type seed_random, %function
seed_random:
    push {fp, lr}
    add fp, sp, #4

    mov r0, #0
    bl time
    bl srand

    pop {fp, pc}
