.data 

scf: .asciz "%s" 

pf: .asciz "%d\n\000"

stz: .space 100  // space for string to scan

.text
.global main 

main:
    // take input 
    stp x29, x30 , [sp, #-16]!
    ldr x0, =scf
    ldr x1, =stz
    bl scanf

//per loop
	ldr x3, =stz
	ldr x1, =0
	/*counting value*/
//loop 
loop:	
	ldr x2, [x3,x1]
	cmp x2,#0
	beq endloop
	add x1,x1,#1
	/* out, in case of infinte loop */
	cmp x1,#101
	beq endloop
	b loop
endloop:
	ldr x0,=pf
	/* mov x1,x1 */
	/* x1 is counting value aready, done at loop*/
	bl printf

    ldp x29,x30,[sp], #16;
    ret

