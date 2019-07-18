# lab 6

website for circuit recommend by a ta. https://www.tinkercad.com

## Register

R0 - R30, 
Wn (w0,w1,...) 32bit
Xn (X0,X1,...) 64bit

Armv8-A has multiple stack pointers, and each one is associated with a specific Exception level. When SP is used in an instruction, it means the current stack pointer. 

The Program Counter (PC) is not a general-purpose register in A64, and it cannot be used with data processing instructions.

XZR, WZR are the Zero register like dev/null in os 
## instruction

instruction components:
Operation Destination Operand 1 Operand 2

Operation: keyword like add mov str 
Destination: always a register, specifies where the result to go
Operand 1: always be a register. This is the first input to the instruction.
Operand 2: a register or a constant, and is the second input to the instruction. 
When operand 2 is a register, it may include an optional shift (talk later). 
When operand 2 is a constant, it is encoded within the instruction itself. This means that the range of constants available is limited.

reference: https://developer.arm.com/architectures/learn-the-architecture/armv8-a-instruction-set-architecture/data-processing-arithmetic-and-logic-operations 


## condition and branch
Just branch (goto)use `b label`. branch with return address (function call) use `bl label`. 

Branch with condition use flags.

```
SUBS XZR, X0, X7 //update flags

SUB XZR, X0, X7 // do not update flags

CMP X0, X7     //an alias of SUBS XZR, X0, X7

TST W5, #1     //an alias of ANDS WZR, W5, #1
```

```
b.ge label

bge label //works without dot 
```

AArch64 has a four flags. Each flag means some condition resulting from the execution of some instruction. Just a few instructions set these flags. For the current chapter we will consider only cmp. Also just a few instructions use these flags: among them conditional branch instructions.

N (negative) is set if the result of the instruction yields a value that can be understood as a negative number. So positive and zero will have this flag unset.
Z (zero) is set if the result of the instruction yields a value that is zero.
C (carry) is set if the result of the instruction cannot be represented as an unsigned integer.
V (overflow) is set if the result of the instruction cannot be represented as a signed integer.

Name|	Meaning	Condition |flag
:----|:----|:----
EQ|	Values compare equal or the result of the operation is zero.	|Z is set
NE|	Values compare different or the result of the operation is non-zero.	|Z is not set
GE|	Greater or equal. Comparison of signed integers, the first operand is greater or equal than the second.	|N and V are both set or both not set
GT|	Greater. Comparison of signed integers, the first operand is greater than the second.	|Z is not set. N and V are both set or both not set
LE|	Lower or equal. Comparison of signed integers, the first operand is lower or equal than the second.	|N is set and V is not set or the opposite
LT|	Lower. Comparison of signed integers, the first operand is lower than the second.	|Z is not set. N is set and V is not set or the opposite

see reference and difference between C and V: 
https://thinkingeek.com/2016/11/27/exploring-aarch64-assembler-chapter-6/ 

Also, https://developer.arm.com/architectures/learn-the-architecture/armv8-a-instruction-set-architecture/program-flow-generating-condition-code 

## stack and calling convention 

#### registers

In this [question](https://stackoverflow.com/a/29603040/10538217) there is a very **wrong** answer on 64bit ARM.  

The most important part is remember which registers can be used and how to use safely. 

r0-r7 are parameter and r9-r15 are temporary registers. Use they as you like, but will lose the data if call to other function. So store in stack or ".data" before function call. 

r19…r28 are callee-saved registers. Should store the value in stack before using. 

In [IHI0055B](http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055b/IHI0055B_aapcs64.pdf) 1.3, definitions:

> Routine, subroutine:<br>A fragment of program to which control can be transferred that, on completing its task, returns control to its caller at an instruction following the call. Routine is used for clarity
where there are nested calls: a routine is the caller and a subroutine is the callee.
>
> Procedure:<br>A routine that returns no result value.
>
> Function:<br>A routine that returns a result value. 
> Scratch register, temporary register, Callersaved register:<br>A register used to hold an intermediate value during a calculation (usually, such values are not named in the program source and have a limited lifetime). If a function needs to preserve the value held in such a register over a call to another function, then the calling function must save and restore the value.
>
> Callee-saved register:<br>A register whose value must be preserved over a function call. If the function being called (the callee) needs to use the register, then it is responsible for saving and restoring the old value.

In IHI0055B 5.1:
|Register |Special | Role in the procedure call standard|
|:---|:---|:---|
SP| |The Stack Pointer.
r30| LR | The Link Register.
r29| FP | The Frame Pointer
r19…r28| | Callee-saved registers
r18| | The Platform Register, if needed; otherwise a temporary register. See notes.
r17| IP1 | The second intra-procedure-call temporary register (can be used by call veneers and PLT code); at other times may be used as a temporary register.
r16| IP0 | The first intra-procedure-call scratch register (can be used by call veneers and PLT code); at other times may be used as a temporary register.
r9…r15| | Temporary registers
r8| | Indirect result location register
r0…r7 | | Parameter/result registers

#### starting and ending of a function
In A32, we have 
```
push {r4-r9, fp, lr}
// function goes inside
pop {r4-r9, fp, pc}
```
Something similar in A64 is: 
```
stp x29, x30 , [sp, #-16]! 
// function goes inside
ldp x29,x30,[sp], #16;
ret
```

We can no longer use `push` and `pop` as we can push a 64-bit value to stack as well as a 32-bit value. Every store and load must specific the offset. Of course sp can be replace with other register and write some fancy code with that. For simples way is to use `stp` (STore Pair), `str` (STore single Register). x29 is the fp and x30 is lr. pc in A64 is not longer accessible as a general purpose register. `ret` with take value in lr and move to pc. 


```
stp x9, x10 , [sp, #-16]!
stp x11, x12, [sp, #-16]!
bl scanf
ldp x11, x12, [sp], #16
ldp x9, x10, [sp], #16
```

no reference, cannot recall where I get this. It is everywhere. 

#### next step 
1. Something i am not sure why -> There is a BUS err, if the sp is not aligned in 16 byte. 

For example, the following code will have a run time SIGBUS error in the first line in scanf(). 
```
stp x9, x10 , [sp, #-16]!
str x11, [sp, #-8]!
bl scanf
ldr x11, [sp], #16
ld x9, x10, [sp], #16
```

2. work on lab7