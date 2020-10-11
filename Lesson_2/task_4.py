my_str = list(input('Введите предложение и получите каждое слово на новой строке: ').split())
for i in range(0, len(my_str)):
    print(i + 1, my_str[i][:10])
