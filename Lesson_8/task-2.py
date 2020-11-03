class MyOwnError(Exception):
    def __init__(self, num):
        self.num = num

    def check(self):
        if self.num != 0:
            return True
        else:
            return print('Не дели на ноль ♪♫')


A = input('Введите делимое: ')
B = input('Введите делитель: ')
if A.isdigit() and B.isdigit():
    A = float(A)
    B = float(B)
    print((A / B) if MyOwnError(B).check() else 'Деление не удалось(')
else:
    print('Делимое и делитель это числа')