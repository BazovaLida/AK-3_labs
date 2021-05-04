.global part1
.syntax unified

#define x1u #0x00000000
#define x1d #0x0000000C
#define x2u #0x00000000
#define x2d #0x00000002
#define x3u #0xFFFFFFFF
#define x3d #0xFFFFFFF6
#define x4u #0x00000000
#define x4d #0x0000000F
#define ZK #0x00001FA5

part1:
    push {lr}
    // calculate 
	mov r1, x1u
	mov r0, x1d
	mov r3, x2u
	mov r2, x2d
	
	//x1 - x2
	subs r4, r0, r2
	sbc r5, r1, r3
	//8(x1 - x2)
	eor r10, r10 
	lsls r4, r4, #1
	adc r10, r10, #0
	lsls r4, r4, #1
	lsl r10, r10, #1
	adc r10, r10, #0
	lsls r4, r4, #1
	lsl r10, r10, #1
	adc r4, r4, r10
	lsls r5, r5, #3
	add r5, r5, r10
	
	mov r1, x3u
	mov r0, x3d
	mov r3, x4u
	mov r2, x4d
	
	//x3 ⊕ x4 - 1
	subs r6, r2, #1
	sbc r7, r3, #0
	eors r6, r0, r6
	eors r7, r1, r7	
	//(x3 ⊕ x4 - 1)/16
	eor r10, r10
	asrs r7, r7, #1
	adc r10, r10, #0
	asrs r7, r7, #1
	lsl r10, r10, #1
	adc r10, r10, #0
	asrs r7, r7, #1
	lsl r10, r10, #1
	adc r10, r10, #0
	asrs r7, r7, #1
	lsl r10, r10, #1
	adc r10, r10, #0
	lsl r10, r10, #28
	lsr r6, r6, #4
	add r6, r6, r10
	
	//f = 8(x1 - x2) + (x3 ⊕ x4 - 1)/16
	adds r6, r6, r4
	adcs r7, r7, r5

	it vs
	blVS _correct

	cmp r6, #0
	it eq
	blEQ _addZK

	mov r0, ZK
	add r7, r0

	lsrs r0, r7, #30
	it eq
	blEQ _cont
	cmp r0, #3
	it eq
	blEQ _cont
	bl _correct2

_cont:
	pop {pc}

_correct:
	push {lr}
	lsr r6, r6, #1
	lsrs r7, r7, #1
	adc r6, r6, #0
	add r7, r7, #0x80000000
	pop {pc}

_addZK:
	push {lr}
	mov r0, ZK
	lsl r0, r0, #16
	mov r6, r0
	pop {pc}

_correct2:
	push {lr}
	lsr r6, r6, #1
	asrs r7, r7, #1
	it cs
	addCS r6, #0x80000000
	pop {pc}
