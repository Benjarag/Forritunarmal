# a)
def compose(f, g):
    return lambda x: f(g(x))

def twice(f):
    return compose(f, f)

# b)
two_times_mult_two = twice(lambda x: x * 2)
print(two_times_mult_two(3))

# c)
two_times_add_three = twice(lambda x: x + 3)
print(two_times_add_three(3))