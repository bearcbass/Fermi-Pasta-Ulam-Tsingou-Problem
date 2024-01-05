import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import math

def get_parameters(file_path):
    parameters_dict = {}

    with open(file_path, 'r') as file:
        for line in file:
            # Split each line into words
            words = line.split()

            # Check if the line contains key-value pairs
            if len(words) == 2:
                key, value = words
                parameters_dict[key] = float(value) if '.' in value else int(value)

    return parameters_dict

def get_exactsol(time,k):

    for i in range(0,len(time)):

        time[i] = math.sin(math.sqrt(2*k)*time[i]) / math.sqrt(2*k)

    return time

if __name__=="__main__":
    # Read in data file

    # We get the data
    data = np.loadtxt('sol.dat')
    print(type(data))
    print(data.shape)
    selected_columns = data[:, 1:data.shape[1]-1]

    # Find the column in the middle of the selected columns
    middle_column_index = (selected_columns.shape[1] - 1) // 2
    middle_column = selected_columns[:, middle_column_index]    
    
    # We get our parameters
    dictionary = get_parameters('parameters.dat')
    print(dictionary)
    dt = dictionary['dt']

    nSteps = dictionary['nSteps']
    C = dictionary['C']

    #Time management stuff
    time = np.arange(0, dictionary['nSteps'])
    
    
    total_time = dt * time
    reserved_total_time = total_time.copy()

    lengthTime = len(total_time)
    solutions = get_exactsol(total_time, dictionary['K'])
    
    """
    fig,ax = plt.subplots()

    max_value = np.max(data[:,1])
    low_value = np.min(data[:,1])

    ax.plot(range(0,len(data[:,2])), data[:,1], '-k.',linewidth=2,label='Numerical Sol')
    ax.plot(range(0, len(data[:, 2])), solutions[:], color='pink', linewidth=2, linestyle='dotted', label='Exact Sol')
    plt.xlim([0, len(data[:,2])+1])
    
    # Labeling our graph
    subtitle_text = f'dt: {dt}, nSteps: {nSteps}'
    plt.title('Part A Graph', y=1.05)
    plt.suptitle(subtitle_text, y=0.92, fontsize=12)

    plt.xlabel('numSteps')
    plt.ylabel('X')
    
    plt.legend(loc='upper right')
    plt.savefig('PartABadLook',dpi=300)

    """

    """
    This the single mass plot
    """
    plt.plot(reserved_total_time, middle_column, '-k',linewidth=1)
    
    subtitle_text = f'dt: {dt}, nSteps: {nSteps} C: {C}'
    plt.title('Part D N=32 0.96', y=1.05)
    plt.suptitle(subtitle_text, y=0.92, fontsize=12)

    plt.xlabel('Time')
    plt.ylabel('X')

    plt.savefig('PartD096_single_32',dpi=300)
    

    """
    This is the plot of all the masses
    """
    # So for this I just need specific points of time
    # we need 1/4, 1/2,3/4, and final time
    # this is for all masses.
    # so if we have all time: in reserved_total_time
    # then what we can do, is just get all the partitions of it.

    selected_columns = data[:, 1:data.shape[1]-1]
    

    fractions = [1/4, 1/2, 3/4, 1]

    # Calculate indices corresponding to the fractions
    indices = (np.array(fractions) * (dictionary['nSteps'] - 1)).astype(int)

    selected_data = selected_columns[indices][:]

    # Select values based on the calculated indices
    selected_values = reserved_total_time[indices]
    print(selected_data)

    plt.figure(2)

    
    indices1 = np.array(range(1,dictionary['nMasses']+1))
    print("These are the indices ",indices1)

    print("Length of indices", len(indices1))
    

    plt.plot(indices1, selected_data[0][:], '-o', label='T_f/4' )
    plt.plot(indices1, selected_data[1][:], '-o',label='T_f/2')
    plt.plot(indices1, selected_data[2][:], '-o',label='T_f3/4')
    plt.plot(indices1, selected_data[3][:], '-o',label='T_f')
    
    plt.xlabel('Mass_i')
    plt.ylabel('Displacement')
    plt.title('All Masses for Part D.96')
    plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left', borderaxespad=0., fontsize='small')
    plt.tight_layout()
    plt.savefig('PartD_96AllMasses.png',dpi=300)
