#! /bin/env python3

lst = range(1, 10)
factors = [3, 5]
result = sum(
    [x for x in lst
        if any([x % y == 0 for y in factors])])

print(result)
