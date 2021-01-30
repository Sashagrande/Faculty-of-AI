name = input('Введите ваше имя ')
age = int(input('Сколько вам лет? '))
avLifeExp = 71
av_minus_age = avLifeExp - age
print('Здравствуйте', name, '! Согласно исследованиям средней продолжительности жизни, вы прожили', age / avLifeExp,
      'жизни и вам осталось жить', av_minus_age, 'лет')
print('Желаю вам хорошего дня')
