import re


class Complex:
    def __init__(self, com_num):
        self.com_num = com_num
        print(self.com_num)
        a = re.findall('[0-9]+', self.com_num)
        a = [int(i) for i in a]
        if self.com_num.count('-') == 2:
            a[0] = 0 - a[0]
            a[1] = 0 - a[1]
        elif self.com_num.count('-') == 1:
            if self.com_num.index('-') < 2:
                a[0] = 0 - a[0]
            else:
                a[1] = 0 - a[1]
        self.com_num = a

    def __add__(self, other):
        a = self.com_num
        b = other.com_num
        c = ''
        if a[1] + b[1] > 0:
            c = '+'
        return complex(f'{a[0] + b[0]}{c}{a[1] + b[1]}j')

    def __mul__(self, other):
        a = self.com_num
        b = other.com_num
        c = ''
        if a[1] + b[1] > 0:
            c = '+'
        return complex(f'{a[0] * b[0] - a[1] * b[1]}{c}{a[0] * b[1] + a[1] * b[0]}j')


a1 = Complex(input('Введите комплексное число в формате а + bj: '))
a2 = Complex(input('Введите комплексное число в формате а + bj: '))

print(a1 + a2)
print(a1 * a2)


# Вариант решения чуть-чуть проще
# class Complex:
#     def __init__(self, com_num):
#         self.com_num = complex(com_num.replace(' ', ''))
#
#     def __add__(self, other):
#         return self.com_num + other.com_num
#
#     def __mul__(self, other):
#         return self.com_num * other.com_num
#
#
# a3 = Complex(input('Введите комплексное число в формате а + bj: '))
# a4 = Complex(input('Введите комплексное число в формате а + bj: '))
#
# print(a3 + a4)
# print(a3 * a4)
