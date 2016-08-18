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

short fdw16_1 = 0;
short fdw16_2 = 0;
short fdw16_3 = 0;
short fdw16_4 = 0;
short fdw16_5 = 0;
short fdw16_6 = 0;

short fdr16_1 = 0;
short fdr16_2 = 0;
short fdr16_3 = 0;
short fdr16_4 = 0;

short N = 0;
short i;
//int *array_input;
//int *array_hardware;

short *array_input;
short *array_hardware_1;
short *array_hardware_2;
short *array_hardware_3;
short *array_hardware_4;

struct timeval tv1,tv2;
ssize_t w1,w2,w3,w4,w5,w6;
ssize_t e1,e2,e3,e4,e5,e6;
ssize_t r1,r2,r3,r4;

VP sample_1(VP arg);
VP sample_2(VP arg);

VP sample_1(VP arg) {
	// check right no of input args
/*	if (argc!=6) {
		fprintf(stderr, "Usage: %d devfile\n", argc);
		exit(1);
	}
*/
	N = 10000;
	//N = atoi(argv[1]);

/*	if (fdw16_1<0 || fdw16_2<0 || fdw16_3<0 || fdw16_4<0 || fdw16_5<0 || fdw16_6<0 || fdr16_1<0 || fdr16_2<0 || fdr16_3<0 || fdr16_4<0) {
		perror("Failed to open devfiles");
		exit(1);
	}
*/
	gettimeofday(&tv1, NULL);

	w1 = write(fdw16_1, array_input, sizeof(short)*N);
	e1 = write(fdw16_1, NULL, 0);
	w2 = write(fdw16_2, array_input, sizeof(short)*N);
	e2 = write(fdw16_2, NULL, 0);
	w3 = write(fdw16_3, array_input, sizeof(short)*N);
        e3 = write(fdw16_3, NULL, 0);
        w4 = write(fdw16_4, array_input, sizeof(short)*N);
        e4 = write(fdw16_4, NULL, 0);
	w5 = write(fdw16_5, array_input, sizeof(short)*N);
        e5 = write(fdw16_5, NULL, 0);
        w6 = write(fdw16_6, array_input, sizeof(short)*N);
        e6 = write(fdw16_6, NULL, 0);

	r1 = read(fdr16_1, array_hardware_1, sizeof(short)*N);
        r2 = read(fdr16_2, array_hardware_2, sizeof(short)*N);

	gettimeofday(&tv2, NULL);
	//printf("Execution time %f us in SW--\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
	printf("%f\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
	pthread_exit(NULL);
	//return 0;
}

VP sample_2(VP arg) {
        // check right no of input args
/*      if (argc!=6) {
                fprintf(stderr, "Usage: %d devfile\n", argc);
                exit(1);
        }
*/
        N = 10000;
        //N = atoi(argv[1]);

/*      if (fdw16_1<0 || fdw16_2<0 || fdw16_3<0 || fdw16_4<0 || fdw16_5<0 || fdw16_6<0 || fdr16_1<0 || fdr16_2<0 || fdr16_3<0 || fdr16_4<0) {
                perror("Failed to open devfiles");
                exit(1);
        }
*/
        gettimeofday(&tv1, NULL);
	
//        r1 = read(fdr16_1, array_hardware_1, sizeof(short)*N);
//        r2 = read(fdr16_2, array_hardware_2, sizeof(short)*N);
        r3 = read(fdr16_3, array_hardware_3, sizeof(short)*N);
        r4 = read(fdr16_4, array_hardware_4, sizeof(short)*N);

        gettimeofday(&tv2, NULL);
        //printf("Execution time %f us in SW--\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
        printf("%f\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
        pthread_exit(NULL);
        //return 0;
}

int main(void)
//int main(int argc, char *argv[])
{
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

        N = 10000;
        //N = atoi(argv[1]);

        if (fdw16_1<0 || fdw16_2<0 || fdw16_3<0 || fdw16_4<0 || fdw16_5<0 || fdw16_6<0 || fdr16_1<0 || fdr16_2<0 || fdr16_3<0 || fdr16_4<0) {
                perror("Failed to open devfiles");
                exit(1);
        }

        //allocate memory
        array_input = (short*) malloc(N*sizeof(short));
        array_hardware_1 = (short*) malloc(N*sizeof(short));
        array_hardware_2 = (short*) malloc(N*sizeof(short));
        array_hardware_3 = (short*) malloc(N*sizeof(short));
        array_hardware_4 = (short*) malloc(N*sizeof(short));

        gettimeofday(&tv1, NULL);
        // generate inputs and prepare outputs
        for(i=0; i<N; i++){
                array_input[i] = i;
                array_hardware_1[i] = 0;
                array_hardware_2[i] = 0;
                array_hardware_3[i] = 0;
                array_hardware_4[i] = 0;
        }

	pthread_t tid[NTH];
	int loop=0;
	int value[NTH]={1,2};
	printf("\n Going to create threads \n");
	/** Creation of threads*/

	pthread_create(&tid[loop], NULL, &sample_1, &value[loop]);
       	printf("\n value of loop = %d\n", loop);
	
	pthread_create(&tid[loop], NULL, &sample_2, &value[loop]);
        printf("\n value of loop = %d\n", loop);

	/** Synch of threads in order to exit normally*/
	for(loop=0;loop<NTH;loop++) {
		pthread_join(tid[loop], NULL);
	}
   
//        for(i=0;i<5;i++){
//                printf("Data = %d  %d  %d  %d\n\r", array_hardware_1[i], array_hardware_2[i],array_hardware_3[i], array_hardware_4[i]);
//        }

 
	return EXIT_SUCCESS;
//	pthread_exit(NULL);
}
