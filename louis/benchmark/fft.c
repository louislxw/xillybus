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
#include <omp.h>

int fdw16_1 = 0;
int fdw16_2 = 0;
int fdw16_3 = 0;
int fdw16_4 = 0;
int fdw16_5 = 0;
int fdw16_6 = 0;

int fdr16_1 = 0;
int fdr16_2 = 0;
int fdr16_3 = 0;
int fdr16_4 = 0;

int N = 0;
int i;
short *array_input;
short *array_hardware_A;
short *array_hardware_B;
short *array_hardware_C;
short *array_hardware_D;
struct timeval tstart,tend,tv1,tv2,tv3,tv4,tv5,tv6,tv7,tv8,tv9,tv10;
ssize_t t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,temp1,temp2,temp3,temp4,temp5,temp6;

int main(int argc, char *argv[]) {

	fdw16_1 = open("/dev/xillybus_write_16_p1", O_WRONLY);
	fdw16_2 = open("/dev/xillybus_write_16_p2", O_WRONLY);
	fdw16_3 = open("/dev/xillybus_write_16_p3", O_WRONLY);
	fdw16_4 = open("/dev/xillybus_write_16_p4", O_WRONLY);
	fdw16_5 = open("/dev/xillybus_write_16_p5", O_WRONLY);
	fdw16_6 = open("/dev/xillybus_write_16_p6", O_WRONLY);	
	fdr16_1 = open("/dev/xillybus_read_16_p1", O_RDONLY);
	fdr16_2 = open("/dev/xillybus_read_16_p2", O_RDONLY);
	fdr16_3 = open("/dev/xillybus_read_16_p3", O_RDONLY);
	fdr16_4 = open("/dev/xillybus_read_16_p4", O_RDONLY);

	N = atoi(argv[1]);//10;

	if (fdw16_1 < 0 || fdw16_2 < 0 || fdw16_3 < 0 || fdw16_4 < 0 || fdw16_5 < 0 || fdw16_6 < 0 || fdr16_1 < 0 || fdr16_2 < 0 || fdr16_3 < 0 || fdr16_4 < 0) {
		perror("Failed to open devfiles");
		exit(1);
	}

	//allocate memory
	array_input = (short*) malloc(N*sizeof(int));
	array_hardware_A = (short*) malloc(N*sizeof(int));
	array_hardware_B = (short*) malloc(N*sizeof(int));
        array_hardware_C = (short*) malloc(N*sizeof(int));
        array_hardware_D = (short*) malloc(N*sizeof(int));

	// generate inputs and prepare outputs
	for(i=0; i<N; i++){
		array_input[i] = i;
		array_hardware_A[i] = 0;
		array_hardware_B[i] = 0;
		array_hardware_C[i] = 0;
		array_hardware_D[i] = 0;
	}
	gettimeofday(&tstart, NULL);

	t1 = write(fdw16_1, array_input, sizeof(int)*N);
	temp1 = write(fdw16_1, NULL, 0);
gettimeofday(&tv1, NULL);
	t2 = write(fdw16_2, array_input, sizeof(int)*N);
	temp2 = write(fdw16_2, NULL, 0);
gettimeofday(&tv2, NULL);
	t3 = write(fdw16_3, array_input, sizeof(int)*N);
	temp3 = write(fdw16_3, NULL, 0);
gettimeofday(&tv3, NULL);
	t4 = write(fdw16_4, array_input, sizeof(int)*N);
	temp4 = write(fdw16_4, NULL, 0);
gettimeofday(&tv4, NULL);
	t5 = write(fdw16_5, array_input, sizeof(int)*N);
	temp5 = write(fdw16_5, NULL, 0);
gettimeofday(&tv5, NULL);
	t6 = write(fdw16_6, array_input, sizeof(int)*N);
	temp6 = write(fdw16_6, NULL, 0);
gettimeofday(&tv6, NULL);

	t7= read(fdr16_1, array_hardware_A, sizeof(int)*N);
gettimeofday(&tv7, NULL);
	t8= read(fdr16_2, array_hardware_B, sizeof(int)*N);
gettimeofday(&tv8, NULL);
	t9= read(fdr16_3, array_hardware_C, sizeof(int)*N);
gettimeofday(&tv9, NULL);
	t10= read(fdr16_4, array_hardware_D, sizeof(int)*N);
gettimeofday(&tv10, NULL);

	gettimeofday(&tend, NULL);
	//printf("Execution time %f us in SW--\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
	printf("Execution time is %f us\n\r", (double)1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec));//(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
//	for(i=0;i<N;i++){
//		
//	}
//	if()

	printf("Writing FIFO 1 spend %f us\n\r", (double)1000000*(tv1.tv_sec-tstart.tv_sec)+(tv1.tv_usec-tstart.tv_usec));
	printf("Writing FIFO 2 spend %f us\n\r", (double)1000000*(tv2.tv_sec-tstart.tv_sec)+(tv2.tv_usec-tstart.tv_usec));
	printf("Writing FIFO 3 spend %f us\n\r", (double)1000000*(tv3.tv_sec-tstart.tv_sec)+(tv3.tv_usec-tstart.tv_usec));
	printf("Writing FIFO 4 spend %f us\n\r", (double)1000000*(tv4.tv_sec-tstart.tv_sec)+(tv4.tv_usec-tstart.tv_usec));
	printf("Writing FIFO 5 spend %f us\n\r", (double)1000000*(tv5.tv_sec-tstart.tv_sec)+(tv5.tv_usec-tstart.tv_usec));
	printf("Writing FIFO 6 spend %f us\n\r", (double)1000000*(tv6.tv_sec-tstart.tv_sec)+(tv6.tv_usec-tstart.tv_usec));

        printf("Reading FIFO 7 spend %f us\n\r", (double)1000000*(tv7.tv_sec-tstart.tv_sec)+(tv7.tv_usec-tstart.tv_usec));
        printf("Reading FIFO 8 spend %f us\n\r", (double)1000000*(tv8.tv_sec-tstart.tv_sec)+(tv8.tv_usec-tstart.tv_usec));
        printf("Reading FIFO 9 spend %f us\n\r", (double)1000000*(tv9.tv_sec-tstart.tv_sec)+(tv9.tv_usec-tstart.tv_usec));
        printf("Reading FIFO 10 spend %f us\n\r", (double)1000000*(tv10.tv_sec-tstart.tv_sec)+(tv10.tv_usec-tstart.tv_usec));

/*	for(i=0; i<N; i++){
		printf("o/p from p1 is %d\n\r",array_hardware_A[i]);
		printf("o/p from p2 is %d\n\r",array_hardware_B[i]);
		printf("o/p from p3 is %d\n\r",array_hardware_C[i]);
		printf("o/p from p4 is %d\n\r",array_hardware_D[i]);
	}
*/
	return 0;
}
