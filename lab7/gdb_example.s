//example program for understanding GDB
.section .data
.section .text
.global main
main:
	nop
	mov x1, #5	//load r1 with integer 5
	cmp x1, #4	//compare r1 to integer 4, they will not be equal here
	sub x1, x1, #1	//subtract 1 from r1
	cmp x1, #4	//they will be equal here
	sub x1, x1, #4	//now r1 = 0
	cmp x1, #4	//they are no longer equal

	mov x7, #1
	svc #0
	ret
	.end
