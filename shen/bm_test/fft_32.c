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

int fdw32_1 = 0;
int fdw32_2 = 0;
int fdw32_3 = 0;

int fdr32_1 = 0;
int fdr32_2 = 0;

int N = 0;
int i;
int *array_input;
int *array_hardware_A;
int *array_hardware_B;
struct timeval tstart,tend,tv1,tv2,tv3,tv4,tv5;
ssize_t t1,t2,t3,t4,t5,temp1,temp2,temp3;

int main(int argc, char *argv[]) {

	fdw32_1 = open("/dev/xillybus_write_32_p1", O_WRONLY);
	fdw32_2 = open("/dev/xillybus_write_32_p2", O_WRONLY);
	fdw32_3 = open("/dev/xillybus_write_32_p3", O_WRONLY);

	fdr32_1 = open("/dev/xillybus_read_32_p1", O_RDONLY);
	fdr32_2 = open("/dev/xillybus_read_32_p2", O_RDONLY);

	N = atoi(argv[1]);//10;

	if (fdw32_1 < 0 || fdw32_2 < 0 || fdw32_3 < 0 || fdr32_1 < 0 || fdr32_2 < 0) {
		perror("Failed to open devfiles");
		exit(1);
	}

	//allocate memory
	array_input = (int*) malloc(N*sizeof(int));
	array_hardware_A = (int*) malloc(N*sizeof(int));
	array_hardware_B = (int*) malloc(N*sizeof(int));

	// generate inputs and prepare outputs
	for(i=0; i<N; i++){
		array_input[i] = ((i<<16)+i);
		array_hardware_A[i] = 0;
		array_hardware_B[i] = 0;
	}
	gettimeofday(&tstart, NULL);

	t1 = write(fdw32_1, array_input, sizeof(int)*N);
	temp1 = write(fdw32_1, NULL, 0);
//gettimeofday(&tv1, NULL);
	t2 = write(fdw32_2, array_input, sizeof(int)*N);
	temp2 = write(fdw32_2, NULL, 0);
//gettimeofday(&tv2, NULL);
	t3 = write(fdw32_3, array_input, sizeof(int)*N);
	temp3 = write(fdw32_3, NULL, 0);
//gettimeofday(&tv3, NULL);

	t4= read(fdr32_1, array_hardware_A, sizeof(int)*N);
//gettimeofday(&tv4, NULL);
	t5= read(fdr32_2, array_hardware_B, sizeof(int)*N);
//gettimeofday(&tv5, NULL);

	gettimeofday(&tend, NULL);
	//printf("Execution time %f us in SW--\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
	printf("%f \r", (double)1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec));//(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
//	for(i=0;i<N;i++){
//		
//	}
//	if()

//	printf("Writing FIFO 1 spend %f us\n\r", (double)1000000*(tv1.tv_sec-tstart.tv_sec)+(tv1.tv_usec-tstart.tv_usec));
//	printf("Writing FIFO 2 spend %f us\n\r", (double)1000000*(tv2.tv_sec-tstart.tv_sec)+(tv2.tv_usec-tstart.tv_usec));
//	printf("Writing FIFO 3 spend %f us\n\r", (double)1000000*(tv3.tv_sec-tstart.tv_sec)+(tv3.tv_usec-tstart.tv_usec));
//	
//        printf("Reading FIFO 1 spend %f us\n\r", (double)1000000*(tv4.tv_sec-tstart.tv_sec)+(tv4.tv_usec-tstart.tv_usec));
//	printf("Reading FIFO 2 spend %f us\n\r", (double)1000000*(tv5.tv_sec-tstart.tv_sec)+(tv5.tv_usec-tstart.tv_usec));
//
//	for(i=0; i<N; i++){
//		printf("o/p 0 is %d , o/p 1 is %d , o/p 2 is %d , o/p 3 is %d \n\r",array_hardware_A[i]>>16,array_hardware_A[i]&65535,array_hardware_B[i]>>16,array_hardware_B[i]&65535);
//	}

	return 0;
}
