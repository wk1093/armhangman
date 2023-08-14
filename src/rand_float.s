@ rand_float.s

    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global rand_float
    .type rand_float, %function
rand_float:
    push {r4, r5, fp, lr}
    add fp, sp, #12

    bl rand

    vldr.32 s0, magic_val // magic_val = 3.0f * 2^28
    vmov s15, r0
    vcvt.f32.s32 s15, s15
    vmul.f32 s0, s15, s0

    pop {r4, r5, fp, pc}

magic_val:
    .word 805306368