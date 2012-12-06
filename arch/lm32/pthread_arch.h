static inline struct pthread *__pthread_self()
{
	assert(0 && "Unimplemented");
	return NULL;
}

#define TP_ADJ(p) (p)

#define CANCEL_REG_IP 32
