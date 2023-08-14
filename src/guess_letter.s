@ guess_letter.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global guess_letter
    .type guess_letter, %function
guess_letter:
    push {r4, r5, fp, lr}
    add fp, sp, #12

    mov r4, r0 @ r4 = guessed_letters
    mov r5, r1 @ r5 = guessed_letters_len

    ldr r0, =guess_next
    bl printf

    bl getinput
    sxtb r0, r0
    bl tolower @ this is so dumb, why does tolower not take a byte?
    
    mov r3, r0 @ r3 = guess
    mov r0, r4
    mov r1, r5
    mov r2, r3
    push {r3}
    bl str_contains
    pop {r3}
    
    cmp r0, #0
    beq guess_letter_end

    ldr r0, =already_guessed
    bl printf
    mov r0, #0
    b end

    guess_letter_end:
    mov r0, r3

end:
    pop {r4, r5, fp, pc}

    .section .rodata
    .align 2
guess_next:
    .asciz "Guess your next letter: "

already_guessed:
    .asciz "You already guessed that letter!\n\n"