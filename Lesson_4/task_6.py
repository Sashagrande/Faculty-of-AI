from itertools import count
from itertools import cycle

# a
print('Решение a')
for i in count(3):
    if i > 10:
        break
    else:
        print(i)
print('-' * 40)

# b
print('Решение b')
my_list = [i for i in range(3, 30, 3)]
print(my_list)
j = 1
for el in cycle(my_list):
    if j > len(my_list) + 4:  # выдать весь список и 4 первых элемента
        break
    print(el)
    j += 1
