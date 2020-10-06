time = int(input('Введите время в секундах '))
print(' {}:{}:{}'.format(time // 3600, (time % 3600) // 60, time % 60))
