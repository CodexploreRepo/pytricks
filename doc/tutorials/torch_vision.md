# Torch Vision

## Transform
- `transforms.ToTensor()` to convert image into `[0..1]` range
- `transforms.Normalize((0.5), (0.5))` to convert image into `[-1..1]` range since they are already in `[0..1]` range from `ToTensor()` step

```Python
from torchvision import transforms
transforms.ToPILImage(), # Convert a tensor or an ndarray to PIL Image.

transforms.ToTensor(),   # Convert to a torch.FloatTensor of shape (C x H x W) in the range [0.0, 1.0] if the PIL Image

transforms.Normalize(
    (0.5),
    (0.5),
),
```
