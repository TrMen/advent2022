with open('input.txt', 'r') as file:
    rucksacks = file.readlines()

rucksacks = [rucksack.rstrip() for rucksack in rucksacks]

priority = 0
for rucksack in rucksacks:
    firsthalf = rucksack[:len(rucksack)//2]
    secondhalf = rucksack[len(rucksack)//2:]
    common_char = ''.join(set(firsthalf).intersection(secondhalf))
    if (common_char.islower()):
        priority += ord(common_char) - ord('a') + 1
    elif (common_char.isupper()):
        priority += ord(common_char) - ord('A') + 27

print(f'Total priority - {priority}')
