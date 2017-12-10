.global main
main:
	LDR r0, =6           ; find the factorial of r0
	BL factorialStart    ; link to function
	BL finish	     ; end program

factorialStart:
	CMP r4, #0
	BNE factorial
	STMDB sp!, {lr}	     ; store link back to program
	STMDB sp!, {r4-r5}   ; saved variables, on stack for duration of function
	ADD r4, r0, #-1	     ; set r4 to r0 [parameter]-1 
	MUL r5, r4, r0       ; set r5 to the product of r4 and r0 [r0 * r0-1 == r5]
factorial:
	STMDB sp!, {r6}	     ; after first operation, push r6 as temp storage for new answers
	ADD r4, r4, #-1	     ; decrement r4
	MUL r6, r5, r4       ; new answer [r0 * (r0-1) * (r0-2) ... * 1 == r6 on last iteration]
	ADD r5, r6, #0       ; store answer in r5
	LDMIA sp!, {r6}      ; pop r6 from stack
	CMP r4, #1           ; check to see whether function should be called again
	BNE factorialStart   ; if so, call function
factorialEnd:
	MOV r1, r5       ; store return value in r1
	LDMIA sp!, {r4-r5}   ; pop registers from stack
	LDMIA sp!, {pc}      ; return program counter to main
finish:
	.end                 ; terminate program