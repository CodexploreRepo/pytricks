# Torch Basics
## 1. Tensor Creation
* `torch.zeros`: Creates a tensor filled with zeros
* `torch.ones`: Creates a tensor filled with ones
* `torch.rand`: Creates a tensor with random values uniformly sampled between 0 and 1
* `torch.randn`: Creates a tensor with random values sampled from a normal distribution with mean 0 and variance 1
* `torch.arange`: Creates a tensor containing the values $N,N+1,N+2,...,M$
* `torch.Tensor` (input list): Creates a tensor from the list elements you provide
### 1.1. Size
- You can obtain the shape of a tensor in the same way as in numpy (`x.shape`), or using the `.size` method

```Python
shape = x.shape
print("Shape:", x.shape)

size = x.size()
print("Size:", size)

dim1, dim2, dim3 = x.size()
print("Size:", dim1, dim2, dim3)

#Shape: torch.Size([2, 3, 4])
#Size: torch.Size([2, 3, 4])
#Size: 2 3 4
```

### 1.2. Tensor to Numpy, and Numpy to Tensor
- Tensors can be converted to numpy arrays, and numpy arrays back to tensors.
- To transform a numpy array into a tensor, we can use the function `torch.from_numpy`:
```Python
np_arr = np.array([[1, 2], [3, 4]])
tensor = torch.from_numpy(np_arr)

print("Numpy array:", np_arr)
print("PyTorch tensor:", tensor)
```
- To transform a PyTorch tensor back to a numpy array, we can use the function `.numpy()` on tensors:
  - The conversion of tensors to numpy require the tensor to be on the CPU, and not the GPU. In case you have a tensor on GPU, you need to call `.cpu()` on the tensor beforehand. Hence, you get a line like `np_arr = tensor.cpu().numpy()`. 
```Python
tensor = torch.arange(4)
np_arr = tensor.numpy()

print("PyTorch tensor:", tensor)
print("Numpy array:", np_arr)
```

## 2. Tensor Modification
## 2.1. `View` & `Permute`
- `x = x.view(-1, 28*28)` same as reshape in Numpy `x.reshape(-1, 28*28)`
- `x = x.permute(1, 0)`  to swap dimension 0 and 1
## 2.2. `Squeeze` & `Unsqueeze`
- `.unsqueeze(input, dim)` returns a new tensor with a dimension of size one inserted at the specified position

  ```Python
  >>> x = torch.tensor([1, 2, 3, 4])
  >>> torch.unsqueeze(x, 0)
  tensor([[ 1,  2,  3,  4]])
  >>> torch.unsqueeze(x, 1)
  tensor([[ 1],
          [ 2],
          [ 3],
          [ 4]])
  ```
## 3. Tensor Operations
- A full list of operations can be found in the [PyTorch documentation](https://pytorch.org/docs/stable/tensors.html#)
### 3.1. In-place operations
- In-place operations are usually marked with a underscore postfix (e.g. `add_` instead of "add").

```Python
x1 = torch.rand(2, 3)
x2 = torch.rand(2, 3)

x2.add_(x1)
```
