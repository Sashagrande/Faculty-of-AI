class Road:
    def __init__(self, a, b):
        self._length = a
        self._width = b

    def calc(self):
        return self._width * self._length * 25 * 5 / 1000


r = Road(a=float(input('Введите длину дороги в метрах: ')), b=float(input('Введите ширину дороги в метрах: ')))

print('Масса необходимого асфальта -', r.calc(), 'т')
