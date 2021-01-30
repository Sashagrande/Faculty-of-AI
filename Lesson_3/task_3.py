def summa():
    while True:
        try:
            my_list = list(map(int, input('Введите три числа и получите сумму двух максимальных: ').split()))
            if len(my_list) == 3:
                break
        except ValueError:
            continue
    my_list.remove(min(my_list))
    return sum(my_list)


print(summa())
