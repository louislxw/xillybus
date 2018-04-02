#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <pthread.h>
#include <stdint.h>
#include <sys/time.h>
#include "timer.h"

int fdw32 = 0;
int fdr32 = 0;

int N = 0;
int x,i;
int *array_input;
int *array_hardware;
struct timeval tstart,tend,tv1;
ssize_t t1,t2,temp1;

int main(int argc, char *argv[]) {

	fdw32 = open("/dev/xillybus_write_128", O_WRONLY);
	fdr32 = open("/dev/xillybus_read_128", O_RDONLY);

	GET_TIME_INIT(3);

	N = atoi(argv[1]);//10;
//	N = N*4;

	if (fdw32 < 0 || fdr32 < 0) {
		perror("Failed to open devfiles");
		exit(1);
	}

	//allocate memory
	array_input = (int*) malloc(N*sizeof(int));
	array_hardware = (int*) malloc(N*sizeof(int));

	// generate inputs and prepare outputs
	for(i=0; i<N; i++){
		array_input[i] = i;
//		for(x=0;x<8;x++){	
//			array_input[x+8*i] = i;
//		}
	//	array_input[i] = i;
		array_hardware[i] = 0;
	}

//	gettimeofday(&tstart, NULL);
	GET_TIME_VAL(0);

	t1 = write(fdw32, array_input, sizeof(int)*N);
	temp1 = write(fdw32, NULL, 0);//a notification at the end of writing data 
//	gettimeofday(&tv1, NULL);
	GET_TIME_VAL(1);

	t2 = read(fdr32, array_hardware, sizeof(int)*N);
//	gettimeofday(&tend, NULL);
	GET_TIME_VAL(2);

	for(i=0; i<N; i++){
		if(array_input[i] != array_hardware[i]) {
			printf("recv[%d]: %d , expected %d \n\r", i, array_hardware[i], array_input[i]);
			return;
		}
	}

	printf("send bw: %f\n", N*4.0/1024/1024/((TIME_VAL_TO_MS(1) - TIME_VAL_TO_MS(0))/1000.0));
	printf("recv bw: %f\n", N*4.0/1024/1024/((TIME_VAL_TO_MS(2) - TIME_VAL_TO_MS(1))/1000.0));

	printf("round-trip time: %f us\n", (TIME_VAL_TO_MS(2) - TIME_VAL_TO_MS(0))*1000.0);
	printf("overall bw: %f MB/s\n", N*4.0/1024/1024/((TIME_VAL_TO_MS(2) - TIME_VAL_TO_MS(0))/1000.0));
//	printf("round-trip time is %f us\n\r", (double)1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec));//(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
//	printf("Writing FIFO spend %f us\n\r", (double)1000000*(tv1.tv_sec-tstart.tv_sec)+(tv1.tv_usec-tstart.tv_usec));	

//	for(i=0; i<N/4; i++){
//		printf("i/p is %d , o/p is %d \n\r",array_input[i],array_hardware[i]);
//	}

	return 0;
}
