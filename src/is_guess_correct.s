@ is_guess_correct.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global is_guess_correct
    .type is_guess_correct, %function
is_guess_correct:
    push {r4, r5, fp, lr}
    add fp, sp, #12

    mov r4, r0 @ r4 = word
    mov r5, r2 @ r5 = guess
    
    @ remember r1 = word_length

    mov r3, #0 @ r3 = i
loop_begin:
    cmp r3, r1
    bge loop_end

    ldrb r0, [r4, r3] @ r0 = word[i]
    cmp r0, r5 @ word[i] == guess

    beq cond_true

    add r3, r3, #1 @ i++
    b loop_begin
loop_end:
    mov r0, #0 @ return false
    b end

cond_true:
    mov r0, #1 @ return true

end:
    pop {r4, r5, fp, pc}
