my_list = [1, 2, 3, 4, 5, 6, 7, 8]

import functools

# a)
plus_sum = functools.reduce(lambda x, y: x + y, my_list)
print(plus_sum)

# b)
mult_sum = functools.reduce(lambda x, y: x * y, my_list)
print(mult_sum)