#include <string.h>
#include <elf.h>

#define ETC_LDSO_PATH "/etc/ld-musl-microblaze.path"

#define IS_COPY(x) ((x)==R_MICROBLAZE_COPY)
#define IS_PLT(x) ((x)==R_MICROBLAZE_JUMP_SLOT)

static inline void do_single_reloc(
	struct dso *self, unsigned char *base_addr,
	size_t *reloc_addr, int type, size_t addend,
	Sym *sym, size_t sym_size,
	struct symdef def, size_t sym_val)
{
	exit(1);
}

#include "syscall.h"
void __reloc_self(int c, size_t *a, size_t *dynv)
{
	exit(1);
}
