with open('file_6.txt', encoding='utf-8') as file:
    result = {}
    for line in file:  # залезаем в строчку файла
        s = []  # создаем список для каждой строки, который будем заполнять числами из строки
        for elements in line.split():  # залезаем в каждое слово строки
            i = [int(j) for j in elements if j.isdigit()]  # создадим список и поместим туда цифры
            if i:
                i = int(''.join((str(_) for _ in i)))  # теперь склеим цифры в единое число
                s.append(i)  # и добавим в список чисел из строки
        result[line.split()[0]] = sum(s)  # добавим в результат ключ из первого элемента строки
        # и поместим в его значение сумму чисел из строки
    print(result)

