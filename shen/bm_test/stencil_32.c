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
int fdw32_4 = 0;
int fdw32_5 = 0;
int fdw32_6 = 0;
int fdw32_7 = 0;
int fdw32_8 = 0;

int fdr32_1 = 0;

int N = 0;
int i;
int *array_input;
int *array_hardware_A;
struct timeval tstart,tend,tv1,tv2,tv3,tv4,tv5,tv6,tv7,tv8,tv9;
ssize_t t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10;

int main(int argc, char *argv[]) {

	fdw32_1 = open("/dev/xillybus_write_32_p1", O_WRONLY);
	fdw32_2 = open("/dev/xillybus_write_32_p2", O_WRONLY);
	fdw32_3 = open("/dev/xillybus_write_32_p3", O_WRONLY);
	fdw32_4 = open("/dev/xillybus_write_32_p4", O_WRONLY);
	fdw32_5 = open("/dev/xillybus_write_32_p5", O_WRONLY);
	fdw32_6 = open("/dev/xillybus_write_32_p6", O_WRONLY);	
	fdw32_7 = open("/dev/xillybus_write_32_p7", O_WRONLY);
	fdw32_8 = open("/dev/xillybus_write_32_p8", O_WRONLY);

	fdr32_1 = open("/dev/xillybus_read_32_p1", O_RDONLY);

	N = atoi(argv[1]);//10;

	if (fdw32_1 < 0 || fdw32_2 < 0 || fdw32_3 < 0 || fdw32_4 < 0 || fdw32_5 < 0 || fdw32_6 < 0 || fdw32_7 < 0 || fdw32_8 < 0 || fdr32_1 < 0) {
		perror("Failed to open devfiles");
		exit(1);
	}

	//allocate memory
	array_input = (int*) malloc(N*sizeof(int));
	array_hardware_A = (int*) malloc(N*sizeof(int));

	// generate inputs and prepare outputs
	for(i=0; i<N; i++){
		array_input[i] = 1;
//		array_input[i] = (i + ((2*i)<<16));
		array_hardware_A[i] = 0;
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
	t4 = write(fdw32_4, array_input, sizeof(int)*N);
	temp4 = write(fdw32_4, NULL, 0);
//gettimeofday(&tv4, NULL);
	t5 = write(fdw32_5, array_input, sizeof(int)*N);
	temp5 = write(fdw32_5, NULL, 0);
//gettimeofday(&tv5, NULL);
	t6 = write(fdw32_6, array_input, sizeof(int)*N);
	temp6 = write(fdw32_6, NULL, 0);
//gettimeofday(&tv6, NULL);
	t7 = write(fdw32_7, array_input, sizeof(int)*N);
	temp7 = write(fdw32_7, NULL, 0);
//gettimeofday(&tv7, NULL);
	t8 = write(fdw32_8, array_input, sizeof(int)*N);
	temp8 = write(fdw32_8, NULL, 0);
//gettimeofday(&tv8, NULL);

	t9= read(fdr32_1, array_hardware_A, sizeof(int)*N);
//gettimeofday(&tv9, NULL);

	gettimeofday(&tend, NULL);
	//printf("Execution time %f us in SW--\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
	printf("%f \n\r", (double)1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec));//(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
//	for(i=0;i<N;i++){
//		
//	}
//	if()

//	printf("Writing FIFO 1 spend %f us\n\r", (double)1000000*(tv1.tv_sec-tstart.tv_sec)+(tv1.tv_usec-tstart.tv_usec));
//	printf("Writing FIFO 2 spend %f us\n\r", (double)1000000*(tv2.tv_sec-tstart.tv_sec)+(tv2.tv_usec-tstart.tv_usec));
//	printf("Writing FIFO 3 spend %f us\n\r", (double)1000000*(tv3.tv_sec-tstart.tv_sec)+(tv3.tv_usec-tstart.tv_usec));
//	printf("Writing FIFO 4 spend %f us\n\r", (double)1000000*(tv4.tv_sec-tstart.tv_sec)+(tv4.tv_usec-tstart.tv_usec));
//	printf("Writing FIFO 5 spend %f us\n\r", (double)1000000*(tv5.tv_sec-tstart.tv_sec)+(tv5.tv_usec-tstart.tv_usec));
//	printf("Writing FIFO 6 spend %f us\n\r", (double)1000000*(tv6.tv_sec-tstart.tv_sec)+(tv6.tv_usec-tstart.tv_usec));
//	printf("Writing FIFO 7 spend %f us\n\r", (double)1000000*(tv7.tv_sec-tstart.tv_sec)+(tv7.tv_usec-tstart.tv_usec));
//        printf("Writing FIFO 8 spend %f us\n\r", (double)1000000*(tv8.tv_sec-tstart.tv_sec)+(tv8.tv_usec-tstart.tv_usec));
//	
//        printf("Reading FIFO 1 spend %f us\n\r", (double)1000000*(tv9.tv_sec-tstart.tv_sec)+(tv9.tv_usec-tstart.tv_usec));
//
//	for(i=0; i<N; i++){
//		printf("o/p 0 is %d , o/p 1 is %d \n\r",array_hardware_A[i]>>16,array_hardware_A[i]&65535);
//	}

	return 0;
}
