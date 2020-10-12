my_list = [8, 7, 5, 5, 2, 1]
num = input('Введите число: ')

while True:
    try:
        num = int(num)
        for i in range(0, len(my_list)):
            if my_list[i] < num:
                my_list.insert(i, num)
                break
        print(my_list)
        break
    except ValueError:
        num = input('Не вводите ничего кроме числа! Попробуйте еще раз: ')
