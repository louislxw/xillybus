#include <stdio.h>
#include <math.h>
#include <sys/time.h>
#include <time.h> 

int foo(int in1,int in3,int in4,int in15,int in5,int in7,int in9,int in18,int in14,int in24,int in19,int in28,int in25,int in34,int in29,int in38)
{
	int temp_1 = in1 * in3;
	int temp_2 = in4 * in15;
	int temp_3 = in5 * in7;
	int temp_4 = in9 * in18;
	int temp_5 = in14 * in24;
	int temp_6 = in19 * in28;
	int temp_7 = in25 * in34;
	int temp_8 = in29 * in38;
 	return (temp_1 + temp_2 + temp_3 + temp_4 + temp_5 + temp_6 + temp_7 + temp_8);	
}

int main(int argc, char *argv[])
{

    	struct timeval tstart,tend;
    	int tUsed;    	
	int i,N;
 	int in1, in3, in4, in15, in5, in7, in9, in18, in14, in24, in19, in28, in25, in34, in29, in38;
	int result;
	
	N = atoi(argv[1]);

	gettimeofday(&tstart,NULL);

	for (i=0;i<N;i++)
	{
		result = foo(in1, in3, in4, in15, in5, in7, in9, in18, in14, in24, in19, in28, in25, in34, in29, in38);
	}

	gettimeofday(&tend,NULL);

    	tUsed = 1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec);	//time in us

    	printf("time elapsed is %d us\r\n",tUsed);
	

    return 0;
}
