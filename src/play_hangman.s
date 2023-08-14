@ play_hangman.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global play_hangman
    .type play_hangman, %function
play_hangman:
    push {r4-r7, fp, lr}
    add fp, sp, #20
    sub sp, sp, #8 @ allocate 8 bytes for local variables (align 8)

    mov r7, r0 @ r7 = word
    mov r6, r1 @ r6 = word_len
    mov r0, #0
    strb r0, [fp, #-21] @ -21 = missed_guesses
    strb r0, [fp, #-22] @ -22 = guessed_letters_length
    @ 26*2=52
    mov r0, #52
    mov r1, #1
    bl calloc
    mov r5, r0 @ r5 = guessed_letters

begin_loop:
    @ print_word_state(word, length, guessed_letters, guessed_letters_length);
    mov r0, r7
    mov r1, r6
    mov r2, r5
    ldrb r3, [fp, #-22]
    bl print_word_state
    @ print_hangman(missed_guesses);
    ldrb r0, [fp, #-21]
    bl print_hangman
    @ get_incorrect_letters(word, length, guessed_letters, &guessed_letters[26]);
    mov r0, r7
    mov r1, r6
    mov r2, r5
    add r3, r5, #26
    bl get_incorrect_letters
    @ print_incorrect_letters(&guessed_letters[26]);
    add r0, r5, #26
    bl print_missed_letters

    @ byte guess = guess_letter(guessed_letters, guessed_letters_length);
    mov r0, r5
    ldrb r1, [fp, #-22]
    bl guess_letter
    mov r4, r0 @ r4 = guess
    
    @ guessed_letters[guessed_letters_length++] = guess;
    ldrb r0, [fp, #-22]
    add r1, r0, #1
    strb r1, [fp, #-22]
    strb r4, [r5, r0]

    cmp r4, #0
    beq begin_loop

    @ if (str_contains(word, length, guess)) {
    @     printf("Correct!\n\n");
    @ } else {
    @     printf("Incorrect!\n\n");
    @     missed_guesses++;
    @ }
    mov r0, r7
    mov r1, r6
    mov r2, r4
    bl str_contains
    cmp r0, #0
    beq incorrect
    @ printf("Correct!\n\n");
    ldr r0, =correct_str
    bl printf
    b after_correct
incorrect:
    @ printf("Incorrect!\n\n");
    ldr r0, =incorrect_str
    bl printf
    @ missed_guesses++;
    ldrb r0, [fp, #-21]
    add r0, r0, #1
    strb r0, [fp, #-21]
after_correct:

    @ if (is_word_complete(word, length, guessed_letters,
    @                      guessed_letters_length)) {
    @     printf("You win!\n");
    @     break;
    @ }
    mov r0, r7
    mov r1, r6
    mov r2, r5
    ldrb r3, [fp, #-22]
    boksoid:
    bl is_word_complete
    cmp r0, #0
    bne you_win

    @ if (is_game_over(missed_guesses)) {
    @     printf("You lose!\n");
    @     break;
    @ }
    ldrb r0, [fp, #-21]
    bl is_game_over
    cmp r0, #0
    bne you_lose


    b begin_loop
end_loop:

you_win:
    ldr r0, =you_win_str
    bl printf
    b end

you_lose:
    ldr r0, =you_lose_str
    bl printf
    
end:
    add sp, sp, #8
    pop {r4-r7, fp, pc}

    .section .rodata
    .align 2
correct_str:
    .asciz "Correct!\n\n"
incorrect_str:
    .asciz "Incorrect!\n\n"
you_win_str:
    .asciz "You win!\n"
you_lose_str:
    .asciz "You lose!\n"