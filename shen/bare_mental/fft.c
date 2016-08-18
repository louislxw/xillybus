#include <stdio.h>
#include <math.h>
#include <sys/time.h>
#include <time.h> 

int foo()
{
	int i[6];
	int o[4];
	int temp_1 = i[1]*i[2] + i[3]*i[4];
	int temp_3 = i[1]*i[4] - i[3]*i[2];
	

	o[0] = i[0] - temp_1;
	o[1] = i[0] + temp_1;
	o[2] = i[5] - temp_3;
	o[3] = i[5] + temp_3;
}

int main(int argc, char *argv[])
{

    	struct timeval tstart,tend;
    	int tUsed;    	
	int i,N;
	int in3, in14, in5, in16, in7, in18, in9, in20, in11, in22, in35, in46, in47, in58, in59, in70;
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
