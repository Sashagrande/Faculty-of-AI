with open('file_1.txt', 'w', encoding='utf-8') as file:
    my_string = []
    while True:
        my_string.append(
            input('Для завершения ввода отправьте пустую строку. Введите строку, которую хотите добавить: '))
        if my_string[-1] == '':
            break
    for i in my_string:
        file.write(i + '\n')
