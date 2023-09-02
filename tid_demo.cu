#include<stdio.h>
#include<cuda.h>
__global__ void myKernel(int *d_a)
{
    int tx = threadIdx.x;
    d_a[tx] += 1;
    printf("Hello, world from the device!\n");
}
int main()
{
    int *a = (int *)malloc(sizeof(int) * 10);
    int *d_a;
    int i;
    for (i = 0; i < 10; i++)
        a[i] = i;
    for (i = 0; i < 10; i++)
        printf("%d,", a[i]);
    printf("\n");
    cudaMalloc((void **)&d_a, 10 * sizeof(int));
    cudaMemcpy(d_a, a, 10 * sizeof(int), cudaMemcpyHostToDevice);
    myKernel<<<1, 10>>>(d_a);
    cudaMemcpy(a, d_a, 10 * sizeof(int), cudaMemcpyDeviceToHost);
    for (i = 0; i < 10; i++)
        printf("%d,", a[i]);
    printf("\n");

    cudaFree(d_a);
}
