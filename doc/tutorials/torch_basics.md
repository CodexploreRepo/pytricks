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

### 1.2. Numpy and Tensor conversion
#### 1.2.1. Numpy to Tensor
- Tensors can be converted to numpy arrays, and numpy arrays back to tensors.
- To transform a numpy array into a tensor, we can use the function `torch.from_numpy`:
```Python
np_arr = np.array([[1, 2], [3, 4]])
tensor = torch.from_numpy(np_arr)

print("Numpy array:", np_arr)
print("PyTorch tensor:", tensor)
```
- `map()` function
```Python
import torch

x_train, y_train, x_valid, y_valid = map(
    torch.tensor, (x_train, y_train, x_valid, y_valid)
)
```
#### 1.2.2. Tensor to Numpy
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

### 3.2. Matrix Multiplication
- * `torch.matmul(x, W)` Performs the matrix product over two tensors, where the specific behavior depends on the dimensions.
  - Can also be written as `a @ b`, similar to numpy.

## 4. Dynamic Computation Graph and Backpropagation
### 4.1. Dynamic computation graph 
- Given an input $\mathbf{x}$, we define our function by **manipulating** that input, usually by matrix-multiplications with weight matrices and additions with so-called bias vectors.
- As we manipulate our input, we are automatically creating a **computational graph**.
  - This graph shows how to arrive at our output from our input.
  - PyTorch is a **define-by-run** framework; this means that we can just do our manipulations, and PyTorch will keep track of that graph for us.
  - Thus, we create a `dynamic computation graph` along the way.

### 4.2. Why do we want gradients?
- Consider that we have defined a function, a neural net, that is supposed to compute a certain output $y$ for an input vector $\mathbf{x}$.
- We then define an **error measure** that tells us how wrong our network is; how bad it is in predicting output $y$ from input $\mathbf{x}$.
- Based on this error measure, we can use the gradients to **update** the weights $\mathbf{W}$ that were responsible for the output, so that the next time we present input $\mathbf{x}$ to our network, the output will be closer to what we want.

### 4.3. Example
- In order to get familiar with the concept of a computation graph, we will create one for the following function:
$$y = \frac{1}{|x|}\sum_i \left[(x_i + 2)^2 + 3\right]$$
- You could imagine that $x$ are our parameters, and we want to optimize (either maximize or minimize) the output $y$.
- For this, we want to obtain the gradients $\partial y / \partial \mathbf{x}$.
- For our example, we'll use $\mathbf{x}=[0,1,2]$ as our input.

```Python
x = torch.arange(3, dtype=torch.float32, requires_grad=True)  # Only float tensors can have gradients
print("X", x) #X tensor([0., 1., 2.], requires_grad=True)

# let's build the computation graph step by step. 
a = x + 2
b = a**2
c = b + 3
y = c.mean()
```
- Using the statements above, we have created a computation graph that looks similar to the figure below:
<p align="center"><img src="https://github.com/PyTorchLightning/lightning-tutorials/raw/main/course_UvA-DL/01-introduction-to-pytorch/pytorch_computation_graph.svg" width="200px"></p>

- We can perform backpropagation on the computation graph by calling the function `backward()` on the last output, which effectively calculates the gradients for each tensor that has the property `requires_grad=True`:
- `x.grad` will now contain the gradient $\partial y/ \partial \mathcal{x}$, and this gradient indicates how a change in $\mathbf{x}$ will affect output $y$ given the current input $\mathbf{x}=[0,1,2]$:
```Python
y.backward()
print(x.grad) #tensor([1.3333, 2.0000, 2.6667])
```

- We can also verify these gradients by hand. We will calculate the gradients using the chain rule, in the same way as PyTorch did it:
  - Note that we have simplified this equation to index notation, and by using the fact that all operation besides the mean do not combine the elements in the tensor.
  
$$\frac{\partial y}{\partial x_i} = \frac{\partial y}{\partial c_i}\frac{\partial c_i}{\partial b_i}\frac{\partial b_i}{\partial a_i}\frac{\partial a_i}{\partial x_i}$$

- The partial derivatives are:

$$
\frac{\partial a_i}{\partial x_i} = 1,\hspace{1cm}
\frac{\partial b_i}{\partial a_i} = 2\cdot a_i\hspace{1cm}
\frac{\partial c_i}{\partial b_i} = 1\hspace{1cm}
\frac{\partial y}{\partial c_i} = \frac{1}{3}
$$

- Hence, with the input being $\mathbf{x}=[0,1,2]$ ($\mathbf{a}=[2,3,4]$), our gradients are $\partial y/\partial \mathbf{x}=[4/3,2,8/3]$.
- The previous code cell should have printed the same result.
