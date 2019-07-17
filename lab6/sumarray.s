.data
scf: .asciz "%d\000"
pf: .asciz "%d\n\000"
addan: .int
.text
.global main
main:
	stp x29, x30 , [sp, #-16]!
    //stp x19, x20 , [sp, #-16]! // x19 - x28
    //stp x21, x22 , [sp, #-16]!
	ldr x9,=0 // 4 - 9 loop count
	ldr x10,=0 // 5 - 10 sum
	ldr x11, =addan // 6 - 11
	// loop
	loop:
		ldr x0, =scf
		ldr x1, =addan
        stp x9, x10 , [sp, #-16]!
        stp x11, x12, [sp, #-16]!
		bl scanf
        ldr x1, =addan
		ldr x2, [x1]
        ldp x11, x12, [sp], #16
        ldp x9, x10, [sp], #16
		add x10,x10,x2
		add x9,x9,#1
		cmp x9,#5
		blt loop
	//endloop
	ldr x0,=pf
	mov x1,x10
	bl printf
    //ldp x21,x22,[sp], #16;
    //ldp x19,x20,[sp], #16;
	ldp x29,x30,[sp], #16;


    ret
	
