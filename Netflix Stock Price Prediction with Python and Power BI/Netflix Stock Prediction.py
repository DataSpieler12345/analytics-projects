#!/usr/bin/env python
# coding: utf-8

# # Netflix Stock Prediction

# In[2]:


import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
# Now some of Visualisation libraries
import matplotlib.pyplot as plt
import seaborn as sns


# ### DATA & EDA

# In[3]:


df= pd.DataFrame(pd.read_csv("data/NFLX.csv"))
df.head()


# ### Setting Date to Index

# In[4]:


df.set_index('Date', inplace=True)
df.head()


# In[5]:


df[['Open', 'Close', 'High','Low','Close','Adj Close']].plot(figsize=(18,5))
plt.title(" Netflix Stock Plot for Overall Period", fontsize=17)


# #### Top-5 Dates with Highest Stock Price

# In[6]:


a = df.sort_values(by='High',ascending= False).head(5)
a['High']


# #### Top-5 Dates with Lowest Stock Price

# In[8]:


b = df.sort_values(by='Low',ascending= True).head(5)
b['Low']


# In[9]:


fig,axes= plt.subplots(nrows=1,ncols=2, sharex=True, figsize=(12,5))
fig.suptitle('High & Low Values Stock per Period of Time',fontsize=18)
sns.lineplot(ax= axes[0], y=df['High'],x=df.index, color='green')
axes[0].set_title('High Value Stock')
sns.lineplot(ax= axes[1], y=df['Close'], x=df.index, color='red')
axes[1].set_title('Low Value Stock')
plt.tight_layout()
plt.show()


# In[ ]:




