with open('input.txt', 'r') as file:
    rounds = file.readlines()

shape_reward = {
    'X': 1,
    'Y': 2,
    'Z': 3,
}

# A - Rock
# B - Paper
# C - Scissors
# X - Rock
# Y - Paper
# Z - Scissors

outcome_reward = {
    'AX': 3,  # rock rock
    'AY': 6,  # rock paper
    'AZ': 0,  # rock scissors
    'BX': 0,  # paper rock
    'BY': 3,  # paper paper
    'BZ': 6,  # paper scissors
    'CX': 6,  # scissors rock
    'CY': 0,  # scissors paper
    'CZ': 3,  # scissors scissors
}

# X - Loose
# Y - Draw
# Z - Win

# rock 1
# paper 2
# scissors 3

outcome_reward_2 = {
    'X': 0,
    'Y': 3,
    'Z': 6
}

shape_reward_2 = {
    'AX': 3,  # rock scissors
    'AY': 1,  # rock rock
    'AZ': 2,  # rock paper
    'BX': 1,  # paper rock
    'BY': 2,  # paper paper
    'BZ': 3,  # paper scissors
    'CX': 2,  # scissors paper
    'CY': 3,  # scissors scissors
    'CZ': 1,  # scissors rock
}

score = 0
for round in rounds:
    round = round.rstrip()
    round = ''.join(round.split(' '))
    score += shape_reward[round[-1]] + outcome_reward[round]

print(f'Round 1 Final score - {score}')

score2 = 0
for round in rounds:
    round = round.rstrip()
    round = ''.join(round.split(' '))
    score2 += shape_reward_2[round] + outcome_reward_2[round[-1]]
print(f'Round 2 Final score {score2}')
