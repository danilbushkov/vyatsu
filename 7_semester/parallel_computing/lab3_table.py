import math

Ns = [  [2, 1, 2], 
        [3, 1, 2],
        [1, 1, 2],
        [2, 1, 2],
        [2, 1, 3],
        [2, 3, 3],
        [2, 3, 1]
      ]
P = [0.31, 0.31, 0.38]
V = [0.5, 0.28, 0.58]
l0 = 0.1


def print_table(rows):
    print("{:^13}{:^13}{:^13}{:^13}{:^13}{:^13}".format("П","L","m","W","U","dU"))
    for i in range(0, len(rows)):
        s = str(i+1)+"| "
        for j in range(0, len(rows[i])):
            s += "{:.6f}".format(rows[i][j]) + "     "
        print(s) 


def calc_PP(b, k):
    if k == 1:
        return 1 - b/k
    result = b**k/(math.factorial(k)*(1-b/k))
    for i in range(0, k):
        result = result + b**i/math.factorial(i)
    return result**-1

def calc_L(b, k, PP):
    return (b**(k+1) / (math.factorial(k)*k*(1-b/k)**2))*PP

def calc(N, P, V, l0, pU):
    n = len(P)

    l = [0] * n
    a = [0] * n
    b = [0] * n
    PP = [0] * n
    PPs = 1
    L = [0] * n
    m = [0] * n
    w = [0] * n
    u = [0] * n
    Ls = 0
    M = 0
    W = 0
    U = 0
    
    
    l[0] = l0/P[0]
    
    for i in range(1, n):
        l[i] = l[0]*P[i]
    
    for i in range(0, n):
        a[i] = l[i]/l0
    
    for i in range(0, n):
        b[i] = l[i]*V[i]
    
    for i in range(0, n):
        PP[i] = calc_PP(b[i], N[i])
    
    for i in range(0, n):
        PPs *= PP[i]
    
    for i in range(0, n):
        L[i] = calc_L(b[i], N[i], PP[i])
    
    for i in range(0, n):
        m[i] = L[i]+b[i]
    
    for i in range(0, n):
        w[i] = L[i]/l[i]
    
    for i in range(0, n):
        u[i] = m[i]/l[i]
    
    for i in range(0, n):
        Ls += L[i]
    
    for i in range(0, n):
        M += m[i]
    
    for i in range(0, n):
        W = W + a[i]*w[i]
    
    for i in range(0, n):
        U = U + a[i]*u[i]

    dU = 0
    if pU != 0:
        dU = (pU-U)/pU * 100

    return [PPs, Ls, M, W, U, dU]




rows = []

pU = 0
for i in range(0, len(Ns)):
    r = calc(Ns[i], P, V, l0, pU)
    if i == 0:
        pU = r[4]
    rows.append(r)

print_table(rows)

