import math


N = [2, 1, 2]
P = [0.31, 0.31, 0.38]
V = [0.5, 0.28, 0.58]
l0 = 0.1


def print_values(name, values):
    for i in range(0, len(values)):
        print(f"{name}{i+1} = {values[i]:.6f}") 

def print_value(name, value):
    print(f"{name} = {value:.6f}")

def calc_PP(b, k):
    if k == 1:
        return 1 - b/k
    result = b**k/(math.factorial(k)*(1-b/k))
    for i in range(0, k):
        result = result + b**i/math.factorial(i)
    return result**-1

def calc_L(b, k, PP):
    return (b**(k+1) / (math.factorial(k)*k*(1-b/k)**2))*PP

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

print_values("l", l)
print("____")
print_values("a", a)
print("____")
print_values("b", b)
print("____")
print_values("PP", PP)
print("____")
print_value("PPs", PPs)
print("____")
print_values("L", L)
print("____")
print_values("m", m)
print("____")
print_values("w", w)
print("____")
print_values("u", u)
print("____")
print_value("Ls", Ls)
print("____")
print_value("M", M)
print("____")
print_value("W", W)
print("____")
print_value("U", U)

