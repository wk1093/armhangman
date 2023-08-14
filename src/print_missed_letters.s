@ print_missed_letters.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global print_missed_letters
    .type print_missed_letters, %function
print_missed_letters:
    push {r4, r5, fp, lr}
    add fp, sp, #12

    mov r4, r0 @ r4 = missed_letters

    ldr r0, =begin_msg
    bl printf

    mov r5, #0 @ r5 = i
loop_begin:
    cmp r5, #26
    bge loop_end

    ldr r0, [r4, r5]
    cmp r0, #0
    beq loop_inc

    bl tolower
    mov r1, r0
    ldr r0, =char_space_msg
    bl printf

loop_inc:
    add r5, r5, #1
    b loop_begin
loop_end:

    ldr r0, =newline
    bl printf

    pop {r4, r5, fp, pc}


    .section .rodata
    .align 2

begin_msg:
    .asciz "Missed letters: "
char_space_msg:
    .asciz "%c "
newline:
    .asciz "\n"
