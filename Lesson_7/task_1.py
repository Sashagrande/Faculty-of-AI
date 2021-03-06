class Matrix:
    def __init__(self, matrix):
        self.matrix = matrix

    def __str__(self):
        for i in self.matrix:
            for j in i:
                print(f'{j:<8}', end=' ')
            print()
        return ''

    def __add__(self, other):
        result = []

        if len(self.matrix) != len(other.matrix):
            return f'Матрицы разного размера, сумма невозможна!!!'
        else:
            for r in zip(self.matrix, other.matrix):  # распаковываем пары и получаем кортежи
                # print(r)  # Проверим что нам дает распаковка
                if len(r[0]) < len(r[1]):  # если строках в 1 матрицы элементов меньше чем во второй
                    while len(r[0]) != len(r[1]):  # то пока количество элементов не равно
                        r[0].append(0)  # добавляем нули в конец
                elif len(r[0]) > len(r[1]):  # если в строках 2 матрицы элементов меньше чем в 1
                    while len(r[0]) != len(r[1]):  # то пока количество элементов не равно
                        r[1].append(0)  # добавляем нули в конец
                # print(r)  # проверим что получится если строки матриц были разных размеров

                # А теперь само решение
                s = []  # создаем временный список для суммы парных элементов кортежей
                for i in range(0, len(r[0])):
                    j = 0  # переменная которая позволит заглядывать в каждый список не зависимо от размера строки
                    s.append(r[j][i] + r[j + 1][i])  # кладем во временный список сумму парных элементов кортежей
                result.append(s)  # кладем в результат списки с суммой парных элементов

            # Ниже конструкция для вывода согласно условиям задачи (скопировано из метода __str__)
            print('Сумма матриц')
            for i in result:
                for j in i:
                    print(f'{j:<8}', end=' ')
                print()
            return ''


mat_1 = Matrix([[1, 2, 3], [1], [2, 6, 2], [1, 1, 1]])
print('Матрица 1')
print(mat_1)
print()

mat_2 = Matrix([[2, 3, 4], [5, 5, 5], [4, 6, 1], [3, 150]])
print('Матрица 2')
print(mat_2)

print(mat_1 + mat_2)
