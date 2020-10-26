class Worker:
    def __init__(self, name, surname, position, wage, bonus):
        self.Name = name
        self.Surname = surname
        self.Pos = position
        self._Income = {"wage": wage, "bonus": bonus}


class Position(Worker):
    def get_full_name(self):
        return f' Полное имя {self.Pos} - {self.Name} {self.Surname}'

    def get_total_income(self):
        return sum(map(float, self._Income.values()))


worker1 = Position(name=input('Введите имя сотрудника: '),
                   surname=input('Введите фамилию сотрудника: '),
                   position=input('Введите должность сотрудника: '),
                   wage=input('Введите оклад сотрудника: '),
                   bonus=input('Введите бонус сотрудника: '))

print(worker1.get_full_name())

print(worker1.get_total_income())
