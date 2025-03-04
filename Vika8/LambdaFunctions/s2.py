my_list = [1, 2, 3, 4, 5, 6, 7, 8]

# a)
even_numbers = list(filter(lambda x: x % 2 == 0, my_list))
print(even_numbers)

# b)
odd_numbers = list(filter(lambda x: x % 2 == 1, my_list))
print(odd_numbers)