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

#define VP void*
#define NTH 2

int fdr32 = 0;
int fdw32 = 0;
int fdr32_1 = 0;
int fdw32_1 = 0;
int N = 0;
int i;
int *array_input_1;
int *array_hardware_1;

int *array_input_2;
int *array_hardware_2;

struct timeval tv1, tv2;
ssize_t r1,r2 ,w1,w2, t1,t2;

VP sample_1(VP arg);
VP sample_2(VP arg);

VP sample_1(VP arg) {
	// check right no of input args
/*	if (argc!=6) {
		fprintf(stderr, "Usage: %d devfile\n", argc);
		exit(1);
	}
*/	N = 32;
	gettimeofday(&tv1, NULL);

	w1 = write(fdw32, array_input_1, sizeof(int)*N);
	t1 = write(fdw32, NULL, 0);
	//w2 = write(fdw32_1, array_input, sizeof(int)*N);
	//t2 = write(fdw32_1, NULL, 0);

	r1 = read(fdr32, array_hardware_1, sizeof(int)*N);
        //r2 = read(fdr32_1, array_hardware, sizeof(int)*N);

	gettimeofday(&tv2, NULL);
	//printf("Execution time %f us in SW--\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
	printf("%f\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));

	//int i;
	//for(i=0;i<N;i++){
	//	printf("Data = %d\n\r", array_hardware[i]);
	//}

	pthread_exit(NULL);
	//return 0;
}


VP sample_2(VP arg) {
        // check right no of input args
/*      if (argc!=6) {
                fprintf(stderr, "Usage: %d devfile\n", argc);
                exit(1);
        }
*/      N = 32;
        gettimeofday(&tv1, NULL);

        //w1 = write(fdw32, array_input, sizeof(int)*N);
        //t1 = write(fdw32, NULL, 0);
        w2 = write(fdw32_1, array_input_2, sizeof(int)*N);
        t2 = write(fdw32_1, NULL, 0);

        //r1 = read(fdr32, array_hardware, sizeof(int)*N);
        r2 = read(fdr32_1, array_hardware_2, sizeof(int)*N);

        gettimeofday(&tv2, NULL);
        //printf("Execution time %f us in SW--\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
        printf("%f\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));

        //int i;
        //for(i=0;i<N;i++){
        //        printf("Data = %d\n\r", array_hardware[i]);
        //}

        pthread_exit(NULL);
        //return 0;
}

/*VP sample(VP arg);
VP sample(VP arg)
{
    int *val;
    int i=0;
    val = (int*)arg;
    while(i<2)
    {
    printf("\n I am a thread having id %d , %d\n", *val, i);
    i++;
    }
    pthread_exit(NULL);
}
*/

int main(void)
{

        fdr32 = open("/dev/xillybus_read_32", O_RDONLY);
        fdw32 = open("/dev/xillybus_write_32", O_WRONLY);
        fdr32_1 = open("/dev/xillybus_read_32_1", O_RDONLY);
        fdw32_1 = open("/dev/xillybus_write_32_1", O_WRONLY);
        N = 32;
        if (fdr32 < 0 || fdw32 < 0 || fdr32_1 < 0 || fdw32_1 < 0) {
                perror("Failed to open devfiles");
                exit(1);
        }

        //allocate memory
        array_input_1 = (int*) malloc(N*sizeof(int));
        array_hardware_1 = (int*) malloc(N*sizeof(int));
        array_input_2 = (int*) malloc(N*sizeof(int));
        array_hardware_2 = (int*) malloc(N*sizeof(int));

        gettimeofday(&tv1, NULL);
        // generate inputs and prepare outputs
        for(i=0; i<N; i++){
                array_input_1[i] = i;
                array_input_2[i] = i;
                array_hardware_1[i] = 0;
                array_hardware_2[i] = 0;

        }


    pthread_t tid[NTH];
    int loop=0;
    int value[NTH]={1,2};
    printf("\n Going to create threads \n");
    /** Creation of threads*/
    //for(loop=0;loop<NTH;loop++)
    //{
        pthread_create(&tid[loop], NULL, &sample_1, &value[loop]);
        printf("\n value of loop = %d\n", loop);
    //}
        pthread_create(&tid[loop], NULL, &sample_2, &value[loop]);
        printf("\n value of loop = %d\n", loop);
    /** Synch of threads in order to exit normally*/
    for(loop=0;loop<NTH;loop++)
    {
        pthread_join(tid[loop], NULL);
    }

	int i;
        for(i=0;i<N;i++){
                printf("Data = %d %d\n\r", array_hardware_1[i], array_hardware_2[i]);
        }


    
    
    return EXIT_SUCCESS;
}
