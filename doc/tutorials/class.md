# Class

## `__call__` method
```Python
class MSE:
  def __call__(self, y_pred, y_true):
    return ((y_true - y_pred) ** 2).mean()
  
loss = MSE()
print(f'Our initial loss is {loss(y_pred, y_true):.2f}')
```
