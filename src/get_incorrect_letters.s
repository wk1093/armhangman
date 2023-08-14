@ get_incorrect_letters.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global get_incorrect_letters
    .type get_incorrect_letters, %function
get_incorrect_letters:
    push {r4-r7, fp, lr}
    add fp, sp, #20
    sub sp, sp, #8 @ allocate space for incorrect_letters_length (align8)

    mov r5, r0 @ r5 = word
    mov r6, r2 @ r6 = guessed_letters
    mov r7, r3 @ r7 = incorrect_letters
   @ push {r1} @ save word_length
   mov r2, r1 @ r2 = word_length

   mov r0, #0
   strb r0, [sp, #-21]


    mov r4, #0 @ r4 = i
loopi_begin:
    cmp r4, #26
    bge loopi_end
    push {r7}

    mov r3, #0 @ r3 = found
    mov r7, #0 @ r7 = j
loopj_begin:
    cmp r7, r2
    bge loopj_end

    ldrb r0, [r6, r4]
    ldrb r1, [r5, r7]
    cmp r0, r1
    beq loopj_found

    add r7, r7, #1
    b loopj_begin
loopj_found:
    mov r3, #1
loopj_end:
    pop {r7}

    cmp r3, #0
    bne loopi_inc

    ldrb r0, [sp, #-21]
    add r1, r0, #1
    strb r1, [sp, #-21]

    @ it is x++ not ++x so we use r0 for the value not r1
    ldrb r1, [r6, r4]
    strb r1, [r7, r0]


loopi_inc:
    add r4, r4, #1
    b loopi_begin
loopi_end:

    add sp, sp, #8 @ deallocate space for incorrect_letters_length
    pop {r4-r7, fp, pc}
