from math import factorial


def my_func(n):
    for i in range(1, n + 1):
        yield factorial(i)


j = 1
for el in my_func(int(input('Введите число, для определения его факториала: '))):
    print(j, 'факториал = ', el)
    j += 1

print('Альтернативный вариант решения')


def f(n):
    a = 1
    for i in range(1, n + 1):
        if i > n:
            break
        else:
            yield a * i
            a *= i


j = 1
for el in f(int(input('Введите число, для определения его факториала: '))):
    print(j, 'факториал = ', el)
    j += 1
