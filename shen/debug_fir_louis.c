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
int fdr32_1 = 0;
int fdw32_1 = 0;
int N = 0;
int i;
int *array_input;
int *array_hardware;
struct timeval tv1, tv2;
ssize_t r1,r2,w1,w2, t1,t2;

int main(int argc, char *argv[]) {
	// check right no of input args
	if (argc!=6) {
		fprintf(stderr, "Usage: %d devfile\n", argc);
		exit(1);
	}

	fdr32 = open(argv[1], O_RDONLY);
	fdw32 = open(argv[2], O_WRONLY);
	fdr32_1 = open(argv[3], O_RDONLY);
        fdw32_1 = open(argv[4], O_WRONLY);
	N = atoi(argv[5]);
	if (fdr32 < 0 || fdw32 < 0 || fdr32_1 < 0 || fdw32_1 < 0) {
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
	w1 = write(fdw32, array_input, sizeof(int)*N);
	t1 = write(fdw32, NULL, 0);
//	r1 = read(fdr32, array_hardware, sizeof(int)*N);

	w2 = write(fdw32_1, array_input, sizeof(int)*N);
	t2 = write(fdw32_1, NULL, 0);
	r1 = read(fdr32, array_hardware, sizeof(int)*N);
        r2 = read(fdr32_1, array_hardware, sizeof(int)*N);

	gettimeofday(&tv2, NULL);
	//printf("Execution time %f us in SW--\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
	printf("%f\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));

	return 0;
}

