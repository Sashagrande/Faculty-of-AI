import json

with open('file_7.txt', encoding='utf-8') as file:
    companies = []  # список для сбора прибылей компаний и подсчета среднего значения
    my_dict = {}  # словарь с компаниями и их прибылями
    average_profit = {}  # словарь со средним профитом прибыльных компаний
    result = []  # объект для сериализации
    for line in file:
        income = round(float(line.split()[-2]) - float(line.split()[-1]), 2)
        print(f'{line.split()[0]} has {income}B')
        if income > 0:
            companies.append(income)
        average_profit['Average_profit'] = sum(companies) / len(companies)
        my_dict[line.split()[0]] = income
    result.append(my_dict)
    result.append(average_profit)
    print(f' Average profit of profitable companies - {sum(companies) / len(companies)}B')

with open("result_7.json", "w") as f:
    json.dump(result, f)
