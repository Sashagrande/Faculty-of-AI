my_list = [1, 2.5, [2, 'str'], True, {2:'hi'}, 'string']
i = 0
while i < len(my_list):
    print(type(my_list[i]))
    i += 1
# --------------------------------------------
print('Альтернативное решение')
for i in my_list:
    print(type(i))
