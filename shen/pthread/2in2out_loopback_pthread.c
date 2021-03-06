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

#define NTH 4

int fdw32_1 = 0;
int fdw32_2 = 0;

int fdr32_1 = 0;
int fdr32_2 = 0;

int N = 0;
int i;
int *array_input;
int *array_hardware_1;
int *array_hardware_2;
struct timeval tstart,tend,tv1, tv2;
ssize_t w1,w2,e1,e2,r1,r2;

void *sample_1(void *arg);
void *sample_2(void *arg);
void *sample_3(void *arg);
void *sample_4(void *arg);


void *sample_1(void *arg) {

	w1 = write(fdw32_1, array_input, sizeof(int)*N);
	e1 = write(fdw32_1, NULL, 0);
	pthread_exit(NULL);
}

void *sample_2(void *arg) {

	w2 = write(fdw32_2, array_input, sizeof(int)*N);
        e2 = write(fdw32_2, NULL, 0);
        pthread_exit(NULL);
}

void *sample_3(void *arg) {

        r1 = read(fdr32_1, array_hardware_1, sizeof(int)*N);
        pthread_exit(NULL);
}

void *sample_4(void *arg) {

        r2 = read(fdr32_2, array_hardware_1, sizeof(int)*N);
        pthread_exit(NULL);
}

int main(int argc, char *argv[]) {

	fdw32_1 = open("/dev/xillybus_write_32_p1", O_WRONLY);
	fdw32_2 = open("/dev/xillybus_write_32_p2", O_WRONLY);
	fdr32_1 = open("/dev/xillybus_read_32_p1", O_RDONLY);
	fdr32_2 = open("/dev/xillybus_read_32_p2", O_RDONLY);

	N = atoi(argv[1]);

	if (fdw32_1 < 0 || fdw32_2 < 0 || fdr32_1 < 0 || fdr32_2 < 0) {
		perror("Failed to open devfiles");
		exit(1);
	}

	//allocate memory
	array_input = (int*) malloc(N*sizeof(int));
	array_hardware_1 = (int*) malloc(N*sizeof(int));
	array_hardware_2 = (int*) malloc(N*sizeof(int));

	gettimeofday(&tv1, NULL);
	// generate inputs and prepare outputs
	for(i=0; i<N; i++){
		array_input[i] = 1;	//i;
		array_hardware_1[i] = 0;
		array_hardware_2[i] = 0;
	}

	pthread_t tid[NTH];
	int loop = 0;
	int value[NTH] = {1,2,3,4};
	/** Creation of threads*/

	pthread_create(&tid[0], NULL, &sample_1, &value[0]);
	
	pthread_create(&tid[1], NULL, &sample_2, &value[1]);

	pthread_create(&tid[2], NULL, &sample_3, &value[2]);

        pthread_create(&tid[3], NULL, &sample_4, &value[3]);

	/** Synch of threads in order to exit normally*/
	gettimeofday(&tstart, NULL);
	for(loop=0; loop<NTH; loop++) {
		pthread_join(tid[loop],NULL);
	}
	gettimeofday(&tend, NULL);
	printf("%f\n\r", (double)1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec));

//	for(i=0; i<N; i++){
//		printf("o/p from p1 is %d , o/p from p2 is %d\n\r",array_hardware_1[i],array_hardware_2[i]);
//	}

	return EXIT_SUCCESS;
}
