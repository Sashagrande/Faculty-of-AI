from time import sleep
from termcolor import colored


class TrafficLight:
    __color = ['red', 'yellow', 'green', 'yellow']

    def running(self):
        while True:
            for i in self.__color:
                j = colored('☻', i)
                print(f'\r{j}', end='')
                if i == 'red':
                    sleep(7)
                elif i == 'yellow':
                    sleep(2)
                elif i == 'green':
                    sleep(5)


tl = TrafficLight()

tl.running()
