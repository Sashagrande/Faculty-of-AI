from random import random


# Решил потренировать создание файлов силами python и создал txt файлик со списком имен и зарплатами
def my_func():
    with open('file_3.txt', 'w', encoding='utf-8') as f:
        persons = ['Иванов', 'Горбунов', 'Smith', 'Баширов', 'Горбунов', 'Jones', 'Sanchez', 'Дуров', 'Trump',
                   'Касперский', 'Morgan', 'Rivera', 'Пушкин', 'Тургенев', 'Taylor', 'Лавров', 'Sanders', 'Ross',
                   'Хлестов']
        my_list = []
        for pers in persons:
            pers = pers + ' ' + str(round((random() * 60000 + 5000), 2))  # зарплаты будут в диапазоне от 5 до 65 тысяч
            my_list.append(pers + '\n')
        f.writelines(my_list)


# уже имеется файл, сгененированный этим методом, если хотите сгенерировать заново - разкомментируйте вызов функции
# my_func()

# А теперь то, что относится к заданию
with open('file_3.txt', 'r', encoding='utf-8') as file:
    names = []
    salaries = []
    for line in file.readlines():
        line = list(line.split())
        print(line)
        if float(line[1]) < 20000:
            names.append(line[0])
        salaries.append(float(line[1]))
    print(f'Список имен людей, чья зарплата ниже 20000: \n', '\n '.join(names))
    print('Средняя всех сотрудников =', round((sum(salaries) / len(salaries)), 2))
