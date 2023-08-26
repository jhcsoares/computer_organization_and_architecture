#include<stdio.h>

void bubble_sort(int *a, int n)
{
    int k=n-1;
    int i=0;

    while(k>0)
    {
        for(i=0; i<k; i++)
        {
            if(a[i]>a[i+1])
            {
                int aux=a[i];
                a[i]=a[i+1];
                a[i+1]=aux;
            }
        }
        k--;
    }
}
