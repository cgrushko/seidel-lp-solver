#include <math.h>
#include <stdio.h>
#include "tol.h"
#include <stdlib.h>

int rand();
double pow();

int main(int argc,char *argv[])
{
	srand(time(NULL));
	int i, j, d, m;
	FLOAT x, z, fac;

	if(argc!=3) {
		fprintf(stderr,"incorrect arguments\n");
		exit(1);
	}
	d = atoi(argv[1]);
	m = atoi(argv[2]);
	printf("dimension: %d, number of planes: %d\n",d,m+1);
	printf("projective\n");
	for(i=0; i<d-1; i++) printf("0 ");
	printf("1\n");
	for(i=0; i<d; i++) printf("0 ");
	printf("1\n");
	fac = (FLOAT)RAND_MAX / 2;
	for(i=0; i<m; i++) {
		z = 0.0;
		for(j=0; j<d-1; j++) {
			x = rand()/fac - 1.0;
			x = (fabs(x) < 1.0e-5) ? 1.0e-5 : x ;
			z += x*x;
			printf("%f ",-2.0*x);
		}
		printf("1 %f\n",z);
	}
	return 0;
}
