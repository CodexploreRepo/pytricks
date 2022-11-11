# Pandas
## Basics
### Set & reset indexes
- Set column as index: 
  - `df.set_index("col_name_1", inplace=True)` or `df.set_index(["col_name_1", "col_name_2"], inplace=True)`
  - `df = pd.read_csv(data_path, index_col="col_name_1")` 
- Reset columne index `df.reset_index(drop=True)`: to reset the index of the dataframe
```Python
#drop = True, to not retain the old index as a column
df = df.reset_index(drop=True)
```
### `nan` values:
- `df.dropna()`: by default, will drop axis=0 (row), and how='any' &#8594; drop any row if it contains any `nan` value.
### Frequently-used commands
- `df.sample(n=5, random_state=1)`: randomly select 5 samples from the dataframe
- `df[col].unique().tolist()`: to get List of Unique values in a column
### Display
- `pd.set_option('display.float_format',lambda x: f'{x.2f}')`  to set  output to 2 decimals
### `.str`
- **.contains**
  - `df[~df[col].str.contains("Addendum|Endorsement|Payslips")]`: to select rows containing/not containing multiple selected values

## Select and Index
- Indexing Pandas DF: integer rows, named columns
  - `df.iloc[880, [df.columns.get_loc(c) for c in ['filename','label']]]` 
  - Without a column, say `"label"` : `df.loc[:, df.columns != "label"]`
- Select with Multiple Conditions: 
  - AND: `df.loc[(df.col_1.isnull())&(df.col2 == 'Mr'), 'col3_name']`
  - OR: `df.loc[(df.col_1.isnull())|(df.col2 == 'Mr'), 'col3_name']`
## Merge & Concat DataFrame
### Concat
- Column Concat: `pd.concat([df_1, df_2], axis= 1, ignore_index=True)`
- Row Concat: `pd.concat([df_1, df_2], axis= 0, ignore_index=True)`

### Merge
- `df1.merge(df2, left_on='df1_id', right_on='df2_id')`: by default, `how='inner'` join
## Save and Load DataFrame
- Deep copy DataFrame
```Python
train_bkp = train_df.copy(deep=True)
test_bkp = test_df.copy(deep=True)
```
- DataFrame can be stored as pickle files
```Python
#Save DataFrame
df.to_pickle('../data/cleaned_train_v2.pkl')
#Load DataFrame
df = pd.read_pickle('../data/cleaned_test_v2.pkl')
```
## Apply and Lambda Function
- To modified the data in the col
```Python
num_regex = re.compile(r'[0-9]+')
df["col"].apply(lambda x: len(num_regex.findall(x)))
 
#preprocess_data: is a separate function
df["col"].apply(lambda doc: preprocess_data(doc))  
```


