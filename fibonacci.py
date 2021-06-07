from timeit import default_timer #importamos la función time para capturar tiempos
from math import sqrt

	### FIBONACCI POR RECURSION 
def fib(n):
    a, b = 0,1
    while a < n:
        print(a, end=' ')
        a, b = b, a+b
    print()
fib(9000)

    ### FIBONACCI POR EL NUM DE ORO (algebraico)
fi = 1.618033988749895 

def fibNumOro(n):
    return (fi ** n - (1 - fi) ** n) / sqrt(5)

for i in range(30):
	print(int(fibNumOro(i)))#f=fibNumOro(i)  			#sin esta linea solo la siguiente
	#print(int(f))				 #   print("fibNumOro({0}) = {1}".format(i, fibNumOro(i)))

