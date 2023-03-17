import ctypes
import os
 
path = os.getcwd()
lib = ctypes.CDLL(os.path.join(path, 'clang/lib/matrix.so'))


def cmultiply(m1, m2):
    if len(m1) == 0 or len(m2) == 0 or len(m2[0]) == 0 or len(m1[0]) == 0:
        return []
    if len(m1[0]) != len(m2):
        return []

    cm1 = (ctypes.c_int * len(m1[0]) * len(m1))()
    cm2 = (ctypes.c_int * len(m2[0]) * len(m2))()

    for i in range(len(m1)):
        cm1[i] = (ctypes.c_int * len(m1[i]))(*m1[i])

    for i in range(len(m2)):
        cm2[i] = (ctypes.c_int * len(m2[i]))(*m2[i])

    

    lib.multiply.restype = ctypes.POINTER(ctypes.c_int)
    cresult = ctypes.POINTER(ctypes.c_int)
    cresult = lib.multiply(cm1, len(m1), len(m1[0]), cm2, len(m2), len(m2[0]))

    result = []
    for i in range(len(m1)):
        result.append([])
        for j in range(len(m2[0])):
            result[i].append(cresult[i*len(m2[0])+j])

    return result