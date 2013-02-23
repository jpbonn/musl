#include "arch/lm32/bits/syscall.h"
.include "qemu_macros.inc"

.global __syscall
.type   __syscall,@function
/* FIXME: jump table */
__syscall:
	addi    r9, r0, SYS_exit
	be	r1, r9, __lm32_sys_exit
	addi    r9, r0, SYS_exit_group
	be	r1, r9, __lm32_sys_exit_group
	addi    r9, r0, SYS_brk
	be	r1, r9, __lm32_sys_brk
	/* All other syscalls halt. */
__bad_syscall_halted:
	bi      __bad_syscall_halted

__lm32_sys_exit_group:
	/* SYS_exit_group is ignored */
	ret

__lm32_sys_brk:
	/* The Linux system call returns the new program break on          */ 
	/* success.  On failure, the system call returns the current break */
	/* break if increment is 0 return current break                    */
	mvhi    r9, hi(_sbrk_top)
	ori     r9, r9, lo(_sbrk_top)
	lw	r1, (r9+0)
	bne	r0, r2, .Linc_not_0	
	ret
.Linc_not_0:
	/* add the increment to _sbrk_top and return the new value. */
	addi 	r1, r2, 0
	sw	(r9+0), r1
	/* if the heap extended into the stack then abort. */
	bgeu	r1, sp, .Labort
	/* if too much memory was freed then abort.  */
	mvhi    r9, hi(_sbrk_top_initial)
	ori     r9, r9, lo(_sbrk_top_initial)
	lw	r9, (r9+0)
	bgu	r9, r1, .Labort
	ret

__lm32_sys_exit:	# SYS_exit sets exit code and calls qemu exit.
	be      r2, r0, .Lpass    # was exit code pass?
	/* abort was here in newlib based gcc tests */
.Labort:
        tc_fail       # indicate failure to qemu
	bi .Lhalt
.Lpass:
	tc_pass       # indicate success to qemu
.Lhalt:
	end           # halt qemu.


