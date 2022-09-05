#include <stdio.h>

void tyrion(unsigned int a);
size_t snow(unsigned int a, unsigned int b);
void arya(unsigned int a, unsigned int b, unsigned int *out, const unsigned char *msg);

static unsigned const char message[30];

int main(void)
{
	unsigned int out[7];
  size_t ret;

	// TODO a: Apelati functia tyrion() din fisierul hidden.o astfel ıncat sa se
	//         afiseze mesajul "That's what I do: I drink and I know things.
 	tyrion(0);

	// TODO b: Apelati functia snow() din fisierul hidden.o pentru a ıntoarce valoarea 73.
	ret = snow(0, 0);
	printf("ret: %zu\n", ret);

	// TODO c: pelati functia arya() din fisierul hidden.o pentru a obtine mesajul
	//         "Tell them the North remembers"
	arya(0, 0, out, message);

	return 0;
}
