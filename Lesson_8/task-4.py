from abc import ABC, abstractmethod
from copy import deepcopy


class Storage(ABC):
    storage = []
    storage_1 = []
    storage_2 = []
    storage_3 = []
    w = 0
    a = 0
    s = 0

    @abstractmethod
    def __init__(self, **kwargs):
        self.kwargs = kwargs

    def Adder(self):
        self.storage.append(self.kwargs)
        print(self.__class__.__name__, self.kwargs['code'], ', фирма -', self.kwargs['brand'], ', количество - ',
              self.kwargs['quantity'],
              ', отправлен на склад')

    def show_of_eq(self, x):
        print()
        if x == 'основной':
            self.w = self.storage
        elif x == 'бухгалтерия':
            self.w = self.storage_1
        elif x == 'отдел кадров':
            self.w = self.storage_2
        elif x == 'маркетологи':
            self.w = self.storage_3
        else:
            return print('Такого отдела пока не существует')
        if self.w is not False:
            print(f'На складе "{x}" имеются следующие элементы: ')
            for i in self.w:
                if i['quantity'] == 0:
                    del i
                else:
                    print(i['code'], i['brand'], i['quantity'], 'шт')
            j = 0
            for _ in self.w:
                j += _['quantity']
            print('В данный момент на складе', j, 'товаров')

    def send_to_dep(self, code, quantity, num_dep):  # Задание 5. Отправляем позиции в отделы
        print()
        self.a = 0
        try:
            for i in deepcopy(self.storage):
                if code == i['code']:
                    if i['quantity'] < quantity:
                        print('Нельзя отправить больше товара чем мы имеем!')
                        return

                    else:
                        if num_dep == "бухгалтерия":
                            self.a = self.storage_1
                        elif num_dep == "отдел кадров":
                            self.a = self.storage_2
                        elif num_dep == "маркетологи":
                            self.a = self.storage_3
                        else:
                            print(f'Отдела "{num_dep}" не существует')
                            return
                        self.a.append(i)
                        self.a[-1]['quantity'] = quantity
                        print(f'Товар c артикулом {code} добавлен на склад "{num_dep}"')
                        self.s = 1

            if self.a == 0:
                print('Товара с таким артикулом не существует!!!')

            if self.a != 0:
                for i in self.storage:
                    if i['quantity'] <= 0:
                        del i
                        break
                    if code == i['code']:
                        i['quantity'] -= quantity
        except TypeError:
            print('Введены некорректные данные!!! Артикул и количество товара передаются в виде цифр')


class OfficeEquipment(Storage):

    def __init__(self, **kwargs):
        super().__init__()
        self.kwargs = kwargs


class Printer(OfficeEquipment):
    def __init__(self, **kwargs):
        super().__init__()
        self.name = self.__class__.__name__
        self.kwargs = kwargs


class Scanner(OfficeEquipment):
    def __init__(self, **kwargs):
        super().__init__()
        self.name = self.__class__.__name__
        self.kwargs = kwargs


class Copier(Scanner, Printer):
    def __init__(self, **kwargs):
        super().__init__()
        self.name = self.__class__.__name__
        self.kwargs = kwargs


a_1 = Copier(code=518894,
             brand='HP',
             color='Black',
             price=7000,
             quantity=20,
             format_='A4',
             scanning_technology='CIS',
             print_type='Color',
             print_speed=8,
             printing_technology='jet')

a_2 = Scanner(code=653845,
              brand='Canon',
              color='white',
              price=3000,
              quantity=15,
              format_='A4',
              scanning_technology='CIS')

a_3 = Printer(code=985118,
              brand='Epson',
              color='Black',
              price=5000,
              quantity=10,
              print_type='Black',
              print_speed=6,
              printing_technology='laser')

storage = OfficeEquipment()
a_1.Adder()
a_2.Adder()
a_3.Adder()
print()
print(
    'Помимо основного склада, на данный момент есть три склада - бухгалтерия, отдел кадров и маркетологи. '
    '\nЭти склады можно передавать в '
    'качестве параметров для передачи товаров на эти склады.\nПервым параметром идет артикул товара, вторым'
    ' количество товара, третим на какой склад отправить товар')

storage.show_of_eq('основной')
storage.show_of_eq('бухгалтерия')
storage.send_to_dep(653845, 8, 'бухгалтерия')
storage.send_to_dep(985118, 10, 'отдел кадров')
storage.send_to_dep(518894, 37, 'маркетологи')
storage.send_to_dep(518894, 1, 'отдел кадров')
storage.send_to_dep(9851212118, 8, 'отдел кадров')
storage.send_to_dep(518894, 3, 'отдел снабжения')

storage.show_of_eq('отдел кадров')
storage.show_of_eq('бухгалтерия')
storage.show_of_eq('основной')
