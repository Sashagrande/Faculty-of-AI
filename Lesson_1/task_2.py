time = int(input('Введите время в секундах '))
h = time // 3600
if h % 24 == 0:
    h = 0
else:
    while h > 23:
        h = h // 24

print(' {:0=2}:{:0=2}:{:0=2}'.format(h, (time % 3600) // 60, time % 60))
