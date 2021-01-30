from sys import argv


script_name, production, rate_pe_hour, premium = argv

try:
    production = int(production)
    rate_pe_hour = int(rate_pe_hour)
    premium = int(premium)
    result = (production * rate_pe_hour) + premium
    print(
        f' При выработке {production} часов, со ставкой {rate_pe_hour} и премией {premium}, итоговая заработная плата '
        f'будет составлять {result}')
except ValueError:
    print('Один или несколько параметров имеют не верный тип данных!')
