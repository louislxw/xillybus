#include <stdio.h>
#include <math.h>
#include <sys/time.h>
#include <time.h> 

int foo(int in3,int in14,int in5,int in16,int in7,int in18,int in9,int in20,int in11,int in22,int in35,int in46,int in47,int in58,int in59,int in70)
{
	int temp_1 = in3 - in14;
	int temp_2 = in5 - in16;
	int temp_3 = in7 - in18;
	int temp_4 = in9 - in20;
	int temp_5 = in11 - in22;
	int temp_6 = in35 - in46;
	int temp_7 = in47 - in58;
	int temp_8 = in59 - in70;
 	return (temp_1*temp_1 + temp_2*temp_2 + temp_3*temp_3 + temp_4*temp_4 + temp_5*temp_5 + temp_6*temp_6 + temp_7*temp_7 + temp_8*temp_8);
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
		result = foo(in3, in14, in5, in16, in7, in18, in9, in20, in11, in22, in35, in46, in47, in58, in59, in70);
	}

	gettimeofday(&tend,NULL);

    	tUsed = 1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec);	//time in us

    	printf("time elapsed is %d us\r\n",tUsed);
	

    return 0;
}
