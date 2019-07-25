.data
mfn: .asciz "Enter your first name: " // message ask for first name
mfl: .asciz "Enter your last name: "  // message ask for last name
scf: .asciz "%s" // scan farmat
pf: .asciz "Hello, %s %s.\n" // print farmat
fn: .space 100 // first name string
ln: .space 100 // last name string
.text
.global main

main: 
	ldr x0,=mfn
	bl printf
	ldr x0,=scf
	ldr x1,=fn
	bl scanf
	ldr x0,=mfl
	bl printf
	ldr x0,=scf
	ldr x1,=ln
	bl scanf

//print
	ldr x0,=pf
	ldr x1,=fn
	ldr x2,=ln
	bl printf
	bl exit


