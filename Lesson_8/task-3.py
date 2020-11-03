class Numbers(Exception):
    def __init__(self, n):
        self.n = n

    def check(self):
        return True if self.n.isdigit() else print('Вы ввели не число!')


nums = []
while True:
    num = input('Для остановки ввода введите "stop". Введите число, чтобы добавить его в список чисел: ')
    nums.append(int(num)) if Numbers(num).check() else ''
    if num == 'stop':
        break


print(nums)
