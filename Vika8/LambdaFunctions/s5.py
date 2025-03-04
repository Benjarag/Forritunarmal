my_list = [1, 2, 3, 4, 5, 6, 7, 8]

def compose(f, g):
    return lambda x: f(g(x))

def twice(f):
    return compose(f, f)

# a)
double_twice = twice(lambda x: x * 2)
double_twice_list = list(map(double_twice, my_list))
print(double_twice_list)

# b)
add_three_twice = twice(lambda x: x + 3)
add_three_twice_list = list(map(add_three_twice, my_list))
print(add_three_twice_list)