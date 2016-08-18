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

int fdw32 = 0;
int fdr32 = 0;

int N = 0;
int x,i;
int *array_input;
int *array_hardware;
struct timeval tstart,tend,tv1;
ssize_t t1,t2,temp1;

int main(int argc, char *argv[]) {

	fdw32 = open("/dev/xillybus_write_32", O_WRONLY);

	fdr32 = open("/dev/xillybus_read_32", O_RDONLY);

	N = atoi(argv[1]);//10;
	N = N*4;

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

	gettimeofday(&tstart, NULL);

	t1 = write(fdw32, array_input, sizeof(int)*N);
	//temp1 = write(fdw32, NULL, 0);
	gettimeofday(&tv1, NULL);

	t2 = read(fdr32, array_hardware, sizeof(int)*N);

	gettimeofday(&tend, NULL);
	//printf("Execution time %f us in SW--\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
	printf("%f \n\r", (double)1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec));//(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
//	printf("Writing FIFO spend %f us\n\r", (double)1000000*(tv1.tv_sec-tstart.tv_sec)+(tv1.tv_usec-tstart.tv_usec));	

/*	for(i=0; i<N/4; i++){
		printf("i/p is %d , o/p is %d \n\r",array_input[i],array_hardware[i]);
	}
*/
	return 0;
}
