@ get_random_word.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global get_random_word
    .type get_random_word, %function
get_random_word:
    push {r4-r7, fp, lr}
    add fp, sp, #20

    ldr r1, =read_file
    bl fopen
    cmp r0, #0
    moveq r0, #0
    beq end_get_random_word
    mov r4, r0
    
    bl get_file_size
    mov r5, r0

    mov r1, #2
    mul r0, r0, r1
    bl malloc
    mov r6, r0

    mov r0, #0
    strb r0, [r6, r5]

    mov r7, #0

loop_get_random_word:
    mov r0, r6
    mov r1, r5
    mov r2, r4
    bl fgets
    cmp r0, #0
    beq end_normal_get_random_word
    @ rand_float() < 1.0 / ++lineno
    add r7, r7, #1 @ lineno++
    bl rand_float @ s0 = rand_float()
    mov r0, r7
why:
    # move r0 (lineno) to s1
    vmov.f32 s1, r0
    @ we need to convert s1 to float
    vcvt.f32.s32 s1, s1
    @ s2 = 1.0
    vmov.f32 s2, #1.0
    @ s3 = 1.0 / s1
    vdiv.f32 s3, s2, s1
    @ s4 = s0 < s3
    vcmp.f32 s0, s3
    vmrs APSR_nzcv, fpscr
    bge loop_get_random_word

    add r0, r5, r6 @ &buffer[size]
    mov r1, r6 @ buffer
    bl strcpy

    b loop_get_random_word

end_normal_get_random_word:
    mov r0, r4
    bl fclose

    mov r0, r6
    bl end_word

    add r0, r5, r6


end_get_random_word:
    pop {r4-r7, fp, pc}

    .section .rodata
    .align 2
read_file:
    .asciz "r"