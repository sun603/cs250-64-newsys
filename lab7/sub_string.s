.data
pt: .asciz "as"
outstr: .skip 400
pf: .asciz " %s\n"
.text	
.global		sub_string

sub_string:
push { fp, lr}
// r0 instr r1 si r2 en
	mov r9,r0
	mov r5,r1
	mov r6,r2
	sub r7,r2,r1
	add r7,r7,#1
	sub r8,r1,#1
	add r4,r4,r5
	add r10,r8,r9
	# ldr r0,=pf
	# mov r1,r9
	# bl printf
	ldr r0,=outstr 
	mov r1,r10 //from
	mov r2,r7 //len
	bl strncpy
	
	ldr r0,=outstr
	
	pop { fp, pc}    
