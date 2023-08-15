#iterative program to calculate n factorial using sum

n=8
factor=1
accumulator=0

for i in range(1, n+1, 1):
    accumulator=0
    for j in range(1, i+1, 1):
        accumulator+=factor
    factor=accumulator

print(accumulator)
