
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <mpi.h>

int* random_arr(int size, int min, int max) {
    int *arr = calloc(size, sizeof(int));
    for(int i = 0; i < size; i++) {
        arr[i] = min + rand() % ((max + 1) - min);
    }
    return arr;
}

void print_arr(int *arr, int n) {
    for(int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }

    printf("\n");
}

void send_sort(int rank, int tag, int *arr, int n, int max_rank) {
    
    MPI_Send(arr, n, MPI_INT, rank, tag, MPI_COMM_WORLD);
    MPI_Send(&max_rank, 1, MPI_INT, rank, tag, MPI_COMM_WORLD);

}
void recv_sort(int *source, int **arr, int *n, int *max_rank) {
    int count;
    MPI_Status status;

    MPI_Probe(MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &status);
    MPI_Get_count(&status, MPI_INT, &count);
    *n = count;
    *arr = calloc(count, sizeof(int));
    MPI_Recv(*arr, count, MPI_INT, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &status);

    MPI_Recv(max_rank, 1, MPI_INT, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &status);


    *source = status.MPI_SOURCE;
}

void send_array(int rank, int tag, int *arr, int n) {
    MPI_Send(arr, n, MPI_INT, rank, tag, MPI_COMM_WORLD);
}

void recv_array(int source, int **arr, int n) {
    
    MPI_Status status;
    MPI_Recv(*arr, n, MPI_INT, source, MPI_ANY_TAG, MPI_COMM_WORLD, &status);
}

int* merge_sort(int n, int *arr, int *buf, int l, int r, int rank, int max_rank) {
    if(l == r) {
        buf[l] = arr[l];
        return buf;
    }
    int m = (l+r)/2;

    int size;

    int *l_b;
    int *r_b;

    if(rank != max_rank) {
        int m_r = (max_rank+rank)/2;
        int size = r-m;
        send_sort(m_r+1, m_r+1, arr+m+1, size, max_rank);

        l_b = merge_sort(n, arr, buf, l, m, rank, m_r);

        int *of = l_b+m+1;
        recv_array(m_r+1, &of, size);
        r_b = l_b;

    } else {
        l_b = merge_sort(n, arr, buf, l, m, rank, max_rank);
        r_b = merge_sort(n, arr, buf, m+1, r, rank, max_rank);
    }
    
    int *t = l_b == arr ? buf : arr;

    int i1 = l, i2 = m+1;
    for(int i = l; i <= r; i++) {
        if(i1 <= m && i2 <= r ) {
            if(l_b[i1] < r_b[i2]) {
                t[i] = l_b[i1];
                i1++;
            } else {
                t[i] = r_b[i2];
                i2++;
            }
        } else {
            if(i1 <= m) {
                t[i] = l_b[i1];
                i1++;
            } else {
                t[i] = r_b[i2];
                i2++;
            }
        }
    }
    return t;
}


void master(int argc, char *argv[], int rank, int max_rank) {
    srand(time(NULL));
    if(argc < 2) {
        printf("Requires 1 argument: size of array\n");
        return;
    }
    
    int n = atoi(argv[1]);
    int p = 0;
    if(argc >= 3) {
        p = atoi(argv[2]);
    }

    int *arr = random_arr(n, -10000, 10000);
    int *tmp = random_arr(n, 0, 0);
    if(p) {
        print_arr(arr, n);
    }


    double starttime, endtime;
    starttime = MPI_Wtime();

    int *r = merge_sort(n, arr, tmp, 0, n-1, rank, max_rank);
    
    endtime = MPI_Wtime();
    printf("Work time %f sec\n", endtime-starttime);


    if(p) {
        print_arr(r, n);
    }


    free(tmp);
    free(arr);
    printf("end\n"); 


}
void slave() {
    int *arr;
    int *buf;
    int n, source, rank, max_rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    

    recv_sort(&source, &arr, &n, &max_rank);
    buf = calloc(n, sizeof(int));
    

    
    int *res = merge_sort(n, arr, buf, 0, n-1, rank, max_rank);
    send_array(source, rank, res, n);

    free(arr);
    free(buf);

}

int main(int argc, char *argv[]) {
    int rank, size;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    if(rank == 0) {
        master(argc, argv, 0, size-1);
    } else {
        slave();
    }
    
    

    MPI_Finalize();
    
    
    return 0;
}
