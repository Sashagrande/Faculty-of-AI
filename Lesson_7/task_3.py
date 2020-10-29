class Cell:
    def __init__(self, c):
        self.c = c

    def __add__(self, other):
        return self.c + other.c

    def __sub__(self, other):
        if self.c - other.c > 0:
            return self.c - other.c
        else:
            return 'Операция невозможна'

    def __mul__(self, other):
        return self.c * other.c

    def __floordiv__(self, other):
        return self.c // other.c

    def MakeOrder(self, w):  # с интересом буду смотреть на следующем уроке как еще это можно сделать)))
        a = '☻' * self.c
        for i in range(0, len(a)//w):
            print(f'{a[:w]}')
            a = '☻' * (self.c - w)
        print('☻' * (self.c % w))


a_1 = Cell(5)

a_2 = Cell(9)

print('Сумма клеток равна', a_1 + a_2)
print('Разность клеток равна', a_1 - a_2)
print('Произведение клеток равно', a_1 * a_2)
print('Результат целочисленного деления равен', a_1 // a_2)
a_2.MakeOrder(4)
