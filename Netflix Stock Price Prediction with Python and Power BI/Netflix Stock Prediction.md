# Netflix Stock Prediction


```python
import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
# Now some of Visualisation libraries
import matplotlib.pyplot as plt
import seaborn as sns
```

### DATA & EDA


```python
df= pd.DataFrame(pd.read_csv("data/NFLX.csv"))
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Date</th>
      <th>Open</th>
      <th>High</th>
      <th>Low</th>
      <th>Close</th>
      <th>Adj Close</th>
      <th>Volume</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2018-02-05</td>
      <td>262.000000</td>
      <td>267.899994</td>
      <td>250.029999</td>
      <td>254.259995</td>
      <td>254.259995</td>
      <td>11896100</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2018-02-06</td>
      <td>247.699997</td>
      <td>266.700012</td>
      <td>245.000000</td>
      <td>265.720001</td>
      <td>265.720001</td>
      <td>12595800</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2018-02-07</td>
      <td>266.579987</td>
      <td>272.450012</td>
      <td>264.329987</td>
      <td>264.559998</td>
      <td>264.559998</td>
      <td>8981500</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2018-02-08</td>
      <td>267.079987</td>
      <td>267.619995</td>
      <td>250.000000</td>
      <td>250.100006</td>
      <td>250.100006</td>
      <td>9306700</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2018-02-09</td>
      <td>253.850006</td>
      <td>255.800003</td>
      <td>236.110001</td>
      <td>249.470001</td>
      <td>249.470001</td>
      <td>16906900</td>
    </tr>
  </tbody>
</table>
</div>



### Setting Date to Index


```python
df.set_index('Date', inplace=True)
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Open</th>
      <th>High</th>
      <th>Low</th>
      <th>Close</th>
      <th>Adj Close</th>
      <th>Volume</th>
    </tr>
    <tr>
      <th>Date</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2018-02-05</th>
      <td>262.000000</td>
      <td>267.899994</td>
      <td>250.029999</td>
      <td>254.259995</td>
      <td>254.259995</td>
      <td>11896100</td>
    </tr>
    <tr>
      <th>2018-02-06</th>
      <td>247.699997</td>
      <td>266.700012</td>
      <td>245.000000</td>
      <td>265.720001</td>
      <td>265.720001</td>
      <td>12595800</td>
    </tr>
    <tr>
      <th>2018-02-07</th>
      <td>266.579987</td>
      <td>272.450012</td>
      <td>264.329987</td>
      <td>264.559998</td>
      <td>264.559998</td>
      <td>8981500</td>
    </tr>
    <tr>
      <th>2018-02-08</th>
      <td>267.079987</td>
      <td>267.619995</td>
      <td>250.000000</td>
      <td>250.100006</td>
      <td>250.100006</td>
      <td>9306700</td>
    </tr>
    <tr>
      <th>2018-02-09</th>
      <td>253.850006</td>
      <td>255.800003</td>
      <td>236.110001</td>
      <td>249.470001</td>
      <td>249.470001</td>
      <td>16906900</td>
    </tr>
  </tbody>
</table>
</div>




```python
df[['Open', 'Close', 'High','Low','Close','Adj Close']].plot(figsize=(18,5))
plt.title(" Netflix Stock Plot for Overall Period", fontsize=17)
```




    Text(0.5, 1.0, ' Netflix Stock Plot for Overall Period')




    
![png](output_6_1.png)
    


#### Top-5 Dates with Highest Stock Price


```python
a = df.sort_values(by='High',ascending= False).head(5)
a['High']
```




    Date
    2021-11-17    700.989990
    2021-11-19    694.159973
    2021-11-18    691.739990
    2021-10-29    690.969971
    2021-11-01    689.969971
    Name: High, dtype: float64



#### Top-5 Dates with Lowest Stock Price


```python
b = df.sort_values(by='Low',ascending= True).head(5)
b['Low']
```




    Date
    2018-12-26    231.229996
    2018-12-24    233.679993
    2018-02-09    236.110001
    2018-12-27    240.100006
    2018-12-21    241.289993
    Name: Low, dtype: float64




```python
fig,axes= plt.subplots(nrows=1,ncols=2, sharex=True, figsize=(12,5))
fig.suptitle('High & Low Values Stock per Period of Time',fontsize=18)
sns.lineplot(ax= axes[0], y=df['High'],x=df.index, color='green')
axes[0].set_title('High Value Stock')
sns.lineplot(ax= axes[1], y=df['Close'], x=df.index, color='red')
axes[1].set_title('Low Value Stock')
plt.tight_layout()
plt.show()
```


    
![png](output_11_0.png)
    



```python

```
