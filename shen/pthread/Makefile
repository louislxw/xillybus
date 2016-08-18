CFLAGS=-g -Wall -O3

CFLAG2=-lpthread

APPLICATIONS=2in2out_loopback_pthread

all: 	$(APPLICATIONS)

fifo:	fifo.c
	gcc  $(CFLAGS) -pthread $@.c -o $@

%: 	%.c
	gcc  $(CFLAGS) $@.c -o $@ $(CFLAG2)

clean:
	rm -f *~ $(APPLICATIONS)
