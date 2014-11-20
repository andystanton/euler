sum = 0
for x in filter(lambda x: x % 3 == 0 or x % 5 == 0, range(1, 1000)):
    sum += x

print(sum)
