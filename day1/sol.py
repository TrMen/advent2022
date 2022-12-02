with open('input.txt', 'r') as file:
    calories = file.read().rstrip()

calories = calories.split('\n')
calories = ['' if val == '' else int(val) for val in calories]

elf_list = []
elf_sub_list = []
for val in calories:
    if val != '':
        elf_sub_list.append(val)
    else:
        elf_list.append(elf_sub_list)
        elf_sub_list = []

elf_list = [sum(elf_sub_list) for elf_sub_list in elf_list]

max_cal = max(elf_list)
max_index = elf_list.index(max(elf_list))

print(f'Max calories is {max_cal} and is carried by Elf {max_index + 1}')

elf_list.sort(reverse=True)
print(elf_list[0:3])
first_three = sum(elf_list[0:3])
print(f'Sum of top 3 elf calories - {first_three}')
