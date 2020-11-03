class Data:
    def __init__(self, data):
        self.data = data

    @classmethod
    def format_data(cls, data):
        if data.replace('-', '').isdigit():
            return int(data.replace('-', ''))
        else:
            return 'Нужно вводить число в формате дд-мм-гггг!!! Ничего другого вводить нельзя'

    @staticmethod
    def validation(data):

        a = data.replace('-', '')
        if a.isdigit():
            if (int(a[:2]) > 31) or (int(a[:2]) < 1):
                print("Дни бывают от 1 до 31")
            if (int(a[2:4]) > 12) or (int(a[2:4]) < 1):
                print("Месяцы бывают от 1 до 12")
            if int(a[4:]) < 1000:
                print("Мы работаем с датами настоящего и прошлого тысячелетия!!!")
            if (int(a[2:4]) < 13) and (int(a[2:4]) > 0) and (int(a[:2]) < 32) and (int(a[:2]) > 0):
                print('Валидация пройдена!!')

        else:
            print('Нужно вводить число в формате дд-мм-гггг!!! Ничего другого вводить нельзя')


date = input('Введите дату в формате дд-мм-гггг: ')

print("Используем @classmethod")
print(Data.format_data(date))
print(type(Data.format_data(date)))
print()
print("Используем @staticmethod")
Data.validation(date)
