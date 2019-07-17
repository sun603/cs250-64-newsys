.data
scf: .asciz "%d\000"
pf: .asciz "%d\n\000"
addan: .int
.text
.global main
main:
	stp x29, x30 , [sp, #-16]!
    stp x19, x20 , [sp, #-16]! // x19 - x28
    stp x21, x22 , [sp, #-16]!
	ldr x19,=0 // 4 - 9 loop count
	ldr x20,=0 // 5 - 10 sum
	ldr x21, =addan // 6 - 11
	// loop
	loop:
		ldr x0, =scf
		ldr x1, =addan
		bl scanf
        ldr x1, =addan
		ldr x2, [x1]
		add x20,x20,x2
		add x19,x19,#1
		cmp x19,#5
		blt loop
	//endloop
	ldr x0,=pf
	mov x1,x20
	bl printf
    ldp x21,x22,[sp], #16;
    ldp x19,x20,[sp], #16;
	ldp x29,x30,[sp], #16;


    ret
	
