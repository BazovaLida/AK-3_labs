.global part2
.syntax unified

part2:
	push {lr}

	// calculate
	mov r1, #1
	mov r2, #2
	//go to sub
	bl subPr1
	
_step3:
	adds r1, r1, r2
	
	it cc
	//C = 1
	lsrCC r2, r2, #7
	bCC _step8
	
	//C != 1
	mov r3, #5
	lsls r2, r3, #6
	
_step8:
	//if (V != 0 -> V = 1)
	it vs
	blVS _step3
	
	//if V = 0
	asr r1, r1, #9
	pop {pc}
	
	
subPr1:
	push {lr}
_step1_1:
	lsls r1, r1, #10
	//if(N != 0 -> N = 1)
	it mi
	blmi _step1_4
	//else go to subpr2
	bl subPr2
	sbcs r2, r2, r1
	
_step1_4:
	it cc
	blCC _step1_1
	
	add r1, r1, #14
	lsl r1, r2, #15
	
	pop {pc}
	

subPr2:
	push {lr}

	lsl r2, r2, #16
	adds r1, r1, r2

	pop {pc}
