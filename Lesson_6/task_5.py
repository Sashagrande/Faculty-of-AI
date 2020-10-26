class Stationery:
    def __init__(self, name):
        self.title = name

    def draw(self):
        print('Запуск отрисовки')


class Pen(Stationery):
    def draw(self):
        print(f'Запуск отрисовки предмета {self.title}')


class Pencil(Stationery):
    def draw(self):
        print(f'Запуск отрисовки предмета {self.title}')


class Handle(Stationery):
    def draw(self):
        print(f'Запуск отрисовки предмета {self.title}')


pen = Pencil("Карандашик")
pen.draw()

pen = Handle("Маркер")
pen.draw()

pen = Pen("Ручка")
pen.draw()
