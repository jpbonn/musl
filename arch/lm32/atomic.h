#ifndef _INTERNAL_ATOMIC_H
#define _INTERNAL_ATOMIC_H

#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

static inline int a_ctz_l(unsigned long x)
{
	assert(0 && "unimplemented");
	return 0;
}


static inline int a_ctz_64(uint64_t x)
{
	assert(0 && "unimplemented");
	return 0;
}

static inline int a_cas_1(volatile int *p, int t, int s)
{
	assert(0 && "unimplemented");
	return 0;
}

static inline int a_cas(volatile int *p, int t, int s)
{
	assert(0 && "unimplemented");
	return 0;
}

static inline void *a_cas_p(volatile void *p, void *t, void *s)
{
	assert(0 && "unimplemented");
	return NULL;
}

static inline long a_cas_l(volatile void *p, long t, long s)
{
	assert(0 && "unimplemented");
	return 0;
}

static inline int a_swap(volatile int *x, int v)
{
	int tmp = *x;
	*x = v;
	return tmp;
}

static inline int a_fetch_add(volatile int *x, int v)
{
	assert(0 && "unimplemented");
	return 0;
}

static inline void a_inc(volatile int *x)
{
	assert(0 && "unimplemented");
}

static inline void a_dec(volatile int *x)
{
	assert(0 && "unimplemented");
}

static inline void a_store(volatile int *p, int x)
{
	assert(0 && "unimplemented");
}

static inline void a_spin()
{
	assert(0 && "unimplemented");
}

static inline void a_crash()
{
	assert(0 && "unimplemented");
}

static inline void a_and(volatile int *p, int v)
{
	assert(0 && "unimplemented");
}

static inline void a_or(volatile int *p, int v)
{
	assert(0 && "unimplemented");
}

static inline void a_and_64(volatile uint64_t *p, uint64_t v)
{
	assert(0 && "unimplemented");
}

static inline void a_or_64(volatile uint64_t *p, uint64_t v)
{
	assert(0 && "unimplemented");
}

#endif
