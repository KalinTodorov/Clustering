
import matplotlib.pyplot as plt
import pandas as pd
from datetime import datetime
import numpy as np
from statsmodels.tsa.filters.hp_filter import hpfilter
from sklearn.neighbors import NearestNeighbors
# parse the time for the given format


def dateparse(x): return datetime.strptime(x, '%Y-%m-%d %H:%M:%S')


# load file
df = pd.read_csv('partition.csv', delimiter=',', header=0,
                 parse_dates=['Datetime'], date_parser=dateparse)

df = df.set_index('Datetime')
df1 = df[df['moteid'] == 1]['temp'].resample('12H').mean()
df2 = df[df['moteid'] == 2]['temp'].resample('12H').mean()
df3 = df[df['moteid'] == 3]['temp'].resample('12H').mean()
df50 = df[df['moteid'] == 50]['temp'].resample('12H').mean()
df51 = df[df['moteid'] == 51]['temp'].resample('12H').mean()
df1.plot(label='sensor 1  [0]')
df2.plot(label='sensor 2  [1]')
df3.plot(label='sensor 3  [2]')
df50.plot(label='sensor 50 [3]')
df51.plot(label='sensor 51 [4]')
plt.legend()
plt.ylabel('Temperature')
plt.title('Sensor Temperature Data')
plt.show()


u1 = list(df1.to_numpy())
u2 = list(df2.to_numpy())
u3 = list(df3.to_numpy())
u50 = list(df50.to_numpy())
u51 = list(df51.to_numpy())

X = np.array([u1, u2, u3, u50, u51])

nbrs = NearestNeighbors(n_neighbors=3,  algorithm='ball_tree').fit(X)
distances, indices = nbrs.kneighbors(X)
print('------------- distance---------------')
print(distances)
print('instance')
print(indices)
