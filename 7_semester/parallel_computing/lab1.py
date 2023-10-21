import math


def c(k, n):
    return math.factorial(n) /(math.factorial(k) * math.factorial(n-k))

def b(k, n, p):
    return c(k, n) * p**k * (1-p)**(n-k) 

def a(k, n, p):
    r = 0
    for i in range(k, n+1):
        r += b(i, n, p)

    return r
