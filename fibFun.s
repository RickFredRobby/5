.global main
main:
	LDR r0, =6
	BL fibStart
	BL finish

fibStart:
	STMDB sp!, {lr}  
	STMDB sp!, {r4}
	STMDB sp!, {r5}
	STMDB sp!, {r6}
	LDR r4, =2
	LDR r5, =1
	LDR r6, =1
fib:
	ADD r4, r4, #1
	STMDB sp!, {r7}
	ADD r7, r5, r6
	ADD r5, r6, #0
	ADD r6, r7, #0
	LDMIA sp!, {r7}
	CMP r4, r0
	BNE fib
fibEnd:
	ADD r1, r6, #0
	LDMIA sp!, {r6}
	LDMIA sp!, {r5}
	LDMIA sp!, {r4}
	LDMIA sp!, {pc}
finish:
	.end

; PARAMETER MUST BE >= 3
; FUNCTION CONSIDERS #1 AS THE FIRST VALUE IN FIBONACCI SEQUENCE
; r0 = parameter
; STACK:
; lr = link to main
; r4 = counter, execute fib until == r0
; r5 = first value to add
; r6 = second value to add
; r7 = total value so far