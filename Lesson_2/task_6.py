things = []
j = 1
yes = ['да', 'yes']

while True:
    question = input('Вы хотите добавить товар? Если да, введите "Да/Yes", иначе введите любые клавиши: ').lower()
    if question in yes:
        my_dict = {'Наименование': input('Введите наименование торвара: '),
                   'Цена': int(input('Введите цену торвара(число): ')),
                   'Количество': int(input('Введите количество торвара(число): ')),
                   'ед': input('Введите ед измерения: '), }
        thing = (j, my_dict)
        j += 1
        thing = tuple(thing)
        things.append(thing)
    else:
        break
print()
print('Это список из кортежей, который сформировался -', things)
print('Проверим тип элементов списка -', type(thing))
print()
result = dict()  # создаем новый словарь который будем заполнять.
for key in thing[1].keys():  # берем каждый ключ по очереди из нашего словаря из кортежа,
    result[key] = []  # и добавляем этот ключ в наш новый словарь.
    val = list()  # создаем список, который мы положим в значения для ключей нового словаря.
    for thing in things:  # берем каждый кортеж из нашего списка с кортежами,
        val.append(thing[1].get(key))  # кидаем в список значение из словаря в этом кортеже по ключу
    result[key] = val  # а теперь добавляем этот список в значения нового списка по ключу
print('Это результат аналитики', result)
