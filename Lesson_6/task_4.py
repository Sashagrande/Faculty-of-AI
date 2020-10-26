class Car:
    yes = ('да', 'Да')

    def __init__(self, name, color, speed, is_police):
        self.Name = name
        self.Color = color
        self.Speed = speed
        self.Is_police = True if is_police in self.yes else False
        print(f'Автомобиль - {self.Name}, цвет - {self.Color}, скорость - {self.Speed} добавлен.',
              'Автомобиль является полицейским' if self.Is_police else '')
        self.show_speed()

    def go(self, speed):
        self.Speed = speed
        print(f'Машина {self.Name} изменила скорость и теперь она движется со скоростью - {self.Speed}')
        self.show_speed()

    def stop(self):
        self.Speed = 0
        print(f'Машина {self.Name} остановилась')

    def turn(self, direction):
        print(f'Машина {self.Name} повернула {direction}')

    def show_speed(self):
        print(f'Текущая скорость автомобиля - {self.Speed}')


class TownCar(Car):

    def show_speed(self):
        if int(self.Speed) > 60:
            print(f'У автомобиля {self.Name} превышена скорость!!!')
            print(
                f'Внимание!!! Сработала система безопасности, дальнейшее движение со сокростью {self.Speed} запрещено!')
            self.Speed = 60  # и скорость автоматически снизилась до максимально допустимой


class SportCar(Car):
    pass


class WorkCar(Car):
    def show_speed(self):
        print(f'У автомобиля {self.Name} превышена скорость!!!')
        print(
            f'Внимание!!! Сработала система безопасности, дальнейшее движение со сокростью {self.Speed} запрещено!')
        self.Speed = 40  # и скорость автоматически снизилась до максимально допустимой


class PoliceCar(Car):

    def turn_on_the_flashes(self):
        if self.Is_police:
            print('Мигалки включены')

    def turn_off_the_flashes(self):
        if self.Is_police:
            print('Мигалки выключены')


# Катаемся на личном авто и мониторим показания спидометра
my_own_car = TownCar(name=input('Введите название машины: '),
                     color=input('Введите цвет машины: '),
                     speed=input('Введите скорость: '),
                     is_police=input('Это полицейская машина? \nда или нет: '))
print()
my_own_car.go(100)
print('Текущая скорость -', my_own_car.Speed)
my_own_car.turn('Налево')
my_own_car.go(120)
print('Текущая скорость -', my_own_car.Speed)
my_own_car.stop()
print('Текущая скорость -', my_own_car.Speed)
print('*' * 40)

# Катаемся на корпоративном автомобиле и мониторим показания спидометра
corporate_car = WorkCar(name=input('Введите название машины: '),
                        color=input('Введите цвет машины: '),
                        speed=input('Введите скорость: '),
                        is_police=input('Это полицейская машина? \nда или нет: '))
print()
corporate_car.go(100)
print('Текущая скорость -', corporate_car.Speed)
corporate_car.turn('Направо')
corporate_car.go(120)
print('Текущая скорость -', corporate_car.Speed)
corporate_car.stop()
print('Текущая скорость -', corporate_car.Speed)
print('*' * 40)

# Катаемся на спорткаре и мониторим показания спидометра
sport_car = SportCar(name=input('Введите название машины: '),
                     color=input('Введите цвет машины: '),
                     speed=input('Введите скорость: '),
                     is_police=input('Это полицейская машина? \nда или нет: '))
print()
sport_car.go(100)
print('Текущая скорость -', sport_car.Speed)
sport_car.turn('Налево')
sport_car.go(200)
print('Текущая скорость -', sport_car.Speed)
sport_car.turn('Налево')
sport_car.stop()
print('Текущая скорость -', sport_car.Speed)
print('*' * 40)

# Катаемся на полицейской тачке, мониторим показания спидометра и гонимся за нарушителем на спорткаре
police_car = PoliceCar(name=input('Введите название машины: '),
                       color=input('Введите цвет машины: '),
                       speed=input('Введите скорость: '),
                       is_police=input('Это полицейская машина? \nда или нет: '))
print()
police_car.go(100)
print('Текущая скорость -', police_car.Speed)
police_car.turn('Направо')
print(f'Полицейская машина погналась за {sport_car}')
police_car.turn_on_the_flashes()
police_car.go(120)
print('Текущая скорость -', police_car.Speed)
police_car.stop()
print('Текущая скорость -', police_car.Speed)
police_car.turn_off_the_flashes()
