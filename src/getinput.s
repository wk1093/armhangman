@ getinput.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global getinput
    .type getinput, %function
getinput:
    push {fp, lr}
    add fp, sp, #4
    mov r0, #0
loop_begin:
    bl getchar
    push {r0}
    @ r0 is a byte (char)
    @ isalpha(int) needs an int
    @ so we need to sign extend
    @ the byte to an int
    sxtb r0, r0
    bl isalpha
    cmp r0, #0 @ if (isalpha(key) == 0) {
    pop {r0}
    bne loop_end @     break;
    b loop_begin @ }
loop_end:

    pop {fp, pc}
