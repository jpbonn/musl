.include "qemu_macros.inc"

.section    .boot, "ax", @progbits
.global     _start  

_start:
_reset_handler:
	xor r0, r0, r0
	mvhi r1, hi(_reset_handler)
	ori r1, r1, lo(_reset_handler)
	wcsr eba, r1
	wcsr deba, r1
	mvhi r1, hi(__restart_board)
	ori r1, r1, lo(__restart_board)
	b r1

_breakpoint_handler:
	ori r25, r25, 1
	addi ra, ba, 4
	ret
	nop
	nop
	nop
	nop
	nop

_instruction_bus_error_handler:
	ori r25, r25, 2
	addi ra, ea, 4
	ret
	nop
	nop
	nop
	nop
	nop

_watchpoint_handler:
	ori r25, r25, 4
	addi ra, ba, 4
	ret
	nop
	nop
	nop
	nop
	nop

_data_bus_error_handler:
	ori r25, r25, 8
	addi ra, ea, 4
	ret
	nop
	nop
	nop
	nop
	nop

_divide_by_zero_handler:
	ori r25, r25, 16
	addi ra, ea, 4
	ret
	nop
	nop
	nop
	nop
	nop

_interrupt_handler:
	ori r25, r25, 32
	addi ra, ea, 4
	ret
	nop
	nop
	nop
	nop
	nop

_system_call_handler:
	ori r25, r25, 64
	addi ra, ea, 4
	ret
	nop
	nop
	nop
	nop
	nop


# FIXME: static constructors and destructors
#       .weak       _fini
#       .weak       _init

.section    .text, "ax", @progbits
__restart_board:
	# Setup stack and global pointer 
        # Point to the first unused location so offset the stack by 4 
	mvhi    sp, hi(_fstack-4)
	ori     sp, sp, lo(_fstack-4)
        mvhi    gp, hi(_gp)
        ori     gp, gp, lo(_gp)
                                
      	# Clear BSS, _fbss and _ebss must be word aligned
	mvhi    r1, hi(_fbss)
	ori     r1, r1, lo(_fbss)
	mvhi    r3, hi(_ebss)
	ori     r3, r3, lo(_ebss)
.clearBSS:
	be      r1, r3, .callMain
	sw      (r1+0), r0
	addi    r1, r1, 4
	bi      .clearBSS
 
.callMain:
	# initialize sbrk to point to the top of the data section
        mvhi    r1, hi(_end)
        ori     r1, r1, lo(_end)
        mvhi    r2, hi(_sbrk_top)
        ori     r2, r2, lo(_sbrk_top)
	sw	(r2 + 0),r1	
        mvhi    r2, hi(_sbrk_top_initial)
        ori     r2, r2, lo(_sbrk_top_initial)
	sw	(r2 + 0),r1	
	
        # set qemu test name  (this forces text section)
	test_name MAIN
        # Call _libc_start_main(main, argc, argv, init, fini, ldso_fini)
        mvhi    r1, hi(main)
        ori     r1, r1, lo(main)
        mvi     r2, 0             # argc is 0
        mvi     r3, 0             # argv is 0
# FIXME: static constructors and destructors
#       mvhi    r4, hi(_init)
#       ori     r4, r4, lo(_init)
#       mvhi    r5, hi(_fini)
#       ori     r5, r5, lo(_fini)

        mvi     r4, 0             # init is 0
        mvi     r5, 0             # fini is 0
        mvi     r6, 0             # ldso_fini is 0
        calli   __libc_start_main # doesn't return

# crt1.S is always linked in forst so we define
# abort here so libc abort does not get linked in too.
.global abort
abort:
        tc_fail
        end
        bi .


.section    .data
	.align 4
	.global _sbrk_top_initial
	.global _sbrk_top
_sbrk_top_initial:
	.word 0xdeadbeef 
_sbrk_top:
	.word 0xdeadbeef

