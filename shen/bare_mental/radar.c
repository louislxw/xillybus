#include <stdio.h>
#include <math.h>
#include <sys/time.h>
#include <time.h> 

int foo()
{
	int i[12];
	int o[2];
	int t_1 = i[0]*i[1];
	int t_2 = i[1]*i[2];
	int t_3 = i[3]*i[4];
	int t_4 = i[4]*i[5];
	
	int t_5 = i[6]*i[7];
	int t_6 = i[7]*i[8];
	int t_7 = i[9]*i[10];
	int t_8 = i[10]*i[11];
	
	int temp_1 = t_1 + t_2;
	int temp_2 = t_3 + t_4;
	int temp_3 = t_1 - t_2;
	int temp_4 = t_3 - t_4;
	
	int temp_5 = t_5 + t_6;
    int temp_6 = t_7 + t_8;
    int temp_7 = t_5 - t_6;
    int temp_8 = t_7 - t_8;
	
 	o[0] = temp_1 + temp_2 + temp_3 + temp_4;
 	o[1] = temp_5 + temp_6 + temp_7 + temp_8;
}

int main(int argc, char *argv[])
{

    	struct timeval tstart,tend;
    	int tUsed;    	
	int i,N;
 	int result;
	
	N = atoi(argv[1]);

	gettimeofday(&tstart,NULL);

	for (i=0;i<N;i++)
	{
		result = foo();
	}

	gettimeofday(&tend,NULL);

    	tUsed = 1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec);	//time in us

    	printf("time elapsed is %d us\r\n",tUsed);
	

    return 0;
}
