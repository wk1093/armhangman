@ print_word.s
    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global print_word
    .type print_word, %function
print_word:
    push {r4, r5, fp, lr}
    add fp, sp, #12

    mov r4, r0 @ r4 = word
    mov r5, r1 @ r5 = length

    ldr r0, =wordis_msg
    bl printf

    mov r3, #0
loop_begin:
    cmp r3, r5
    beq loop_end
    ldrb r0, [r4, r3]
    push {r3}
    bl putchar
    pop {r3}
    add r3, r3, #1
    b loop_begin
loop_end:
    ldr r0, =newline_msg
    bl printf

    pop {r4, r5, fp, pc}

    .section .rodata
    .align 2
wordis_msg:
    .asciz "The word is: "
newline_msg:
    .asciz "\n"
