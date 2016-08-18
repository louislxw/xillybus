#include <stdio.h>
#include <stdlib.h>

#define N 50

int main(int argc, char *argv[]) { 

FILE *fin;
float a[N];
int b[N]={0};//counter
int i,j,max;
//printf("%s\n", argv[1]);
fin = fopen(argv[1], "r");		

for (i=0;i<N;i++)
fscanf(fin,"%f \n\r", &a[i]);  		
fclose(fin);  

//for (i=0;i<200;i++) printf("%f \n\r",a[i]);   	

for(i=0;i<N-1;i++)
{
	for(j=i+1;j<N;j++)
	{
		if(a[i]==a[j])
    		{
			b[i]++;
		}	
	}
}  	
   		
//for (i=0;i<200;i++) printf("%d \n\r",b[i]);

 max=b[0];
 for(i=1;i<N;i++)
  if(b[i]>max)
   max=b[i];
 for(i=0;i<N;i++)
   if(max==b[i])
  printf("Most recorded rtt value is %f, recorded %d times\n",a[i],b[i]+1);
return 0;
}
