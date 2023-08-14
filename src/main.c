// Write a program that will read from a random
// word from a text file (dictionary.txt) containing English words (one word per
// line). Continue to ask the user for a letter until the user has either
// guessed all the letters in the word, or until the word H-A-N-G-M-A-N has been
// completely filled out, whichever comes first. After each guess, print out the
// letters correctly guessed and the letters in H-A-N-G-M-A-N opened as a
// consequence of missed guesses. Each time that a missed guess was made, print
// out the text “>>>>>>>>WRONG GUESS<<<<<<<<<”. Also, keep an array of letters
// already guessed and print them out at each move.

// Example:
//  In file dictionary.txt:
//  computer
//  program
//  …
//  Suppose the word “program” was randomly selected.
//  Guess your next letter >> p
//  p - - - - - -
//  - - - - - - -
//  Missed letters:
//  Guess your next letter >> g
//  p - - g - - -
//  - - - - - - -
//  Missed letters:
//  Guess your next letter >> z
//  >>>>>>>>WRONG GUESS<<<<<<<<<
//  p - - g - - -
//  H - - - - - -
//  Missed letters: z
//  Guess your next letter >>x
//  >>>>>>>>WRONG GUESS<<<<<<<<<
//  p - - g - - -
//  H A - - - - -
//  Missed letters: z x

#include <ctype.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef uint8_t byte;

byte getinput();
// {
//     byte key = getchar();
//     while (!isalpha(key)) {
//         key = getchar();
//     }
//     return key;
// }

void seed_random();
// { srand(time(NULL)); }

float rand_float();
// { return (float)rand() / (float)RAND_MAX; }

byte get_file_size(FILE *file);
// {
//     fseek(file, 0L, SEEK_END); // seek_end = 2
//     byte size = ftell(file) + 1;
//     fseek(file, 0L, SEEK_SET); // seek_set = 0
//     return size;
// }

void end_word(byte *word);
// {
//     byte length = strlen(word);
//     if (length > 0 && word[length - 1] == '\n') {
//         word[length - 1] = '\0';
//     }
// }

byte *get_random_word(const byte *filename);
// {
//     FILE *file = fopen(filename, "r");
//     if (!file) {
//         return NULL;
//     }
//     byte size = get_file_size(file);
//     byte *buffer = (byte *)malloc(size * 2);
//     buffer[size] = '\0';
//     byte lineno = 0;
//     while (fgets(buffer, size, file)) {
//         if (rand_float() < 1.0 / ++lineno) {
//             strcpy(&buffer[size], buffer);
//         }
//     }
//     fclose(file);
//     end_word(&buffer[size]);
//     return &buffer[size];
// }

byte get_word_length(const byte *word);
// {
//     byte length = 0;
//     while (word[length] != '\n' && word[length] != '\0') {
//         length++;
//     }
//     return length;
// }

void print_word(const byte *word, byte length);
// {
//     printf("The word is: ");
//     for (byte i = 0; i < length; i++) {
//         printf("%c", word[i]);
//     }
//     printf("\n");
// }

void print_hangman(byte missed_guesses);
// {
//     printf("Hangman: ");
//     const char *hm = "HANGMAN";
//     for (byte i = 0; i < 7; i++) {
//         if (i < missed_guesses) {
//             printf("%c ", hm[i]);
//         } else {
//             printf("- ");
//         }
//     }
//     printf("\n");
// }

void print_missed_letters(const byte *missed_letters);
// {
//     printf("Missed letters: ");
//     for (byte i = 0; i < 26; i++) {
//         if (missed_letters[i] == '\0')
//             continue; // skip null bytes
//         printf("%c ", tolower(missed_letters[i]));
//     }
//     printf("\n");
// }

void print_word_state(const byte *word, byte length,
                      const byte *guessed_letters, byte guessed_letters_length);
// {
//     printf("guessed: ");
//     for (byte i = 0; i < length; i++) {
//         byte found = 0;
//         for (byte j = 0; j < guessed_letters_length; j++) {
//             if (word[i] == guessed_letters[j]) {
//                 found = 1;
//                 break;
//             }
//         }
//         if (found) {
//             printf("%c ", word[i]);
//         } else {
//             printf("- ");
//         }
//     }
//     printf("\n");
// }

byte is_word_complete(const byte *word, byte length,
                      const byte *guessed_letters, byte guessed_letters_length);
// {
//     for (byte i = 0; i < length; i++) {
//         byte found = 0;
//         for (byte j = 0; j < guessed_letters_length; j++) {
//             if (word[i] == guessed_letters[j]) {
//                 found = 1;
//                 break;
//             }
//         }
//         if (!found) {
//             return 0;
//         }
//     }
//     return 1;
// }

byte is_game_over(byte missed_guesses);
// { return missed_guesses == 7; }

byte str_contains(const byte *word, byte length, byte guess);
// {
//     for (byte i = 0; i < length; i++) {
//         if (word[i] == guess) {
//             return 1;
//         }
//     }
//     return 0;
// }

void get_incorrect_letters(const byte *word, byte word_length,
                           const byte *guessed_letters,
                           byte *incorrect_letters);
// {
//     byte incorrect_letters_length = 0;
//     for (byte i = 0; i < 26; i++) {
//         byte found = 0;
//         for (byte j = 0; j < word_length; j++) {
//             if (guessed_letters[i] == word[j]) {
//                 found = 1;
//                 break;
//             }
//         }
//         if (!found) {
//             incorrect_letters[incorrect_letters_length++] =
//             guessed_letters[i];
//         }
//     }
// }

byte guess_letter(byte *guessed_letters, byte guessed_letters_length);
// {
//     printf("Guess your next letter: ");
//     byte guess = tolower(getinput());
//     if (str_contains(guessed_letters, guessed_letters_length, guess)) {
//         printf("You already guessed that letter!\n\n");
//         return 0;
//     }
//     return guess;
// }

void play_hangman(const byte *word, byte length) {
    byte missed_guesses = 0;
    byte *guessed_letters = (byte *)calloc(26 * 2, 1);
    byte guessed_letters_length = 0;
    while (1) {
        print_word_state(word, length, guessed_letters, guessed_letters_length);
        print_hangman(missed_guesses);
        get_incorrect_letters(word, length, guessed_letters,
                              &guessed_letters[26]);
        print_missed_letters(&guessed_letters[26]);

        byte guess = guess_letter(guessed_letters, guessed_letters_length);
        guessed_letters[guessed_letters_length++] = guess;
        if (!guess) {
            continue;
        }

        if (str_contains(word, length, guess)) {
            printf("Correct!\n\n");
        } else {
            printf("Incorrect!\n\n");
            missed_guesses++;
        }

        if (is_word_complete(word, length, guessed_letters,
                             guessed_letters_length)) {
            printf("You win!\n");
            break;
        }

        if (is_game_over(missed_guesses)) {
            printf("You lose!\n");
            break;
        }
    }
}

void lowercase(byte *word) {
    byte length = get_word_length(word);
    for (byte i = 0; i < length; i++) {
        word[i] = tolower(word[i]);
    }
}

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("Usage: %s <wordlist>\n", argv[0]);
        return 1;
    }
    seed_random();
    byte *word = get_random_word(argv[1]);
    lowercase(word);
    byte length = get_word_length(word);
    print_word(word, length);
    play_hangman(word, length);
    return 0;
}