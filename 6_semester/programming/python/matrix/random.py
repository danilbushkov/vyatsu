import random

def get_random_matrix(n, m):
    matrix = []
    for i in range(n):
        matrix.append([])
        for _ in range(m):
            matrix[i].append(random.randint(-100,100))

    return matrix