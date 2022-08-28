# Dict
## Access a value in Dict vs Key
- `dict_a.get("key_1", 0)` if the key_1 is not exist, then return value 0.
## Sorting a Dict
- Based on values: `dict(sorted(name_diff.items(), key=lambda x: x[1], reverse = True))`

# Default Dict
- Return the default value if the key does not exists
```Python
from collections import defaultdict
 # Function to return a default values for keys that is not present
def def_value():
    return "Not Present"
      
# Defining the dict
d = defaultdict(def_value)
d["a"] = 1
d["b"] = 2
  
print(d["a"]) #1
print(d["b"]) #2
print(d["c"]) #Not Present - Default value when key is not exist
```
- A simplified version of `def_value` function using `lambda`
```Python
x = defaultdict(lambda: defaultdict(lambda: 0)) 
# x[key1][sub_key] returns 0 if sub_key does not exist
# x[key1] returns a defaultdict(lambda: 0))
```
- Specify the type of `defaultdict` like `List`
```Python
defaultdict(list)
```
