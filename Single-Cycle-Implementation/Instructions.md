
# RISC-V Instructions Implemented



##  R-Type Instructions

```assembly
li x5, 10             # Load 10 into x5
li x6, 5              # Load 5 into x6
add x7, x5, x6        # x7 = x5 + x6 = 10 + 5 = 15
sub x8, x5, x6        # x8 = x5 - x6 = 10 - 5 = 5
and x9, x5, x6        # x9 = x5 & x6 = 10 & 5 = 0
or x10, x5, x6        # x10 = x5 | x6 = 10 | 5 = 15
xor x11, x5, x6       # x11 = x5 ^ x6 = 10 ^ 5 = 15
sll x12, x5, x6       # x12 = x5 << (x6 % 32) = 10 << 5 = 320
srl x13, x5, x6       # x13 = x5 >> (x6 % 32) = 10 >> 5 = 0
sra x14, x5, x6       # x14 = arithmetic shift right 10 by 5 = 0
slt x15, x5, x6       # x15 = (10 < 5) ? 1 : 0 = 0
sltu x16, x5, x6      # Unsigned comparison (10 < 5) = 0
```
Machine Code:
00a00293
00500313
006283b3
40628433
0062f4b3
0062e533
0062c5b3
00629633
0062d6b3
4062d733
0062a7b3
0062b833
---

## ✅ I-Type Instructions

```assembly
li x5, 10             # Load 10 into x5
addi x6, x5, -5       # x6 = x5 + (-5) = 5
andi x7, x5, 3        # x7 = x5 & 3 = 10 & 3 = 2
ori x8, x5, 4         # x8 = x5 | 4 = 10 | 4 = 14
xori x9, x5, 6        # x9 = x5 ^ 6 = 10 ^ 6 = 12
slli x10, x5, 2       # x10 = x5 << 2 = 10 << 2 = 40
srli x11, x5, 1       # x11 = x5 >> 1 = 10 >> 1 = 5
srai x12, x5, 1       # x12 = signed shift 10 >> 1 = 5
slti x13, x5, 20      # x13 = (10 < 20) ? 1 : 0 = 1
sltiu x14, x5, -1     # x14 = (10 < unsigned -1) ? 1 : 0 = 1
```

---

## ✅ B-Type Instructions (Branch)

```assembly
li x5, 10
li x6, 10
li x7, 5

beq x5, x6, equal_label    # If x5 == x6, branch
li x8, 1                   # Skipped if branch taken

equal_label:
li x8, 2                   # x8 = 2 if branch taken

bne x5, x7, not_equal_label # If x5 != x7, branch
li x9, 3                    # Skipped if branch taken

not_equal_label:
li x9, 4                   # x9 = 4 if branch taken

blt x7, x5, less_label     # If x7 < x5, branch
li x10, 5                  # Skipped if branch taken

less_label:
li x10, 6                  # x10 = 6 if branch taken

bge x5, x7, greater_equal_label # If x5 >= x7, branch
li x11, 7                      # Skipped if branch taken

greater_equal_label:
li x11, 8                      # x11 = 8 if branch taken
```

---

## ✅ J-Type Instructions (Jump and Link)

```assembly
li x5, 100
j jump_label               # Unconditional jump
li x6, 200                 # Skipped

jump_label:
li x6, 300                 # x6 = 300 after jump

li x7, return_here
jal x8, subroutine         # Jump to subroutine, save return in x8

return_here:
addi x8, x8, 4             # Adjust return address
j end_of_program

subroutine:
li x9, 500
jalr x0, x7, 0             # Return to return_here

end_of_program:
```

---

## ✅ Memory Instructions

```assembly
li x5, 0x1000              # Assume memory address 0x1000
li x6, 1234
sw x6, 0(x5)               # Store word at address x5

li x7, 0xABCD
sh x7, 2(x5)               # Store half-word at x5 + 2

li x8, 0xEF
sb x8, 3(x5)               # Store byte at x5 + 3

lw x9, 0(x5)               # Load word
lh x10, 2(x5)              # Load half-word
lb x11, 3(x5)              # Load byte
lhu x12, 2(x5)             # Load unsigned half-word
lbu x13, 3(x5)             # Load unsigned byte
```

---

## ✅ U-Type Instructions

```assembly
lui x5, 0x12345            # x5 = 0x12345000 (Upper Immediate)
lui x6, 0xFFFFF            # x6 = 0xFFFFF000 (Sign-extension check)

auipc x7, 0x1              # x7 = PC + 0x1000
auipc x8, 0xABCDE          # x8 = PC + 0xABCDE000
```

---

## 📌 Notes

- `li` (load immediate) is a pseudo-instruction. It's expanded into actual instructions like `lui` and `addi`.
- Bitwise and arithmetic shifts use modulo 32 of the shift amount (`rs2` or immediate).
- The instruction flow control (`beq`, `jal`, etc.) affects which instructions are skipped or executed.
- Memory access instructions assume the memory at the given addresses is valid and aligned.
