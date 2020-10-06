n = input('Введите число ')
a = (n, n * 2, n * 3)  # для отображения "n + nn + nnn в ответе
nn = int((n * 2))
nnn = int(n * 3)
n = int(n)
print(a[0], '+', a[1], '+', a[2], '=', n + nn + nnn)
