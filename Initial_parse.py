import pandas as pd

# load file, create DataFrame
headers = ['date', 'time', 'epoch', 'moteid',
           'temp', 'humidity', 'light', 'voltage']
df = pd.read_csv('data.txt', delimiter=' ', header=None,
                 parse_dates={"Datetime": [0, 1]}, names=headers)


# df = df.set_index('temp')

# round the seconds
df['Datetime'] = df['Datetime'].dt.round('1s')

# remove not full data
df.dropna(inplace=True)

# remove high/low temp, take date range
min_temp = 5
max_temp = 38
start_date = '2004-03-01 07:00'
finish_date = '2004-03-05 08:30'

df = df[(df['temp'] < max_temp) & (df['temp'] > min_temp)]
df = df[df['Datetime'].between(start_date, finish_date)]

# set column primary index to Datetime
df = df.set_index('Datetime')

# select columns to export
print(df)

# export the dataframe
df.to_csv('partition.csv')
