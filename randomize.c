int rand();
void randomize(int n,int *perm)
{
	int i, j, t;

	for(i=0; i<n; i++) {
		j = rand()%(n-i)+i;
		t = perm[j];
		perm[j] = perm[i];
		perm[i] = t;
	}
}
