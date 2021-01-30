my_list = [2, 2, 2, 7, 23, 1, 44, 44, 3, 2, 10, 7, 4, 11]
new_list = [my_list[i] for i in range(0, len(my_list)) if not (my_list[i] in my_list[i + 1:] or my_list[i] in my_list[:i])]
print(my_list)
print(new_list)
print([el for el in my_list if my_list.count(el) == 1])
