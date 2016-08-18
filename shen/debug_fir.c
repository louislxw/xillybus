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

int fdr32 = 0;
int fdw32 = 0;
int N = 0;
int i;
int *array_input;
int *array_hardware;
struct timeval tv1, tv2;
ssize_t t1,t2, temp;

int main(int argc, char *argv[]) {

	fdr32 = open("/dev/xillybus_read_32", O_RDONLY);
	fdw32 = open("/dev/xillybus_write_32", O_WRONLY);
	N = atoi(argv[1]);
	if (fdr32 < 0 || fdw32 < 0) {
		perror("Failed to open devfiles");
		exit(1);
	}

	//allocate memory
	array_input = (int*) malloc(N*sizeof(int));
	array_hardware = (int*) malloc(N*sizeof(int));

	gettimeofday(&tv1, NULL);
	// generate inputs and prepare outputs
	for(i=0; i<N; i++){
		array_input[i] = i;
		array_hardware[i] = 0;

	}
	gettimeofday(&tv1, NULL);
	t1=write(fdw32, array_input, sizeof(int)*N);
	temp = write(fdw32, NULL, 0);
	t2= read(fdr32,array_hardware, sizeof(int)*N);
	gettimeofday(&tv2, NULL);
	//printf("Execution time %f us in SW--\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
	printf("%f\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));

//	int success = 1;
//	for(i=0;i<N;i++){
//		if(array_input[i]!= array_hardware[i]){
//			success = 0;
//		}
//		//printf("read ID %d :%d \n\r",i,array_hardware[i]);
//	}
//
//	if (success == 1)
//		printf("Test is successful!!\n\r");
//	else
//		printf("Test is unsuccessful!\n\r");
//
	return 0;
}

