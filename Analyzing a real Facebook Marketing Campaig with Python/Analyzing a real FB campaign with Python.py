#!/usr/bin/env python
# coding: utf-8

# <center><h1><b><font size="5">Analyzing a Facebook Campaign with Paython - Overall Campaign Performance</font></b></h1></center>

# ### Facebook Metrics Refresher

# #### 1. Reach: 
# 
# The number of unique people who saw your ad.
# 
# #### 2. Impressions: 
# 
# The total number of times an ad was displayed on your audience's screen.
# 
# #### 3. Clicks (All): 
# 
# The total number of clicks your ad received, including clicks on the like and share buttons.
# 
# #### 4. Link Clicks: 
# 
# The number of clicks on an ad link that leads to a specified destination.
# 
# #### 5. CTR: 
# 
# $\displaystyle \frac{\text{Total Clicks}}{\text{Total Impressions}} \times 100$
# 
# #### 6. Conversions: 
# 
# The number of times users completed the desired action.
# #### 7. Conversion Rate: 
# 
# $\displaystyle \frac{\text{Number of Conversions}}{\text{Total Results}}$
# 
# #### 8. CPM (Cost per Thousand Impressions):
# 
# $\displaystyle \frac{\text{Total Amount Spent}}{\text{Total Impressions}} \times 1000$
# 
# #### 9. CPC (Cost per Link Click)
# 
# $\displaystyle \frac{\text{Total Amount Spent}}{\text{Total Link Clicks}}$
# 
# #### 10. CPR (Cost per Result):
# $\displaystyle \frac{\text{Total Amount Spent}}{\text{Total Results}}$

# ## Step 1: Examine the Dataset

# In[3]:


import pandas as pd 
df = pd.read_csv('./data/365DS_Adsets.csv')
df.head()


# In[4]:


df.info()


# ## Step 2:Campaign Highlights

# In[7]:


df[["Reach","Impressions","Link Clicks","Landing Page Views","Results","Amount Spent"]].sum()


# ## Campaign Highlights
# 
# 1. We reached around 450K unique people.
# 2. Approx 1.1 million impressions.
# 3. Each person saw the ad around 2.5 times.
# 4. Approx 5.6K link clicks and 2.9K landing page views.
# 5. Total of 83 results.
# 6. Spent 4,362 EUR.

# #### 8. CPM (Cost per 1000 Impressions):
# 
# $\displaystyle \frac{\text{Total Amount Spent}}{\text{Impressions}} \times 1000$

# In[8]:


((df['Amount Spent']/df['Impressions'])*1000).mean()


# In[9]:


df.head()


# In[10]:


df['CPM'].mean()


# ### 5. CTR (Click through Rate):
# 
# $\displaystyle \frac{\text{Total Link Clicks}}{\text{Total Impressions}} \times 100$
# 
# 

# In[11]:


df.head(2)


# In[12]:


((df['Link Clicks']/df['Impressions'])*100).mean()


# In[13]:


df['CTR (all)'].mean()


# #### 10. CPR (Cost per Result):
# 
# $\displaystyle \frac{\text{Total Amount Spent}}{\text{Total Results}} \$

# In[14]:


df.head(1)


# In[15]:


(df['Amount Spent']/df['Results']).mean()


# In[16]:


#remove o values
df_not_zero = df[df['Results']!=0]


# In[17]:


(df_not_zero['Amount Spent']/df_not_zero['Results']).mean()


# In[18]:


df['CPR'].mean()


# <center><h1><b><font size="5">Analyzing a Facebook Campaign with Paython - Ad Set Overview</font></b></h1></center>

# ## Step 3: Ad Set Overview

# In[19]:


df['Ad Set Name'].unique()


# ### Hot, Warm, and Cold Ad Sets

# In[20]:


def categorize_ad_set(ad_set_name):
    if 'Warm' in ad_set_name:
        return 'Warm'
    elif 'HOT' in ad_set_name:
        return 'Hot'
    else:
        return 'Cold'

    #new column category 
df['Category'] = df['Ad Set Name'].apply(categorize_ad_set)
df.head()


# In[21]:


#find the mean
#new dataframe called results
results = df.groupby('Category').agg({'Reach':'mean','Impressions':'mean',
                                    'CTR (all)':'mean','Results':'mean',
                                    'CPR':'mean'})

results


# ### Looalike vs Detailed Targeting

# In[22]:


df['Ad Set Name'].unique()


# In[23]:


def categorize_ad_set_2(ad_set_name):
    if('DT' in ad_set_name):
        return 'Detailed Targeting' #DT
    elif('LLA' in ad_set_name):
        return 'Lookalike Audience' #LLA
    else:
        return 'Other'

#new columns subcategory
df['Subcategory'] = df['Ad Set Name'].apply(categorize_ad_set_2)


# In[24]:


df_cold = df[df['Category']=='Cold']


# In[25]:


df_cold = df_cold.groupby('Subcategory').agg({'Reach':'mean','Impressions':'mean',
                                    'CTR (all)':'mean','Results':'mean',
                                    'CPR':'mean'})

