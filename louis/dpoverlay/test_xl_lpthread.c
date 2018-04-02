/** Simple multi-threaded application explains how to create apps with multiple
 * threads and also explains about how to deal with args parameter of pthread_create
 * Owner Manikandan Govindarajan <govi0009@e.ntu.edu.sg>
 */
#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdint.h>
#include <sys/time.h>
#include "timer.h"

#define VP void*
#define NTH 2

int fdw32 = 0;
int fdr32 = 0;

int N = 0;
int i;

int *array_input;
int *array_hardware;

struct timeval tv1,tv2;
ssize_t w,e,r;

//GET_TIME_INIT(2);
/*
VP sample_1(VP arg);
VP sample_2(VP arg);

VP sample_1(VP arg) {
	w = write(fdw32, array_input, sizeof(int)*N);
	e = write(fdw32, NULL, 0);
	pthread_exit(NULL);
}

VP sample_2(VP arg) {
        r = read(fdr32, array_hardware, sizeof(int)*N);
        pthread_exit(NULL);
}
*/

//int main(void)
int main(int argc, char *argv[])
{
        fdw32 = open("/dev/xillybus_write_128", O_WRONLY);
        fdr32 = open("/dev/xillybus_read_128", O_RDONLY);

	N = atoi(argv[1]);
//	N = N*4;

        if (fdw32<0 || fdr32<0) {
                perror("Failed to open devfiles");
                exit(1);
        }

	//Initialize timer
	GET_TIME_INIT(2);

        //allocate memory
        array_input = (int*) malloc(N*sizeof(int));
        array_hardware = (int*) malloc(N*sizeof(int));

        // generate inputs and prepare outputs
        for(i=0; i<N; i++){
                array_input[i] = i;
                array_hardware[i] = 0;
        }


	VP sample_1(VP arg) {
        	w = write(fdw32, array_input, sizeof(int)*N);
        	e = write(fdw32, NULL, 0);
        	pthread_exit(NULL);
	}

	VP sample_2(VP arg) {
        	r = read(fdr32, array_hardware, sizeof(int)*N);
        	pthread_exit(NULL);
	}

	pthread_t tid[NTH];
	int loop = 0;
	int value[NTH] = {1,2};
	//printf("\n Going to create threads \n");
	/** Creation of threads*/

/*	for(loop=0; loop<NTH; loop++) {
		pthread_create(&tid[loop], NULL, &sample, &value[loop]);
		printf("\n value of loop = %d\n", loop);
	}
*/
	//gettimeofday(&tv1, NULL);
	pthread_create(&tid[0], NULL, &sample_1, &value[0]);
       	//printf("\n value of loop = %d\n", 0);
	
	pthread_create(&tid[1], NULL, &sample_2, &value[1]);
        //printf("\n value of loop = %d\n", 1);

	/** Synch of threads in order to exit normally*/
//	gettimeofday(&tv1, NULL);
	GET_TIME_VAL(0);
	for(loop=0; loop<NTH; loop++) {
		pthread_join(tid[loop], NULL);
	}
//	gettimeofday(&tv2, NULL);
	GET_TIME_VAL(1);

        printf("round-trip time: %f us\n\r", (TIME_VAL_TO_MS(1) - TIME_VAL_TO_MS(0))*1000.0);
        printf("overall bw: %f MB/s\n\r", N*4.0/1024/1024/((TIME_VAL_TO_MS(1) - TIME_VAL_TO_MS(0))/1000.0));


//	printf("%f\n\r", (double)1000000*(tv2.tv_sec-tv1.tv_sec)+(tv2.tv_usec-tv1.tv_usec));

//      for(i=0; i<N/4; i++){
//              printf("i/p is %d , o/p is %d \n\r",array_input[i],array_hardware[i]);
//      }
	
	close(fdw32);
	close(fdr32);

	free(array_input);
	free(array_hardware);
		
	return EXIT_SUCCESS;
//	pthread_exit(NULL);
}
