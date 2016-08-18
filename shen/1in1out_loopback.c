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
//int fdw32_2 = 0;

int fdr32 = 0;
//int fdr32_2 = 0;

int N = 0;
int i;
int *array_input;
int *array_hardware;
//int *array_hardware_B;
struct timeval tstart,tend,tv1, tv2,tv3,tv4;
ssize_t t1,t2,temp1;

int main(int argc, char *argv[]) {

	fdw32 = open("/dev/xillybus_write_32", O_WRONLY);
//	fdw32_2 = open("/dev/xillybus_write_32_p2", O_WRONLY);
	fdr32 = open("/dev/xillybus_read_32", O_RDONLY);
//	fdr32_2 = open("/dev/xillybus_read_32_p2", O_RDONLY);

	N = atoi(argv[1]);

	if (fdw32 < 0 || fdr32 < 0) {
		perror("Failed to open devfiles");
		exit(1);
	}

	//allocate memory
	array_input = (int*) malloc(N*sizeof(int));
	array_hardware = (int*) malloc(N*sizeof(int));

	printf("Malloc Finished\n\r");
	
//	array_hardware_B = (int*) malloc(N*sizeof(int));

//	gettimeofday(&tv1, NULL);
	// generate inputs and prepare outputs
	for(i=0; i<N; i++){
		array_input[i] = i;
		array_hardware[i] = 0;
//		array_hardware_B[i] = 0;
	}
	gettimeofday(&tstart, NULL);

//	printf("Initialization Finished\n\r");

	t1 = write(fdw32, array_input, sizeof(int)*N);
	temp1 = write(fdw32, NULL, 0);

//	printf("Write data Finished\n\r");
	gettimeofday(&tv1, NULL);
//	t3= read(fdr32_1, array_hardware_A, sizeof(int)*N);
//gettimeofday(&tv3, NULL);

//	t2 = write(fdw32_2, array_input, sizeof(int)*N);
//	temp2 = write(fdw32_2, NULL, 0);
//gettimeofday(&tv2, NULL);
//	t4= read(fdr32_2, array_hardware_B, sizeof(int)*N);
//gettimeofday(&tv4, NULL);

	t2= read(fdr32, array_hardware, sizeof(int)*N);
	
	printf("Read data Finished\n\r");
//gettimeofday(&tv3, NULL);
//	t4= read(fdr32_2, array_hardware_B, sizeof(int)*N);
//gettimeofday(&tv4, NULL);

	gettimeofday(&tend, NULL);
	printf("Round trip time = %f Microseconds\n\r", (double)1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec));
	printf("Round trip bandwidth = %f MB/s\n\r",(double)N*4/((double)1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec)));

	printf("Write time = %f Microseconds\n\r", (double)1000000*(tv1.tv_sec-tstart.tv_sec)+(tv1.tv_usec-tstart.tv_usec));
	printf("Write bandwith = %f MB/s\n\r", (double)N*4/((double)1000000*(tv1.tv_sec-tstart.tv_sec)+(tv1.tv_usec-tstart.tv_usec)));

//	printf("Writing FIFO 2 spend %f us\n\r", (double)1000000*(tv2.tv_sec-tstart.tv_sec)+(tv2.tv_usec-tstart.tv_usec));
	printf("Read time = %f Microseconds\n\r", (double)1000000*(tend.tv_sec-tv1.tv_sec)+(tend.tv_usec-tv1.tv_usec));
	printf("Read bandwidth = %f MB/s\n\r", (double)N*4/((double)1000000*(tend.tv_sec-tv1.tv_sec)+(tend.tv_usec-tv1.tv_usec)));

//	printf("Reading FIFO 2 spend %f us\n\r", (double)1000000*(tv4.tv_sec-tstart.tv_sec)+(tv4.tv_usec-tstart.tv_usec));

	for(i=0; i<N; i++){
		printf("o/p from host is %d , o/p from device is %d\n\r", array_input[i], array_hardware[i]);
	}

	return 0;
}
