def result(x, y):
    while True:
        try:
            x = float(x)
            y = float(y)
            if (y < 0) and (x > 0):
                break
            print('Степень должна быть отрицательной! Попробуем снова: ')
            x = input('Введите положительное число: ')
            y = input('В какую отрицательную степень вы хотите возвести число? ')
        except ValueError:
            print('Первое число должно быть положительным, второе отрицательным, ничего кроме этих числел не вводите!')
            x = input('Введите положительное число: ')
            y = input('В какую отрицательную степень вы хотите возвести число? ')
    i = 0
    w = 1
    while i < abs(y):
        w = w * 1 / x
        i += 1
    return w


print(result(input('Введите положительное число: '), input('В какую отрицательную степень вы хотите возвести число? ')))