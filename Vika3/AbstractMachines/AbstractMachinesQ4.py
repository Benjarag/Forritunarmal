import time

start = time.time()

for _ in range(100_000_000):
    pass

end = time.time()
print(f"Tími í Python: {end - start:.2f} sekúndur")