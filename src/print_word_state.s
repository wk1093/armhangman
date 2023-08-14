@ print_word_state.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global print_word_state
    .type print_word_state, %function
print_word_state:
    push {r4-r7, fp, lr}
    add fp, sp, #20

    mov r4, r0 @ r4 = word
    mov r5, r1 @ r5 = length
    mov r6, r2 @ r6 = guessed_letters
    mov r7, r3 @ r7 = guessed_letters_length

    ldr r0, =guessed_msg
    bl printf

    @ for (i = 0; i < length; i++)
    mov r3, #0 @ r3 = i
loopi_begin:
    cmp r3, r5
    bge loopi_end
    push {r5} @ r5 is usable in loop

    mov r5, #0 @ r5 = found
    mov r2, #0 @ r2 = j
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
    bne if_found

    ldr r0, =dash_space
    b print_output

if_found:
    ldr r0, =char_space
    ldrb r1, [r4, r3]

print_output:
    push {r3}
    bl printf
    pop {r3}


    pop {r5}
    add r3, r3, #1
    b loopi_begin
loopi_end:

    ldr r0, =newline
    bl printf

    pop {r4-r7, fp, pc}


    .section .rodata
    .align 2

guessed_msg:
    .asciz "guessed: "
dash_space:
    .asciz "- "
char_space:
    .asciz "%c "
newline:
    .asciz "\n"
