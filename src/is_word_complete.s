@ is_word_complete.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global is_word_complete
    .type is_word_complete, %function
is_word_complete:
    push {r4-r7, fp, lr}
    add fp, sp, #20

    mov r4, r0 @ r4 = word
    mov r5, r1 @ r5 = length
    mov r6, r2 @ r6 = guessed_letters
    mov r7, r3 @ r7 = guessed_letters_length

    mov r3, #0
loopi_begin:
    cmp r3, r5
    bge loopi_end
    push {r5}

    mov r5, #0
    mov r2, #0
loopj_begin:
    cmp r2, r7
    bge loopj_end

    ldrb r0, [r4, r3]
    ldrb r1, [r6, r2]
    cmp r0, r1
    bne loopj_inc

    mov r5, #1
    b loopj_end

loopj_inc:
    add r2, r2, #1
    b loopj_begin
loopj_end:

    cmp r5, #0
    pop {r5}
    beq retzero

    add r3, r3, #1
    b loopi_begin
loopi_end:
    mov r0, #1
    b end_function

retzero:
    mov r0, #0

end_function:
    pop {r4-r7, fp, pc}
