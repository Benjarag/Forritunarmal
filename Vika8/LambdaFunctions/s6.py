import functools

my_list = [1, 2, 3, 4, 5, 6, 7, 8]

def compose(f, g):
    return lambda x: f(g(x))

def sumEven(my_list):
    a = compose(
        lambda lst: functools.reduce(lambda x, y: x + y, lst), 
        lambda lst: list(filter(lambda x: x % 2 == 0, lst))
    )
    return a(my_list)

print(sumEven(my_list))