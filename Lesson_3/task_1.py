def delenie(a, b):
    while True:
        try:
            b = float(b)
            a = float(a)
            return a / b
        except ValueError:
            a = input('Ошибка! Делимое это число, повторите еще раз: ')
            b = input('Ошибка! Делитель это число, повторите еще раз: ')
        except ZeroDivisionError:
            a = input('Введите делимое еще раз: ')
            b = input('Делитель не должен быть равен нулю! попробуйте еще раз: ')


print(delenie(input('Введите делимое: '), input('Введите делитель: ')))
