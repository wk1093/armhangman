@ end_word.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global end_word
    .type end_word, %function
end_word:
    push {r4, r5, fp, lr}
    add fp, sp, #12

    mov r4, r0
    bl strlen

    cmp r0, #0
    beq end_word_done

    sub r2, r0, #1
    ldrb r1, [r4, r2]
    cmp r1, '\n'
    bne end_word_done

    mov r5, #0
    strb r5, [r4, r2]

end_word_done:

    pop {r4, r5, fp, pc}
