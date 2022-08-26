# Wandb 

## Log Media & Objects
- Log Tensor into an image

```Python
import wandb  # just for some convenience methods that convert tensors to human-friendly datatypes

wandb.Image(example.reshape(1,28,28)).image  # the image itself
```
