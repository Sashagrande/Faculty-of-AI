def summa():
    result = []
    while True:
        my_list = list(input('Вводите числа через пробел, для остановки введите "q": ').split())
        for i in range(0, len(my_list)):
            if my_list[i] == 'q':
                break
            try:
                my_list[i] = int(my_list[i])
                result.append(my_list[i])
                s = sum(result)
            except ValueError:
                continue
        if 'q' in my_list:
            break
        try:
            print(s)

        except NameError:
            break
    try:
        return print('Итоговая сумма', s)
    except NameError:
        print('Вы ничего не ввели')


summa()
