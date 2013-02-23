static inline struct pthread *__pthread_self()
{
	exit(1);
	return NULL;
}

#define TP_ADJ(p) (p)

#define CANCEL_REG_IP 32
