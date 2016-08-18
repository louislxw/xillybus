CFLAGS=-g -Wall -O3

APPLICATIONS=test_2in2out_32b_kernel

all: 	$(APPLICATIONS)

fifo:	fifo.c
	gcc  $(CFLAGS) -pthread $@.c -o $@

%: 	%.c
	gcc  $(CFLAGS) $@.c -o $@

clean:
	rm -f *~ $(APPLICATIONS)
