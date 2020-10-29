from abc import ABC, abstractmethod


class Clothes(ABC):
    def __init__(self, size, height):
        self.size = size
        self.height = height

    @abstractmethod
    def FabricCalc(self):
        pass


class COAT(Clothes):
    @property
    def FabricCalc(self):
        w = int(self.size) / 6.5 + 0.5
        return f'Для пошива пальто потребуется    {w:.2f}м2 ткани'


class COSTUME(Clothes):
    @property
    def FabricCalc(self):
        w = int(self.height) * 2 + 0.3
        return f'Для пошива костюма потребуется    {w:.2f}м2 ткани'


coat = COAT(50, 150)
costume = COSTUME(50, 150)

print(costume.FabricCalc)
print(coat.FabricCalc)
