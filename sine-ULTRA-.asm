.include "ultra64.inc"
.include "sm64.inc"

.macro REG8 reg
.word REG_BASE + (reg << 2)
.endm

.macro REG16 reg
.word REG_BASE + (reg << 3)
.endm

.macro REG32 reg
.word REG_BASE + (reg << 4)
.endm

.macro MOV8 dest, src
li t0, src
sw t0, dest
.endm

.macro MOV16 dest, src
li t0, src
sw t0, dest
.endm

.macro MOV32 dest, src
li t0, src
sw t0, dest
.endm

.macro LWC1 fdest, src
lwc1 fdest, src
.endm

.macro SWC1 fsrc, dest
swc1 fsrc, dest
.endm

.macro MTC1 fsrc, frt
mtc1 fsrc, frt
.endm

.macro MFC1 frt, fdest
mfc1 fdest, frt
.endm

.macro JAL label
jal label
nop
.endm

.macro RET
jr ra
nop
.endm

.data

.align 2

level_data:
.space 32768

.text

main:

# Load the level data into memory.
lwc1 f12, level_data

# Calculate the sine and cosine of the angle.
MTC1 f12, frt
lfs f0, .LC0
lfs f1, .LC1
mul.s f0, f0, f12
mul.s f1, f1, f12

# Generate the X and Y coordinates of the vertices.
add.s f2, f0, f1
sub.s f3, f0, f1

# Draw the vertices.
MOV32 r0, 0
MOV32 r1, SCREEN_WIDTH
MOV32 r2, SCREEN_HEIGHT
MOV32 r3, 0
JAL draw_triangle

# Exit the program.
RET

.LC0:
.float 0.8660254

.LC1:
.float 0.5

.endasm
```
