.syntax unified
.cpu cortex-m4
.thumb
#define A #16
#define B #6
#define C #4

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
.word __stack_start
.word __kernel_reset__+1
.size vtable_kernel, .-vtable_kernel

.section .rodata
data: .asciz "kernel started!\n"
final: .asciz "Value in register #3: "
.section .text
__kernel_reset__:
	ldr r0, =data
	bl dbgput_line
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
	add r3, r0, r2
	
	ldr r0, =final
	bl dbgput
	mov r0, r3
	bl dbgput_num
	
	end:
	b end
