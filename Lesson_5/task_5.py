with open('file_5.txt', 'w+', encoding='utf-8') as f:
    my_num = []
    while True:
        my_num.append(
            input('Для завершения ввода отправьте пустое поле. Введите число, которую хотите добавить: '))
        if my_num[-1] == '':
            my_num.remove(my_num[-1])
            break
    f.write(' '.join(my_num))

    try:
        print(f'Сумма чисел равна {sum(map(int, my_num))}')
    except ValueError:
        print('В строке чисел имеются буквы либо символы')
