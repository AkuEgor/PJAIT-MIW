import numpy

Signs = ['Rock', 'Paper', 'Scissors']
Initial_probability = [0.23, 0.44, 0.33]

Transition_matrix = [
    #   Rock | Paper | Scissors
        [0.27, 0.43, 0.3], # Rock
        [0.24, 0.3, 0.46], # Paper
        [0.2, 0.6, 0.2]    # Scissors
]

Emission_matrix = [
         #  0  |  1  |  -1
         [0.28, 0.42, 0.3],  # Rock
         [0.15, 0.23, 0.62], # Paper
         [0.4, 0.5, 0.1]     # Scissors
]


state = numpy.random.choice(Signs, replace=True, p=Initial_probability)
result = 0
print(" Predictions: | - result - | - state - | - response - | ")
for x in range(1, 31):
    response = ''


    if state == 'Rock':
        response = numpy.random.choice(Signs, replace=True, p=Emission_matrix[0])
        state = numpy.random.choice(Signs, replace=True, p=Transition_matrix[0])
    elif state == 'Paper':
        response = numpy.random.choice(Signs, replace=True, p=Emission_matrix[1])
        state = numpy.random.choice(Signs, replace=True, p=Transition_matrix[1])
    else:
        response = numpy.random.choice(Signs, replace=True, p=Emission_matrix[2])
        state = numpy.random.choice(Signs, replace=True, p=Transition_matrix[2])
      

    if state == 'Rock':
        if response == 'Rock':
            result = 0
        elif response == 'Paper':
            result = -1
        else:
            result = 1
    elif state == 'Paper':
        if response == 'Rock':
            result = 1
        elif response == 'Paper':
            result = 0
        else:
            result = -1
    else:
        if response == 'Rock':
            result = -1
        elif response == 'Paper':
            result = 1
        else:
            result = 0
    print("           {}  |     {}        {}       {}   "
          .format(x, result, state, response))