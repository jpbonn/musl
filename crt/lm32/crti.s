.section .init
.global _init
_init:
#	addi r1, r1, -32
#	swi r15, r1, 0
	xor r0,r0,r0

.section .fini
.global _fini
_fini:
#	addi r1, r1, -32
#	swi r15, r1, 0
	xor r0,r0,r0
