# Torch Models
## Tips
Here's some tricks you can try that are especially helpful with deeper networks:
- Add [`BatchNorm`](https://pytorch.org/docs/stable/generated/torch.nn.BatchNorm1d.html)
layers, which can improve
[training stability and loss conditioning](https://myrtle.ai/how-to-train-your-resnet-7-batch-norm/)
- Add a linear "skip connection" layer that is applied to the inputs and whose outputs are added directly to the last layer's outputs
## 
## Torch Function
- `import torch.nn.functional as F` for stateless computation
  - includes: `F.cross_entropy`, `F.log_softmax` 
- `device = torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")` check GPU/CPU
- `torch.flatten(x, start_dim, end_dim)` flattens input by reshaping it into a one-dimensional tensor
  - If start_dim or end_dim are passed, only dimensions starting with start_dim and ending with end_dim are flattened. 
