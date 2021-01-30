def person(name, surname, age, city, email, phone):
    return name, surname, age, city, email, phone


print(person(
    name=input('Введите имя: '),
    surname=input('Введите фамилию: '),
    age=input('Введите возраст: '),
    city=input('Введите город проживания: '),
    email=input('Введите email: '),
    phone=input('Введите номер телефона: ')))
