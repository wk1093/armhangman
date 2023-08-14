	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.global	get_file_size
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	get_file_size, %function
get_file_size:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r2, #2
	mov	r5, r0
	mov	r1, #0
	bl	fseek
	mov	r0, r5
	bl	ftell
	mov	r2, #0
	mov	r1, r2
	mov	r4, r0
	mov	r0, r5
	bl	fseek
	add	r0, r4, #1
	uxtb	r0, r0
	pop	{r4, r5, r6, pc}
	.size	get_file_size, .-get_file_size
	.align	2
	.global	end_word
	.syntax unified
	.arm
	.fpu vfp
	.type	end_word, %function
end_word:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r4, r0
	bl	strlen
	ands	r3, r0, #255
	popeq	{r4, pc}
	sub	r3, r3, #1
	ldrb	r2, [r4, r3]	@ zero_extendqisi2
	cmp	r2, #10
	moveq	r2, #0
	strbeq	r2, [r4, r3]
	pop	{r4, pc}
	.size	end_word, .-end_word
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"r\000"
	.text
	.align	2
	.global	get_random_word
	.syntax unified
	.arm
	.fpu vfp
	.type	get_random_word, %function
get_random_word:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	vpush.64	{d8}
	ldr	r1, .L23+8
	bl	fopen
	subs	r6, r0, #0
	moveq	r8, r6
	beq	.L10
	mov	r2, #2
	mov	r1, #0
	bl	fseek
	mov	r0, r6
	bl	ftell
	mov	r2, #0
	mov	r1, r2
	vldr.64	d8, .L23
	mov	r4, #0
	add	r0, r0, #1
	uxtb	r5, r0
	mov	r0, r6
	bl	fseek
	lsl	r0, r5, #1
	bl	malloc
	mov	r7, r0
	add	r8, r0, r5
	strb	r4, [r0, r5]
.L12:
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	fgets
	subs	r9, r0, #0
	beq	.L22
	add	r4, r4, #1
	bl	rand_float
	uxtb	r4, r4
	vmov	s15, r4	@ int
	vcvt.f64.s32	d6, s15
	vdiv.f64	d7, d8, d6
	vcvt.f64.f32	d0, s0
	vcmpe.f64	d0, d7
	vmrs	APSR_nzcv, FPSCR
	bpl	.L12
	mov	r1, r7
	mov	r0, r8
	bl	strcpy
	b	.L12
.L22:
	mov	r0, r6
	bl	fclose
	mov	r0, r8
	bl	strlen
	ands	r0, r0, #255
	beq	.L10
	sub	r0, r0, #1
	ldrb	r3, [r8, r0]	@ zero_extendqisi2
	cmp	r3, #10
	strbeq	r9, [r8, r0]
.L10:
	vldm	sp!, {d8}
	mov	r0, r8
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L24:
	.align	3
.L23:
	.word	0
	.word	1072693248
	.word	.LC0
	.size	get_random_word, .-get_random_word
	.align	2
	.global	get_word_length
	.syntax unified
	.arm
	.fpu vfp
	.type	get_word_length, %function
get_word_length:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrb	r3, [r0]	@ zero_extendqisi2
	mov	r2, r0
	cmp	r3, #10
	cmpne	r3, #0
	movne	r3, #1
	moveq	r3, #0
	beq	.L28
	mov	r0, #0
.L27:
	add	r0, r0, #1
	uxtb	r0, r0
	ldrb	r3, [r2, r0]	@ zero_extendqisi2
	cmp	r3, #10
	cmpne	r3, #0
	bne	.L27
	bx	lr
.L28:
	mov	r0, r3
	bx	lr
	.size	get_word_length, .-get_word_length
	.section	.rodata.str1.4
	.align	2
.LC1:
	.ascii	"The word is: \000"
	.text
	.align	2
	.global	print_word
	.syntax unified
	.arm
	.fpu vfp
	.type	print_word, %function
print_word:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r4, r1
	mov	r5, r0
	ldr	r0, .L39
	bl	printf
	cmp	r4, #0
	beq	.L32
	sub	r1, r4, #1
	sub	r4, r5, #1
	uxtab	r5, r5, r1
