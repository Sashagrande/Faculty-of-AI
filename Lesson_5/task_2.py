with open('file_1.txt', 'r', encoding='utf-8') as f:
    count_lines = 0
    CountAllWords = 0
    for line in f.readlines():
        line = list(line.split())
        Count_word = 0
        count_lines += 1
        Count_word += len(line)
        CountAllWords += Count_word
        if line:
            print(f'В {count_lines} строке - {Count_word} слов(а)! ')
    print(f'Всего строк - {count_lines-1}, всего слов - {CountAllWords}')
