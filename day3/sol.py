with open('input.txt', 'r') as file:
    rucksacks = file.readlines()

rucksacks = [rucksack.rstrip() for rucksack in rucksacks]


def get_priority(char):
    if (char.islower()):
        return ord(char) - ord('a') + 1
    elif (char.isupper()):
        return ord(char) - ord('A') + 27


priority = 0
for rucksack in rucksacks:
    firsthalf = rucksack[:len(rucksack)//2]
    secondhalf = rucksack[len(rucksack)//2:]
    common_char = ''.join(set(firsthalf).intersection(secondhalf))
    priority += get_priority(common_char)

print(f'Total priority for part 1 - {priority}')

priority2 = 0
for i in range(0, len(rucksacks), 3):
    set_list = [set(rucksack) for rucksack in rucksacks[i:i+3]]
    common_char = ''.join(set.intersection(*set_list))
    priority2 += get_priority(common_char)

print(f'Total priority for part 2 - {priority2}')