df_cold


# In[29]:


import matplotlib.pyplot as plt
import seaborn as sns

import warnings

# Ignore all warnings
warnings.filterwarnings("ignore")


# In[27]:


df_transformed = df_cold.reset_index().melt('Subcategory')
df_transformed


# In[30]:


viz = sns.FacetGrid(df_transformed, col='variable', col_wrap=3, sharex=False,
                   sharey=False, height=4, aspect=1.5)

viz.map(sns.barplot, 'Subcategory', 'value', order=df_cold.reset_index()['Subcategory'])

plt.show()


# <center><h1><b><font size="5">Analyzing a Facebook Campaign with Paython - Detailed Ad Set Analysis</font></b></h1></center>

# ## Step 4: Detailed Ad Set Analysis

# ### Hot

# In[31]:


df_hot = df[df['Category']=='Hot']
df_hot = df_hot.reset_index()


# ### Top-Funnel Metrics

# In[32]:


def top_funnel_metrics(df):
    fig, axs = plt.subplots(1, 3, figsize=(19,5)) #matplot viz
    
    sns.barplot(x='Ad Set Name', y='Reach', data=df, ax=axs[0]) #sns subplot
    axs[0].set_title('Reach')
    
    sns.barplot(x='Ad Set Name', y='Impressions', data=df, ax=axs[1])
    axs[1].set_title('Impressions')
    
    sns.barplot(x='Ad Set Name', y='CPM', data=df, ax=axs[2])
    axs[2].set_title('CPM')
    
    for ax in axs: #for loop
        for label in ax.get_xticklabels():
            label.set_rotation(90)
            
    plt.show()
    
top_funnel_metrics(df_hot)


# ### Mid-Funnel Metrics

# In[33]:


def mid_funnel_metrics(df):
    fig, axs = plt.subplots(1, 3, figsize=(19,5))
    
    sns.barplot(x='Ad Set Name', y='CTR (all)', data=df, ax=axs[0])
    axs[0].set_title('CTR (all)')
    
    sns.barplot(x='Ad Set Name', y='Landing Page Views', data=df, ax=axs[1])
    axs[1].set_title('Landing Page Views')
    
    sns.barplot(x='Ad Set Name', y='CPC', data=df, ax=axs[2])
    axs[2].set_title('CPC')
    
    for ax in axs:
        for label in ax.get_xticklabels():
            label.set_rotation(90)
    
    plt.show()
    
mid_funnel_metrics(df_hot)


# ### Bottom-Funnel Metrics

# In[34]:


def bottom_funnel_metrics(df):
    fig, axs = plt.subplots(1, 2, figsize=(19,5))
    
    sns.barplot(x='Ad Set Name', y='Results', data=df, ax=axs[0])
    axs[0].set_title('Results')
    
    sns.barplot(x='Ad Set Name', y='CPR', data=df, ax=axs[1])
    axs[1].set_title('CPR')
    
    for ax in axs:
        for label in ax.get_xticklabels():
            label.set_rotation(90)
    
    plt.show()
    
bottom_funnel_metrics(df_hot)


# In[35]:


sns.barplot(x='Ad Set Name', y='Amount Spent', data=df_hot)


# ### Warm

# In[36]:


df_warm = df[df['Category']=='Warm']
df_warm = df_warm.reset_index()


# In[37]:


top_funnel_metrics(df_warm)


# In[38]:


mid_funnel_metrics(df_warm)


# In[39]:


sns.barplot(x='Ad Set Name', y='Link Clicks', data=df_warm)


# In[40]:


bottom_funnel_metrics(df_warm)


# ### Cold

# In[41]:


df_cold = df[df['Category']=='Cold']
df_cold = df_cold.reset_index()


# In[42]:


def all_cold_adsets(df, metrics, ad_set_types=['Lookalike Audience','Detailed Targeting']):
    
    fig, axes = plt.subplots(nrows=len(metrics), ncols=len(ad_set_types), figsize=(12,11), sharey='row')
    
    for i, metric in enumerate(metrics):
        for j, ad_set_type in enumerate(ad_set_types):
            filtered_df = df[df['Subcategory']==ad_set_type]
            ax = axes[i,j]
            sns.barplot(x='Ad Set Name', y=metric, data=filtered_df, ax=ax)
            ax.set_title(f'{metric}-{ad_set_type}')
            ax.set_xticklabels(ax.get_xticklabels(), rotation=90)
            
    plt.tight_layout()
    plt.show()


# In[43]:


top_funnel_metrics = ['Reach', 'Impressions', 'CPM']
all_cold_adsets(df_cold, top_funnel_metrics)


# ### Mid-Funnel Metrics

# In[44]:


mid_funnel_metrics = ['CTR (all)','CPC','Landing Page Views']
all_cold_adsets(df_cold, mid_funnel_metrics)


# ### Bottom-Funnel Metrics

# In[45]:


bottom_funnel_metrics = ['Results','CPR','Amount Spent']
all_cold_adsets(df_cold, bottom_funnel_metrics)

