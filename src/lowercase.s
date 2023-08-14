@ lowercase.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global lowercase
    .type lowercase, %function
lowercase:
    push {r4, r5, fp, lr}
    add fp, sp, #12

    mov r4, r0 @ r4 = word
    bl get_word_length
    mov r5, r0 @ r5 = length
    mov r3, #0 @ r3 = i
loop_begin:
    cmp r3, r5
    bge loop_end

    ldrb r0, [r4, r3]
    @ conv char to int for tolower
    sxtb r0, r0
    bl tolower
    strb r0, [r4, r3]

    add r3, r3, #1
    b loop_begin
loop_end:

    pop {r4, r5, fp, pc}
