.global lab1
.syntax unified
#define A #16
#define B #6
#define C #4
lab1:
    push {lr}
    // calculate 
    mov r0, A
    mov r1, B
    SUB r0, r0, r1
    mov r1, #3
    MUL r0, r0, r1
    mov r1, C
    mov r2, #1
    mov r3, #2
.L1:
	cmp r1, #0
	ble .L2

	mul r2, r2, r3

	sub r1, r1, #1
	b .L1

.L2:
	add r0, r0, r2

pop {pc}