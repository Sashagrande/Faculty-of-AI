from googletrans import Translator

tr = Translator()
tr_strings = []  # создадим список переведенных строк

with open('file_4.txt', encoding='utf-8') as f:
    for line in f.readlines():  # возьмем каждую строку
        line = list(line.split())  # сделаем её списком
        translate = tr.translate(line[0], dest='ru')  # переведем [0] элемент нашего списка
        line[0] = translate.text  # и заменим [0] элемент нашим переводом
        line = ' '.join(line)  # форматируем наш список обратно в строку
        print(line)  # выведем нашу строку, чтобы убедиться что она перевелась
        tr_strings.append(line)  # и добавим нашу строку в новый список, элементы которого будем писать в новый файл

with open('file_4_translate.txt', 'w', encoding='utf-8') as tr_f:
    for i in tr_strings:  # возьмем каждый элемент нашего списка
        tr_f.write(i + '\n')  # и запишем его в наш новый файл
