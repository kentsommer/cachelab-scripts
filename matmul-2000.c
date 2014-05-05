#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>

#define M 2000
#define N 2000
#define K 2000
#define alpha 1
#define beta 1

#pragma declarations
double A[M][K];
double B[K][N];
double C[M][N];
#pragma enddeclarations

#ifdef PERFCTR
#include "papiStdEventDefs.h"
#include <papi.h>
#include "papi_defs.h"
#endif

#include "util.h"

double t_start, t_end;

int main()
{
    int i, j, k;

    init_array();

#ifdef PERFCTR
    PERF_INIT; 
#endif

t_start = rtclock();

    for(i=0; i<M; i++)
       for(j=0; j<N; j++)  
         for(k=0; k<K; k++)
                C[i][j] = beta*C[i][j] + alpha*A[i][k] * B[k][j];

t_end = rtclock();
fprintf(stderr, "%0.6lfs\n", t_end - t_start);

#ifdef PERFCTR
    PERF_EXIT; 
#endif

  if (fopen(".test", "r")) {
    print_array();
  }

  return 0;
}
