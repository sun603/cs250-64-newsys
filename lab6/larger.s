.data
x: .word 0
y: .word 0
scf: .asciz "%d\000"
pf: .asciz "%d\n\000"

.text

.global  main

main:
/* scanf twice to take the input */
stp x29, x30 , [sp, #-16]!
ldr x0, =scf
ldr x1, =x
bl scanf
ldr x0, =scf
ldr x1, =y
bl scanf
/* load from memeory back to reg */
/*
 * armv7
 * ldr x1, =x
 * ldr x1, [x1]
 */
ldr x1, x
ldr x2, y
/* cmp */
cmp x2, x1
blt noch
mov x1, x2
noch:
ldr x0, =pf
bl printf

ldp x29,x30,[sp], #16;
ret