.L33:
	ldrb	r0, [r4, #1]!	@ zero_extendqisi2
	bl	putchar
	cmp	r4, r5
	bne	.L33
.L32:
	pop	{r4, r5, r6, lr}
	mov	r0, #10
	b	putchar
.L40:
	.align	2
.L39:
	.word	.LC1
	.size	print_word, .-print_word
	.section	.rodata.str1.4
	.align	2
.LC2:
	.ascii	"Hangman: \000"
	.align	2
.LC3:
	.ascii	"HANGMAN\000"
	.align	2
.LC4:
	.ascii	"%c \000"
	.align	2
.LC5:
	.ascii	"- \000"
	.text
	.align	2
	.global	print_hangman
	.syntax unified
	.arm
	.fpu vfp
	.type	print_hangman, %function
print_hangman:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	mov	r6, r0
	ldr	r0, .L49
	bl	printf
	ldr	r5, .L49+4
	ldr	r7, .L49+8
	ldr	r8, .L49+12
	mov	r4, #0
	b	.L44
.L48:
	ldrb	r1, [r5]	@ zero_extendqisi2
	mov	r0, r8
	add	r4, r4, #1
	bl	printf
	cmp	r4, #7
	add	r5, r5, #1
	beq	.L47
.L44:
	uxtb	r3, r4
	cmp	r6, r3
	mov	r0, r7
	bhi	.L48
	add	r4, r4, #1
	bl	printf
	cmp	r4, #7
	add	r5, r5, #1
	bne	.L44
.L47:
	pop	{r4, r5, r6, r7, r8, lr}
	mov	r0, #10
	b	putchar
.L50:
	.align	2
.L49:
	.word	.LC2
	.word	.LC3
	.word	.LC5
	.word	.LC4
	.size	print_hangman, .-print_hangman
	.section	.rodata.str1.4
	.align	2
.LC6:
	.ascii	"Missed letters: \000"
	.text
	.align	2
	.global	print_missed_letters
	.syntax unified
	.arm
	.fpu vfp
	.type	print_missed_letters, %function
print_missed_letters:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	mov	r6, r0
	ldr	r0, .L59
	bl	printf
	ldr	r7, .L59+4
	sub	r4, r6, #1
	add	r6, r6, #25
.L53:
	ldrb	r5, [r4, #1]!	@ zero_extendqisi2
	cmp	r5, #0
	beq	.L52
	bl	__ctype_tolower_loc
	mov	r3, r0
	mov	r0, r7
	ldr	r3, [r3]
	ldr	r1, [r3, r5, lsl #2]
	bl	printf
.L52:
	cmp	r6, r4
	bne	.L53
	pop	{r4, r5, r6, r7, r8, lr}
	mov	r0, #10
	b	putchar
.L60:
	.align	2
.L59:
	.word	.LC6
	.word	.LC4
	.size	print_missed_letters, .-print_missed_letters
	.section	.rodata.str1.4
	.align	2
.LC7:
	.ascii	"guessed: \000"
	.text
	.align	2
	.global	print_word_state
	.syntax unified
	.arm
	.fpu vfp
	.type	print_word_state, %function
print_word_state:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r5, r1
	mov	r10, r0
	ldr	r0, .L75
	mov	r4, r2
	mov	r6, r3
	bl	printf
	cmp	r5, #0
	beq	.L62
	sub	r5, r5, #1
	add	r3, r10, #1
	uxtab	r5, r3, r5
	ldr	r9, .L75+4
	ldr	r8, .L75+8
	sub	r7, r6, #1
.L63:
	cmp	r6, #0
	beq	.L66
	ldrb	r1, [r10]	@ zero_extendqisi2
	uxtab	r3, r4, r7
	sub	ip, r4, #1
	b	.L65
.L74:
	cmp	ip, r3
	beq	.L66
.L65:
	ldrb	lr, [ip, #1]!	@ zero_extendqisi2
	cmp	lr, r1
	bne	.L74
	mov	r0, r8
	bl	printf
.L68:
	add	r10, r10, #1
	cmp	r10, r5
	bne	.L63
.L62:
	pop	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r0, #10
	b	putchar
.L66:
	mov	r0, r9
	bl	printf
	b	.L68
.L76:
	.align	2
.L75:
	.word	.LC7
	.word	.LC5
	.word	.LC4
	.size	print_word_state, .-print_word_state
	.align	2
	.global	is_word_complete
	.syntax unified
	.arm
	.fpu vfp
	.type	is_word_complete, %function
is_word_complete:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r1, #0
	beq	.L91
	push	{r4, r5, lr}
	sub	r1, r1, #1
	sub	lr, r3, #1
	uxtab	r5, r0, r1
	uxtab	lr, r2, lr
	sub	r4, r0, #1
.L83:
	cmp	r3, #0
	beq	.L90
	ldrb	ip, [r4, #1]!	@ zero_extendqisi2
	sub	r1, r2, #1
	b	.L81
.L92:
	cmp	r1, lr
	beq	.L90
.L81:
	ldrb	r0, [r1, #1]!	@ zero_extendqisi2
	cmp	r0, ip
	bne	.L92
	cmp	r4, r5
	bne	.L83
	mov	r0, #1
	pop	{r4, r5, pc}
.L90:
	mov	r0, #0
	pop	{r4, r5, pc}
.L91:
	mov	r0, #1
	bx	lr
	.size	is_word_complete, .-is_word_complete
	.align	2
	.global	is_game_over
	.syntax unified
	.arm
	.fpu vfp
	.type	is_game_over, %function
is_game_over:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	r0, r0, #7
	clz	r0, r0
	lsr	r0, r0, #5
	bx	lr
	.size	is_game_over, .-is_game_over
	.align	2
	.global	is_guess_correct
	.syntax unified
	.arm
	.fpu vfp
	.type	is_guess_correct, %function
is_guess_correct:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r1, #0
	beq	.L100
	sub	r1, r1, #1
	sub	r3, r0, #1
	uxtab	r0, r0, r1
	b	.L96
.L101:
	cmp	r3, r0
	beq	.L100
.L96:
	ldrb	r1, [r3, #1]!	@ zero_extendqisi2
	cmp	r1, r2
	bne	.L101
	mov	r0, #1
	bx	lr
.L100:
	mov	r0, #0
	bx	lr
	.size	is_guess_correct, .-is_guess_correct
	.align	2
	.global	is_guess_already_made
	.syntax unified
	.arm
	.fpu vfp
	.type	is_guess_already_made, %function
is_guess_already_made:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r1, #0
	beq	.L108
	sub	r1, r1, #1
	sub	r3, r0, #1
	uxtab	r0, r0, r1
	b	.L104
.L109:
	cmp	r3, r0
	beq	.L108
.L104:
	ldrb	r1, [r3, #1]!	@ zero_extendqisi2
	cmp	r1, r2
	bne	.L109
	mov	r0, #1
	bx	lr
.L108:
	mov	r0, #0
	bx	lr
	.size	is_guess_already_made, .-is_guess_already_made
	.align	2
	.global	get_incorrect_letters
	.syntax unified
	.arm
	.fpu vfp
	.type	get_incorrect_letters, %function
get_incorrect_letters:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r5, r1
	add	r4, r2, #25
	sub	r1, r2, #1
	sub	r2, r5, #1
	mov	r6, r0
	cmp	r5, #0
	mov	r7, r3
	ldrb	lr, [r1, #1]!	@ zero_extendqisi2
	uxtab	r3, r0, r2
	mov	r0, #0
	subne	r2, r6, #1
	bne	.L113
	b	.L114
.L119:
	cmp	r2, r3
	beq	.L114
.L113:
	ldrb	ip, [r2, #1]!	@ zero_extendqisi2
	cmp	ip, lr
	bne	.L119
	cmp	r1, r4
	popeq	{r4, r5, r6, r7, pc}
.L120:
	cmp	r5, #0
	ldrb	lr, [r1, #1]!	@ zero_extendqisi2
	subne	r2, r6, #1
	bne	.L113
.L114:
	add	r2, r0, #1
	cmp	r1, r4
	strb	lr, [r7, r0]
	uxtb	r0, r2
	bne	.L120
	pop	{r4, r5, r6, r7, pc}
	.size	get_incorrect_letters, .-get_incorrect_letters
	.section	.rodata.str1.4
	.align	2
.LC8:
	.ascii	"Guess your next letter: \000"
	.align	2
.LC9:
	.ascii	"You already guessed that letter!\012\000"
	.text
	.align	2
	.global	guess_letter
	.syntax unified
	.arm
	.fpu vfp
	.type	guess_letter, %function
guess_letter:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r5, r0
	ldr	r0, .L133
	mov	r4, r1
	bl	printf
	bl	__ctype_tolower_loc
	ldr	r6, [r0]
	bl	getinput
	cmp	r4, #0
	sxth	r0, r0
	ldrb	r0, [r6, r0, lsl #2]	@ zero_extendqisi2
	popeq	{r4, r5, r6, pc}
	sub	r4, r4, #1
	sub	r3, r5, #1
	uxtab	r1, r5, r4
	b	.L124
.L132:
	cmp	r3, r1
	popeq	{r4, r5, r6, pc}
.L124:
	ldrb	r2, [r3, #1]!	@ zero_extendqisi2
	cmp	r2, r0
	bne	.L132
	ldr	r0, .L133+4
	bl	puts
	mov	r0, #0
	pop	{r4, r5, r6, pc}
.L134:
	.align	2
.L133:
	.word	.LC8
	.word	.LC9
	.size	guess_letter, .-guess_letter
	.section	.rodata.str1.4
	.align	2
.LC10:
	.ascii	"You lose!\000"
	.align	2
.LC11:
	.ascii	"You win!\000"
	.align	2
.LC12:
	.ascii	"Correct!\012\000"
	.align	2
.LC13:
	.ascii	"Incorrect!\012\000"
	.text
	.align	2
	.global	play_hangman
	.syntax unified
	.arm
	.fpu vfp
	.type	play_hangman, %function
play_hangman:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r6, r0
	sub	sp, sp, #44
	mov	r4, r1
	mov	r0, #52
	mov	r1, #1
	bl	calloc
	mov	r8, #0
	str	r8, [sp, #16]
	ldr	r5, .L208
	mov	r7, r0
	str	r0, [sp, #4]
	bl	__ctype_tolower_loc
	sub	r3, r7, #1
	str	r3, [sp, #12]
	mov	r3, r7
	str	r8, [sp, #20]
	add	r7, r7, #25
	add	r8, r3, #51
	mov	r9, r0
.L136:
	ldr	r0, .L208+4
	bl	printf
	ldrb	r3, [sp, #16]	@ zero_extendqisi2
	cmp	r4, #0
	str	r3, [sp, #8]
	beq	.L137
	sub	r10, r4, #1
	str	r4, [sp, #32]
	mov	r4, r3
	mov	fp, r6
	sub	r2, r3, #1
	cmp	r4, #0
	uxtab	r10, r6, r10
	str	r9, [sp, #24]
	str	r6, [sp, #28]
	str	r7, [sp, #36]
	ldr	r6, [sp, #4]
	mov	r7, fp
	ldr	r9, [sp, #12]
	mov	fp, r2
	beq	.L141
.L142:
	ldrb	r1, [r7]	@ zero_extendqisi2
	uxtab	ip, r6, fp
	mov	r3, r9
	b	.L140
.L198:
	cmp	r3, ip
	beq	.L141
.L140:
	ldrb	r2, [r3, #1]!	@ zero_extendqisi2
	cmp	r2, r1
	bne	.L198
	mov	r0, r5
	bl	printf
	cmp	r7, r10
	add	r2, r7, #1
	beq	.L194
.L199:
	cmp	r4, #0
	mov	r7, r2
	bne	.L142
.L141:
	ldr	r0, .L208+8
	bl	printf
	cmp	r7, r10
	add	r2, r7, #1
	bne	.L199
.L194:
	ldr	r9, [sp, #24]
	ldr	r6, [sp, #28]
	ldr	r4, [sp, #32]
	ldr	r7, [sp, #36]
.L137:
	ldr	fp, .L208+12
	mov	r0, #10
	bl	putchar
	ldr	r0, .L208+16
	bl	printf
	mov	r10, #0
	str	r4, [sp, #24]
	mov	r4, fp
	ldr	fp, [sp, #20]
	b	.L145
.L201:
	ldrb	r1, [r4]	@ zero_extendqisi2
	mov	r0, r5
	add	r10, r10, #1
	bl	printf
	cmp	r10, #7
	add	r4, r4, #1
	beq	.L200
.L145:
	uxtb	r2, r10
	cmp	fp, r2
	ldr	r0, .L208+8
	bhi	.L201
	add	r10, r10, #1
	bl	printf
	cmp	r10, #7
	add	r4, r4, #1
	bne	.L145
.L200:
	ldr	r4, [sp, #24]
	mov	r0, #10
	bl	putchar
	sub	r0, r4, #1
	ldr	ip, [sp, #12]
	uxtab	r0, r6, r0
	ldr	r10, [sp, #4]
	mov	lr, #0
.L146:
	cmp	r4, #0
	ldrb	r1, [ip, #1]!	@ zero_extendqisi2
	subne	r3, r6, #1
	bne	.L148
	b	.L149
.L202:
	cmp	r0, r3
	beq	.L149
.L148:
	ldrb	r2, [r3, #1]!	@ zero_extendqisi2
	cmp	r2, r1
	bne	.L202
	cmp	ip, r7
	bne	.L146
.L150:
	ldr	r0, .L208+20
	bl	printf
	mov	r10, r7
.L153:
	ldrb	r3, [r10, #1]!	@ zero_extendqisi2
	mov	r0, r5
	cmp	r3, #0
	beq	.L152
	ldr	r2, [r9]
	ldr	r1, [r2, r3, lsl #2]
	bl	printf
.L152:
	cmp	r8, r10
	bne	.L153
	mov	r0, #10
	bl	putchar
	ldr	r0, .L208+24
	bl	printf
	ldr	r10, [r9]
	bl	getinput
	ldr	r3, [sp, #8]
	cmp	r3, #0
	sxth	r0, r0
	ldrb	r1, [r10, r0, lsl #2]	@ zero_extendqisi2
	beq	.L154
	sub	r0, r3, #1
	ldr	r3, [sp, #4]
	uxtab	r0, r3, r0
	ldr	r3, [sp, #12]
	b	.L156
.L203:
	cmp	r3, r0
	beq	.L154
.L156:
	ldrb	r2, [r3, #1]!	@ zero_extendqisi2
	cmp	r2, r1
	bne	.L203
	ldr	r0, .L208+28
	bl	puts
	ldr	r2, [sp, #4]
	ldr	r1, [sp, #8]
	mov	r3, #0
	strb	r3, [r2, r1]
.L168:
	ldr	r3, [sp, #16]
	add	r3, r3, #1
	str	r3, [sp, #16]
	b	.L136
.L149:
	add	r3, r10, lr
	add	lr, lr, #1
	cmp	ip, r7
	uxtb	lr, lr
	strb	r1, [r3, #26]
	bne	.L146
	b	.L150
.L154:
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #8]
	cmp	r1, #0
	strb	r1, [r3, r2]
	beq	.L168
	cmp	r4, #0
	beq	.L204
	sub	r0, r4, #1
	sub	r10, r6, #1
	uxtab	r0, r6, r0
	mov	r3, r10
	b	.L158
.L206:
	cmp	r0, r3
	beq	.L205
.L158:
	ldrb	r2, [r3, #1]!	@ zero_extendqisi2
	cmp	r2, r1
	bne	.L206
	ldr	r0, .L208+32
	bl	puts
.L169:
	mov	lr, r10
	ldmib	sp, {r3, r10}
	ldr	fp, [sp, #12]
	mov	ip, #0
	add	r0, r3, r10
.L165:
	cmp	r10, #255
	beq	.L162
	ldrb	r1, [lr, #1]!	@ zero_extendqisi2
	mov	r3, fp
	b	.L161
.L207:
	cmp	r0, r3
	beq	.L162
.L161:
	ldrb	r2, [r3, #1]!	@ zero_extendqisi2
	cmp	r2, r1
	bne	.L207
	add	ip, ip, #1
	uxtb	r3, ip
	cmp	r4, r3
	bhi	.L165
.L166:
	ldr	r0, .L208+36
	add	sp, sp, #44
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	b	puts
.L162:
	ldr	r3, [sp, #20]
	cmp	r3, #7
	bne	.L168
	ldr	r0, .L208+40
	add	sp, sp, #44
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	b	puts
.L205:
	ldr	r0, .L208+44
	bl	puts
	ldr	r3, [sp, #20]
	add	r3, r3, #1
	uxtb	r3, r3
	str	r3, [sp, #20]
	b	.L169
.L204:
	ldr	r0, .L208+44
	bl	puts
	b	.L166
.L209:
	.align	2
.L208:
	.word	.LC4
	.word	.LC7
	.word	.LC5
	.word	.LC3
	.word	.LC2
	.word	.LC6
	.word	.LC8
	.word	.LC9
	.word	.LC12
	.word	.LC11
	.word	.LC10
	.word	.LC13
	.size	play_hangman, .-play_hangman
	.align	2
	.global	lowercase
	.syntax unified
	.arm
	.fpu vfp
	.type	lowercase, %function
lowercase:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #10
	cmpne	r3, #0
	bxeq	lr
	push	{r4, r5, r6, lr}
	mov	r3, #0
	mov	r4, r0
.L212:
	add	r2, r3, #1
	mov	r5, r3
	uxtb	r3, r2
	ldrb	r2, [r4, r3]	@ zero_extendqisi2
	cmp	r2, #10
	cmpne	r2, #0
	bne	.L212
	cmp	r3, #0
	popeq	{r4, r5, r6, pc}
	bl	__ctype_tolower_loc
	sub	r3, r4, #1
	add	r4, r4, r5
.L214:
	ldrb	r1, [r3, #1]!	@ zero_extendqisi2
	ldr	r2, [r0]
	cmp	r4, r3
	ldr	r2, [r2, r1, lsl #2]
	strb	r2, [r3]
	bne	.L214
	pop	{r4, r5, r6, pc}
	.size	lowercase, .-lowercase
	.section	.rodata.str1.4
	.align	2
.LC14:
	.ascii	"Usage: %s <wordlist>\012\000"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #2
	push	{r4, r5, r6, lr}
	mov	r4, r1
	beq	.L228
	ldr	r1, [r1]
	ldr	r0, .L235
	bl	printf
	mov	r0, #1
	pop	{r4, r5, r6, pc}
.L228:
	bl	seed_random
	ldr	r0, [r4, #4]
	bl	get_random_word
	mov	r5, r0
	bl	lowercase
	ldrb	r4, [r5]	@ zero_extendqisi2
	cmp	r4, #10
	cmpne	r4, #0
	movne	r4, #1
	moveq	r4, #0
	beq	.L230
	mov	r4, #0
.L231:
	add	r4, r4, #1
	uxtb	r4, r4
	ldrb	r3, [r5, r4]	@ zero_extendqisi2
	cmp	r3, #10
	cmpne	r3, #0
	bne	.L231
.L230:
	mov	r1, r4
	mov	r0, r5
	bl	print_word
	mov	r0, r5
	mov	r1, r4
	bl	play_hangman
	mov	r0, #0
	pop	{r4, r5, r6, pc}
.L236:
	.align	2
.L235:
	.word	.LC14
	.size	main, .-main
	.ident	"GCC: (Raspbian 10.2.1-6+rpi1) 10.2.1 20210110"
	.section	.note.GNU-stack,"",%progbits
