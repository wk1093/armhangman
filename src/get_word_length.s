@ get_word_length.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global get_word_length
    .type get_word_length, %function
get_word_length:
    push {fp, lr}
    add fp, sp, #4

    mov r3, #0 @ length
    mov r2, r0 @ word
loop_begin:
    ldrb r0, [r2, r3]
    cmp r0, #0
    beq end
    cmp r0, #10
    beq end

    add r3, r3, #1
    b loop_begin

end:
    mov r0, r3 @ return length

    pop {fp, pc}
