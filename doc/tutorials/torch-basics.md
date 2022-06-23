# Torch Basics

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
