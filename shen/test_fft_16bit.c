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

int N = 0;
int i;
short *array_input;
short *array_hardware_A;
short *array_hardware_B;
short *array_hardware_C;
short *array_hardware_D;
struct timeval tv1, tv2;
ssize_t t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,temp1,temp2,temp3,temp4,temp5,temp6;

int main(int argc, char *argv[]) {
	// check right no of input args
//	if (argc!=7) {
//		fprintf(stderr, "Usage: %d devfile\n", argc);
//		exit(1);
//	}

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


	N = atoi(argv[1]);

	if (fdw16_1<0 || fdw16_2<0 || fdw16_3<0 || fdw16_4<0 || fdw16_5<0 || fdw16_6<0 || fdr16_1<0 || fdr16_2<0 || fdr16_3<0 || fdr16_4<0) {
		perror("Failed to open devfiles");
		exit(1);
	}

	//allocate memory
	array_input = (short*) malloc(N*sizeof(short));
	array_hardware_A = (short*) malloc(N*sizeof(short));
	array_hardware_B = (short*) malloc(N*sizeof(short));
        array_hardware_C = (short*) malloc(N*sizeof(short));
        array_hardware_D = (short*) malloc(N*sizeof(short));

	gettimeofday(&tv1, NULL);
	// generate inputs and prepare outputs
	for(i=0; i<N; i++){
		array_input[i] = i;
		array_hardware_A[i] = 0;
		array_hardware_B[i] = 0;
                array_hardware_C[i] = 0;
                array_hardware_D[i] = 0;
	}
	gettimeofday(&tv1, NULL);
	printf("start\n\r");
	t1 = write(fdw16_1, array_input, sizeof(short)*N);
	temp1 = write(fdw16_1, NULL, 0);
	t2 = write(fdw16_2, array_input, sizeof(short)*N);
	temp2 = write(fdw16_2, NULL, 0);
	t3 = write(fdw16_3, array_input, sizeof(short)*N);
	temp3 = write(fdw16_3, NULL, 0);
	t4 = write(fdw16_4, array_input, sizeof(short)*N);
        temp4 = write(fdw16_4, NULL, 0);
        t5 = write(fdw16_5, array_input, sizeof(short)*N);
        temp5 = write(fdw16_5, NULL, 0);
        t6 = write(fdw16_6, array_input, sizeof(short)*N);
        temp6 = write(fdw16_6, NULL, 0);

	printf("finish write\n\r");
	t7= read(fdr16_1, array_hardware_A, sizeof(short)*N);
	t8= read(fdr16_2, array_hardware_B, sizeof(short)*N);
        t9= read(fdr16_3, array_hardware_C, sizeof(short)*N);
        t10= read(fdr16_4, array_hardware_D, sizeof(short)*N);

	gettimeofday(&tv2, NULL);
	//printf("Execution time %f us in SW--\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));
	printf("%f\n\r", (double)(tv2.tv_usec - tv1.tv_usec));// / 1000000 + (double)(tv2.tv_sec - tv1.tv_sec));

	for(i=0; i<N; i++){
		printf("o/p from p1 is %d\n\r",array_hardware_A[i]);
		printf("o/p from p2 is %d\n\r",array_hardware_B[i]);
                printf("o/p from p3 is %d\n\r",array_hardware_C[i]);
                printf("o/p from p4 is %d\n\r",array_hardware_D[i]);
	}

	return 0;
}

