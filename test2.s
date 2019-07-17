.data
print_string: .asciz "Hello World\n";
len = . - print_string
.text
.global main
main:
	mov x0, 0
	ldr x1, =print_string
	mov x2, len
	mov x8, 64
	svc #0

	mov x0, 213
	mov x8, 93
	svc #0 
