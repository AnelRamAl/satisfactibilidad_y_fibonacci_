from timeit import default_timer #importamos la función time para capturar tiempos
from math import sqrt


def fibonacci(n):
    if n == 0 or n == 1:
    	return n
    else:
    	return fibonacci(n-1) + fibonacci(n-2)

inicio = default_timer()

fibonacci(41)

fin = default_timer()

print(fin - inicio)

	#En segundos
