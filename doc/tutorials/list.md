# List

# List Concat
- We can use the `sum(list, start=[])` function to concat the list, say if we want to concat `[[1], [2], [3,4]]` &#8594; `[1, 2, 3, 4]`
  - `start=[]` means that we will start the sum with the empty list element, instead of 0, so Python will know that it is a list concat operation.

```Python
l_int = [1,2,3,4]
sum(l_int) #10
sum(l_int, start = 0) # 10

l = [[1], [2], [3,4]]
sum(l, start=[])  # [1, 2, 3, 4]
sum(l, start=[0]) # [0, 1, 2, 3, 4]
```



