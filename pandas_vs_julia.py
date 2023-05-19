# SETUP

import pandas as pd
import numpy as np

# Data Structures

s = pd.Series(['a', 'b', 'c'], index=[0, 1, 2])  # Series
print(s, s[0])
df = pd.DataFrame({'col_1': [11, 12, 13], 'col_2': [
                  21, 22, 23]}, index=[0, 1, 2])
data = np.random.randint(0, 10, size=(10, 3))
df_random = pd.DataFrame(data, columns=list('abc'))
print(df, '\n', df['col_1'], '\n', df['col_1'][0])
print(data, '\n', df_random)

# Write/Read

df_random.to_csv('python_file.csv')
df_random.to_json('python_file.json')
df = pd.read_csv('python_file.csv')
df_json = pd.read_json('python_file.json')
url = pd.read_csv(
    'https://raw.githubusercontent.com/plotly/datasets/master/solar.csv')
df_delim = pd.read_fwf('delim_file.txt')

# Inspect Data

df.head(6)
df.tail(6)
df.describe()
df.loc[:, :'a'].describe()

# Select Data

df.loc[1:3, :]  # rows 1-3, all columns
df.loc[[1, 2, 3], :]  # rows 1,2,3, all columns
df.loc[:, ['a', 'b']].copy()  # select columns a and b(copy)
df.loc[:, ['a']]  # select column a (non-copy) reference
df.loc[1:3, ['b', 'a']]  # select rows 1-3, columns b and a
df.loc[[3, 1], ['b', 'a']]  # select rows 3 and 1, columns b and a(reverse)
df[df['a'].isna()]  # select NaN values
df['a'].dropna()  # drop NaN values

# Add rows/columns

df['new col'] = df['col'] * 100  # add new column
df['new col'] = False  # add new column
df.loc[-1] = [1, 2, 3]  # add new row ate
df2 = df.append(df, ignore_index=True)  # assign new df

# Drop Data

s.drop(1)  # drop row 1
s.drop([1, 2])  # drop rows 1 and 2
df.drop('b', axis=1)  # drop column b
df.dropna()  # drop NaN values
df.dropna(axis=1)  # drop NaN values in columns 0

# Sort values/index

sorted([2, 1, 3])  # sort values
sorted([2, 1, 3], reverse=True)  # sort values in reverse
df['a'].sort_values()  # sort column a
df.sort_values(['a', 'b'], ascending=[True, False])  # sort columns a and b

# Filter
df.loc[:, df.isna().any()]
df[df['cols_1'] > 100]  # values greater than 100
df[(df['a'] == 'a') & (df['b'] >= 10)]  # multiple conditions
df[df['a'] == 'test']  # filter by string
df[(df['a'] == 'test') & (df['b'] == 'a2')]  # combine conditions

# Groupby

df.groupby('a')  # group by single col
df.groupby(['a', 'b']).c.sum()  # group by multiple cols and sum third
df['a'].value_counts()  # group by and count

# Convert
df['a'].fillna(0)  # fill NaN values with 0
df.replace('..', None)  # replace .. with None
df['col_1'].astype('int64')  # convert to int64
pd.to_datetime(df['date'], format='%Y-%m-%d')
