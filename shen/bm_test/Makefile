CFLAGS=-g -Wall -O3

APPLICATIONS=radar_32

all: 	$(APPLICATIONS)

fifo:	fifo.c
	gcc  $(CFLAGS) -pthread $@.c -o $@

%: 	%.c
	gcc  $(CFLAGS) $@.c -o $@

clean:
	rm -f *~ $(APPLICATIONS)
