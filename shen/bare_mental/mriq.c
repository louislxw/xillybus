#include <stdio.h>
#include <math.h>
#include <sys/time.h>
#include <time.h> 

int foo()
{
	int i[11];
	int o[2];
	int temp_1 = i[9] | i[10];
	int temp_2 = i[6]*(i[0]*i[1] + i[2]*i[3] + i[4]*i[5]);
	o[0] = temp_1*(temp_2+i[7]);
	o[1] = temp_1*(temp_2+i[8]);
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
