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
#define NTH 9

short fdw16_1 = 0;
short fdw16_2 = 0;
short fdw16_3 = 0;
short fdw16_4 = 0;
short fdw16_5 = 0;
short fdw16_6 = 0;
short fdw16_7 = 0;
short fdw16_8 = 0;

short fdr16_1 = 0;

short N = 0;
short i;

short *array_input;
short *array_hardware_1;

struct timeval tv1,tv2;
ssize_t w1,w2,w3,w4,w5,w6,w7,w8;
ssize_t e1,e2,e3,e4,e5,e6,e7,e8;
ssize_t r1;

VP sample_1(VP arg);
VP sample_2(VP arg);
VP sample_3(VP arg);
VP sample_4(VP arg);
VP sample_5(VP arg);
VP sample_6(VP arg);
VP sample_7(VP arg);
VP sample_8(VP arg);
VP sample_9(VP arg);
VP sample_10(VP arg);

VP sample_1(VP arg) {

	w1 = write(fdw16_1, array_input, sizeof(short)*N);
	e1 = write(fdw16_1, NULL, 0);
	pthread_exit(NULL);
}

VP sample_2(VP arg) {

	w2 = write(fdw16_2, array_input, sizeof(short)*N);
	e2 = write(fdw16_2, NULL, 0);
	pthread_exit(NULL);
}

VP sample_3(VP arg) {

	w3 = write(fdw16_3, array_input, sizeof(short)*N);
        e3 = write(fdw16_3, NULL, 0);
	pthread_exit(NULL);
}

VP sample_4(VP arg) {

        w4 = write(fdw16_4, array_input, sizeof(short)*N);
        e4 = write(fdw16_4, NULL, 0);
        pthread_exit(NULL);
}

VP sample_5(VP arg) {

        w5 = write(fdw16_5, array_input, sizeof(short)*N);
        e5 = write(fdw16_5, NULL, 0);
        pthread_exit(NULL);
}
VP sample_6(VP arg) {

        w6 = write(fdw16_6, array_input, sizeof(short)*N);
        e6 = write(fdw16_6, NULL, 0);
        pthread_exit(NULL);
}
VP sample_7(VP arg) {

        w7 = write(fdw16_7, array_input, sizeof(short)*N);
        e7 = write(fdw16_7, NULL, 0);
        pthread_exit(NULL);
}

VP sample_8(VP arg) {

        w8 = write(fdw16_8, array_input, sizeof(short)*N);
        e8 = write(fdw16_8, NULL, 0);
        pthread_exit(NULL);
}

VP sample_9(VP arg) {

        r1 = read(fdr16_1, array_hardware_1, sizeof(short)*N);
        pthread_exit(NULL);
}


//int main(void)
int main(int argc, char *argv[])
{
        fdw16_1 = open("/dev/xillybus_write_32_p1", O_WRONLY);
        fdw16_2 = open("/dev/xillybus_write_32_p2", O_WRONLY);
        fdw16_3 = open("/dev/xillybus_write_32_p3", O_WRONLY);
	fdw16_4 = open("/dev/xillybus_write_32_p4", O_WRONLY);
        fdw16_5 = open("/dev/xillybus_write_32_p5", O_WRONLY);
        fdw16_6 = open("/dev/xillybus_write_32_p6", O_WRONLY);
        fdw16_7 = open("/dev/xillybus_write_32_p7", O_WRONLY);
        fdw16_8 = open("/dev/xillybus_write_32_p8", O_WRONLY);

        fdr16_1 = open("/dev/xillybus_read_32_p1", O_RDONLY);

	N = atoi(argv[1]);

        if (fdw16_1<0 || fdw16_2<0 || fdw16_3<0 ||fdw16_4<0 || fdw16_5<0 || fdw16_6<0 ||fdw16_7<0 || fdw16_8<0 || fdr16_1<0) {
                perror("Failed to open devfiles");
                exit(1);
        }

        //allocate memory
        array_input = (short*) malloc(N*sizeof(short));
        array_hardware_1 = (short*) malloc(N*sizeof(short));

        // generate inputs and prepare outputs
        for(i=0; i<N; i++){
                array_input[i] = i;
                array_hardware_1[i] = 0;
}

	pthread_t tid[NTH];
	int loop = 0;
	int value[NTH] = {1,2,3,4,5,6,7,8,9};
	//printf("\n Going to create threads \n");
	/** Creation of threads*/

/*	for(loop=0; loop<NTH; loop++) {
		pthread_create(&tid[loop], NULL, &sample, &value[loop]);
		printf("\n value of loop = %d\n", loop);
	}
*/
	pthread_create(&tid[0], NULL, &sample_1, &value[0]);
	pthread_create(&tid[1], NULL, &sample_2, &value[1]);
	pthread_create(&tid[2], NULL, &sample_3, &value[2]);
        pthread_create(&tid[3], NULL, &sample_4, &value[3]);
        pthread_create(&tid[4], NULL, &sample_5, &value[4]);
        pthread_create(&tid[5], NULL, &sample_6, &value[5]);
        pthread_create(&tid[6], NULL, &sample_7, &value[6]);
        pthread_create(&tid[7], NULL, &sample_8, &value[7]);
        pthread_create(&tid[8], NULL, &sample_9, &value[8]);

	/** Synch of threads in order to exit normally*/
	gettimeofday(&tv1, NULL);
	for(loop=0; loop<NTH; loop++) {
		pthread_join(tid[loop], NULL);
	}
	gettimeofday(&tv2, NULL);
	printf("%f\n\r", (double)1000000*(tv2.tv_sec-tv1.tv_sec)+(tv2.tv_usec-tv1.tv_usec));

	/*for(i=0; i<5; i++){
	printf("o/p from p1 is %d\n\r",array_hardware_1[i]);
                printf("o/p from p2 is %d\n\r",array_hardware_2[i]);
                printf("o/p from p3 is %d\n\r",array_hardware_3[i]);
                printf("o/p from p4 is %d\n\r",array_hardware_4[i]);
        }*/
	
	close(fdw16_1);
	close(fdw16_2);
	close(fdw16_3);
        close(fdw16_4);
        close(fdw16_5);
        close(fdw16_6);
        close(fdw16_7);
        close(fdw16_8);

	close(fdr16_1);

	free(array_input);
	free(array_hardware_1);
		
	return EXIT_SUCCESS;
//	pthread_exit(NULL);
}
