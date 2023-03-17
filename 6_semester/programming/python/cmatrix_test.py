import time
from cmatrix.cmatrix import cmultiply
from matrix.matrix import multiply
from matrix.random import get_random_matrix




def test(num, n1, m1, n2, m2):
    m1 = get_random_matrix(n1, m1)
    m2 = get_random_matrix(n2, m2)
    print(f"{num} test:")
    start_time = time.time()
    r1_2 = multiply(m1, m2);
    print("multiply: %s seconds " % (time.time() - start_time))

    start_time = time.time()
    r1_1 = cmultiply(m1, m2);
    print("cmultiply: %s seconds " % (time.time() - start_time))
    if r1_2 != r1_1:
        print("Not equal!")




if __name__ == "__main__":
    test(1, 10, 100, 100, 10)
    test(2, 50, 100, 100, 50)
    test(3, 100, 200, 200, 100)
    test(4, 100, 300, 300, 100)
    test(5, 200, 300, 300, 100)
    test(6, 500, 400, 400, 500)
    test(7, 500, 500, 500, 500)
    test(8, 600, 500, 500, 600)
    test(9, 1000, 1000, 1000, 500)
    test(10, 3000, 1000, 1000, 4000)
