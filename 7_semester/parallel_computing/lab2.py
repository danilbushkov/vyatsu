import math

def P0(R, N):
    s = R**N/(math.factorial(N-1) * (N-R))
    m = 0
    for i in range(0, N):
        m += R**i / math.factorial(i)
    return 1/(s+m)

def Pn(R, N, n):
    if n > N:
        return P0(R, N) * (R**n / (math.factorial(N) * N**(n-N) ))    
    else:
        return P0(R, N) * (R**n/math.factorial(n))

def P0_(N, p):
    s = N**(N-1)*p**N/(math.factorial(N-1)*(1-p))
    m = 0
    for i in range(0,N):
        m += N**i*p**i/math.factorial(i)
    return 1/(s+m)

def l(N, p):
    return N**(N-1)*p**(N+1)/(math.factorial(N-1)*(1-p)**2) * P0_(N,p)


