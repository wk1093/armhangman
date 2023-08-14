#!/usr/bin/env python3
import sys

# Usage: python new.py <name> [use_extra_registers]
# Creates a new ARM assembly function/file with the given name
# if use_extra_registers is true, then the function will use r4 and r5
# use_extra_registers is true if any one argument is given after the name
def main(name, use_extra_registers):
    with open("src/"+name+".s", "w+") as f:
        if use_extra_registers:
            regs = "r4, r5, "
            num = "#12"
        else:
            regs = ""
            num = "#4"

        f.write(f"""
@ {name}.s
    .cpu cortex-a53
    .fpu neon-fp-armv8
    .syntax unified
    .text
    .align 2
    .global {name}
    .type {name}, %function
{name}:
    push {{{regs}fp, lr}}
    add fp, sp, {num}

    

    pop {{{regs}fp, pc}}
"""[1:])
    print(f"Created new file: {name}.s")


if __name__ == "__main__":
    if len(sys.argv) != 2 and len(sys.argv) != 3:
        print("Usage: python new.py <function_name>")
        exit(1)
    main(sys.argv[1], len(sys.argv) == 3)