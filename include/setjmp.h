#ifndef	_SETJMP_H
#define	_SETJMP_H

#ifdef __cplusplus
extern "C" {
#endif

#include <features.h>

#include <bits/setjmp.h>


#if defined(_POSIX_SOURCE) || defined(_POSIX_C_SOURCE) \
 || defined(_XOPEN_SOURCE) || defined(_GNU_SOURCE) \
 || defined(_BSD_SOURCE)
typedef struct {
	jmp_buf __jb;
	unsigned long __fl;
	unsigned long __ss[128/sizeof(long)];
} sigjmp_buf[1];
int sigsetjmp (sigjmp_buf, int);
_Noreturn void siglongjmp (sigjmp_buf, int);
#endif


#if defined(_XOPEN_SOURCE) || defined(_GNU_SOURCE) \
 || defined(_BSD_SOURCE)
int _setjmp (jmp_buf);
_Noreturn void _longjmp (jmp_buf, int);
#endif


int setjmp (jmp_buf);
_Noreturn void longjmp (jmp_buf, int);

#define setjmp setjmp
#define longjmp longjmp

#ifdef __cplusplus
}
#endif

#endif
