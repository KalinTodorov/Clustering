
import matplotlib.pyplot as plt
import pandas as pd
from datetime import datetime
import numpy as np
from statsmodels.tsa.filters.hp_filter import hpfilter
from sklearn.neighbors import NearestNeighbors
from kshape.core import kshape, zscore
# parse the time for the given format


def dateparse(x): return datetime.strptime(x, '%Y-%m-%d %H:%M:%S')


# load file
df = pd.read_csv('partition2.csv', delimiter=',', header=0,
                 parse_dates=['Datetime'], date_parser=dateparse)
df = df.set_index('Datetime')



time_series = []
sensor_number = 0
for key, group in df.groupby('moteid'):
    if(key <= 3 or key == 44 or key > 50 and key < 54):
        temp_cycle, temp_trend = hpfilter(group['temp'], lamb=1600)
        sample_temp = temp_trend.resample('5min').mean()
        time_series.append(sample_temp.tolist())
        sample_temp.plot(label=sensor_number)
        sensor_number = sensor_number + 1


X = np.array(time_series)
nbrs = NearestNeighbors(n_neighbors=5,  algorithm='ball_tree').fit(X)
distances, indices = nbrs.kneighbors(X)

print('------------- distance---------------')
print(distances)
print('instance')
print(indices)


cluster_num = 2
clusters = kshape(zscore(time_series, axis=1), cluster_num)
print("k shape:")
print(clusters)


plt.ylabel('Temperature')
plt.title('Sensor Temperature Data')
plt.legend()
plt.show()
