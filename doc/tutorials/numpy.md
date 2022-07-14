# Numpy

## Indexing
```Python
# Initialize a numpy ndarray with 3 rows, 2 columns
X = np.ones((3, 2))

# We can set values of a whole row
X[0, :] = 1.5

# Check if any element in the array greater than 1
X > 1
#array([[ True,  True],
#       [False, False],
#       [False, False]])


# Masking
X[X < 1] = -1

```

## Matrix multiplication
- [Dot Product](http://matrixmultiplication.xyz/)
  ```Python
  X = np.zeros((3, 2)) #(3,2)
  x = np.array([[10, 20],]).T #x = (1,2), x.T = (2,1)

  result = X @ x  # alternatively, np.dot(X, x)
  ```
