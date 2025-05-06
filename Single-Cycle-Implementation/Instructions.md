
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
```
---

##  I-Type Instructions

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


Machine Code:
00a00293
ffb28313
0032f393
0042e413
0062c493
00229513
0012d593
4012d613
0142a693
fff2b713
```

---

##  B-Type Instructions (Branch)

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



Machine Code:
00a00293
00a00313
00500393
00628463
00100413
00200413
00729463
00300493
00400493
0053c463
00500513
00600513
0072d463
00700593
00800593

```

---

##  J-Type Instructions (Jump and Link)

```assembly
_start:
    addi x5, x0, 0          # Initialize x5 to 0
    jal x1, target_jal       # Jump to 'target_jal' and save PC + 4 in x1
    addi x5, x0, 1           # This instruction should be skipped (after the jump)

target_jal:
    addi x5, x0, 2           # x5 should be 2 after jumping here
    j target_j               # Jump unconditionally to target_j (without saving the return address)
    addi x6, x0, 0           # This should be skipped

target_j:
    addi x6, x0, 3           # x6 should be 3 after jumping here (J instruction without a link)
    addi x7, x0, 4           # Set x7 to 4 (for use as a return address)
    jalr x1, x7, 0           # Jump to the address in x7 (which is 4) and save the next instruction (PC + 4) in x1
    addi x6, x0, 5           # This should be skipped (after the jump to address in x7)
    addi x6, x0, 6           # x6 should be 6 after JALR jump



Machine Code:
00000293
008000ef
00100293
00200293
0080006f
00000313
00300313
00400393
000380e7
00500313
00600313
```


---

##  U-Type Instructions

```assembly
lui x5, 0x12345            # x5 = 0x12345000 (Upper Immediate)
lui x6, 0xFFFFF            # x6 = 0xFFFFF000 (Sign-extension check)

auipc x7, 0x1              # x7 = PC + 0x1000
auipc x8, 0xABCDE          # x8 = PC + 0xABCDE000


Machine Code:
123452b7
fffff337
00001397
abcde417
```

---

##  General Instructions

```assembly
main: 
addi x2, x0, 5 # x2 = 5 0 00500113
addi x3, x0, 12 # x3 = 12 4 00C00193
addi x7, x3, -9 # x7 = (12 - 9) = 3 8 FF718393
or x4, x7, x2 # x4 = (3 OR 5) = 7 C 0023E233
and x5, x3, x4 # x5 = (12 AND 7) = 4 10 0041F2B3
add x5, x5, x4 # x5 = 4 + 7 = 11 14 004282B3
beq x5, x7, end # shouldn't be taken 18 02728863
slt x4, x3, x4 # x4 = (12 < 7) = 0 1C 0041A233
beq x4, x0, around # should be taken 20 00020463
addi x5, x0, 0 # shouldn't execute 24 00000293

around: 
slt x4, x7, x2 # x4 = (3 < 5) = 1 28 0023A233
add x7, x4, x5 # x7 = (1 + 11) = 12 2C 005203B3
sub x7, x7, x2 # x7 = (12 - 5) = 7 30 402383B3
sw x7, 84(x3) # [96] = 7 34 0471AA23
lw x2, 96(x0) # x2 = [96] = 7 38 06002103
add x9, x2, x5 # x9 = (7 + 11) = 18 3C 005104B3
jal x3, end # jump to end, x3 = 0x44 40 008001EF
addi x2, x0, 1 # shouldn't execute 44 00100113

end: 
add x2, x2, x9 # x2 = (7 + 18) = 25 48
sw x2, 0x20(x3) # [100] = 25 0221A023

done: 
beq x2, x2, done # infinite loop 50 00210063


Machine Code:
00500113
00c00193
ff718393
0023e233
0041f2b3
004282b3
02728863
0041a233
00020463
00000293
0023a233
005203b3
402383b3
0471aa23
06002103
005104b3
008001ef
00100113
00910133
0221a023
00210063

```

---
