.data
sc1: .asciz "%s"
sc2: .asciz "%d"
pf1: .asciz "Enter a string: "
pf2: .asciz "Enter the start index:"
pf3: .asciz "Enter the end index:"
pf4: .asciz "The substring of the given string is '%s'\n"
instr: .space 200
si: .word 0
ei: .word 0

.text	
.global		main
main:
	ldr x0,=pf1
	bl printf
	ldr x0,=sc1
	ldr x1,=instr
	bl scanf
	
	ldr x0,=pf2
	bl printf
	ldr x0,=sc2
	ldr x1,=si
	bl scanf

	ldr x0,=pf3
	bl printf
	ldr x0,=sc2
	ldr x1,=ei
	bl scanf
	
	ldr x0,=instr
	ldr x1,=si
	ldr x1,[x1]
	ldr x2,=ei
	ldr x2,[x2]
	bl sub_string

	mov x1,x0
	ldr x0,=pf4
	bl printf

	// $,@,;  do not work for unkown reason as comment or number sign
	// r7 for syscall is changed to x8 in armv8
	// syscall id is changing used to be 1 for exit but now 93
	// https://reverseengineering.stackexchange.com/questions/16917/arm64-syscalls-table
	// https://github.com/torvalds/linux/blob/v4.17/include/uapi/asm-generic/unistd.h
	// armv7:
	// nop @no operation
	// mov r7, $1	@exit syscall
	// svc $0		@wake kernel
	nop
	mov x8, #93
	svc #0	
.end
	
