

enumerate = lambda m1, m2, func: [[ func(m1[i][j],m2[i][j]) for j in range(len(m1[i]))] for i in range(len(m1))] \
    if len(m1) > 0 and len(m1) == len(m2) \
        and len(m1[0]) > 0 and len(m1[0]) == len(m2[0]) \
    else []

add = lambda m1, m2: enumerate(m1, m2, lambda a, b: a+b)

subtract = lambda m1, m2: enumerate(m1, m2, lambda a, b: a-b)

multiply = lambda m1, m2: [ [ sum([ m1[i][l] * m2[l][j] for l in range(len(m2))]) for j in range(len(m2[0])) ] for i in range(len(m1)) ]

transpose = lambda m: [[m[i][j] for i in range(len(m))] for j in range(len(m[0]))]


multiply_by_number = lambda m, num: [[num * item for item in row] for row in m]