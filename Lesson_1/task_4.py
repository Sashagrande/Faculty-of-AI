num = int(input('Введите целое положительное число: '))
old_num = num
result = 0
if num % 10 == 0:
    num = num // 10
while num % 10:
    if num % 10 > result:
        result = num % 10
    num = num // 10
print('Самая большая цифра в числе ', old_num, '-', result)
