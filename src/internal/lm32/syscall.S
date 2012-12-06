#include "arch/lm32/bits/syscall.h"
.include "qemu_macros.inc"

.global __syscall
.type   __syscall,@function
# FIXME: unsupported at this point
__syscall:
	# SYS_exit_group is ignored
	mvhi    r9, hi(SYS_exit_group)
	ori     r9, r9, lo(SYS_exit_group)
	bne	r1, r9, .Lsys_exit
	ret
.Lsys_exit:	# SYS_exit sets exit code and calls qemu exit.
	mvhi    r9, hi(SYS_exit)
	ori     r9, r9, lo(SYS_exit)
	bne	r1, r9, .Lhalted  # all other syscalls halt.
	be      r2, r0, .Lpass    # was exit code pass?
# abort was here in newlib based gcc tests
.Labort:
        tc_fail       # indicate failure to qemu
	bi .Lhalt
.Lpass:
	tc_pass       # indicate success to qemu
.Lhalt:
	end           # halt qemu.

	# All other syscalls halt.
.Lhalted:
	xor	r0,r0,r0
	bi      .Lhalted

