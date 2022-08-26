# Torch Models
## Tips
Here's some tricks you can try that are especially helpful with deeper networks:
- Add [`BatchNorm`](https://pytorch.org/docs/stable/generated/torch.nn.BatchNorm1d.html)
layers, which can improve
[training stability and loss conditioning](https://myrtle.ai/how-to-train-your-resnet-7-batch-norm/)
- Add a linear "skip connection" layer that is applied to the inputs and whose outputs are added directly to the last layer's outputs

## `torch.nn`
- **Batch Norm**: `nn.BatchNorm1d()`,  `nn.BatchNorm2d()` &#8594; same shape as input
  - There is no mathematical difference between them, except the dimension of input data. 
  - nn.BatchNorm2d only accepts 4D inputs 
  - nn.BatchNorm1d accepts 2D or 3D inputs. And because of that, in features which has been constructed of nn.Conv2d layers, inputs are `[batch, ch, h, w]` (4D) we need **BatchNorm2d** and in classifier we have Linear layers which accept `[batch, length]` or `[batch, channel, length]` (2D/3D) so we need **BatchNorm1d**.
- **Flatten**: `nn.Flatten()`

## Torch Function
- `import torch.nn.functional as F` for stateless computation
  - includes: `F.cross_entropy`, `F.log_softmax` 
- `device = torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")` check GPU/CPU
- `torch.flatten(x, start_dim, end_dim)` flattens input by reshaping it into a one-dimensional tensor
  - If start_dim or end_dim are passed, only dimensions starting with start_dim and ending with end_dim are flattened. 

## Standard Procedure to build Pytorch model
### Data Module
- A proper `DataModule` collects up all of the code required to prepare data on a machine, sets it up as a collection of `Dataset`s, and turns those `Dataset`s into `DataLoader`s, as below:

```Python
class MNISTDataModule:
    url = "https://github.com/pytorch/tutorials/raw/master/_static/"
    filename = "mnist.pkl.gz"
    
    def __init__(self, dir, bs=32):
        self.dir = dir
        self.bs = bs
        self.path = self.dir / self.filename

    def prepare_data(self):
        if not (self.path).exists():
            content = requests.get(self.url + self.filename).content
            self.path.open("wb").write(content)

    def setup(self):
        with gzip.open(self.path, "rb") as f:
            ((x_train, y_train), (x_valid, y_valid), _) = pickle.load(f, encoding="latin-1")

        x_train, y_train, x_valid, y_valid = map(
            torch.tensor, (x_train, y_train, x_valid, y_valid)
            )
        
        self.train_ds = BaseDataset(x_train, y_train, transform=push_to_device, target_transform=push_to_device)
        self.valid_ds = BaseDataset(x_valid, y_valid, transform=push_to_device, target_transform=push_to_device)

    def train_dataloader(self):
        return torch.utils.data.DataLoader(self.train_ds, batch_size=self.bs, shuffle=True)
    
    def val_dataloader(self):
        return torch.utils.data.DataLoader(self.valid_ds, batch_size=2 * self.bs, shuffle=False)


def push_to_device(tensor):
    return tensor.to(device)
```
### Fitting Pipeline

```Python
from torch import optim
def configure_optimizer(model: nn.Module) -> optim.Optimizer:
    return optim.Adam(model.parameters(), lr=3e-4)

def accuracy(out: torch.Tensor, yb: torch.Tensor) -> torch.Tensor:
    preds = torch.argmax(out, dim=1)
    return (preds == yb).float().mean()
    
def fit(self: nn.Module, datamodule):
    datamodule.prepare_data() #to download the data
    datamodule.setup()        #to convert train & val into Dataset class

    val_dataloader = datamodule.val_dataloader() #create val_dataloader
    
    self.eval()
    with torch.no_grad():
        valid_loss = sum(loss_func(self(xb), yb) for xb, yb in val_dataloader)

    print("before start of training:", valid_loss / len(val_dataloader))

    opt = configure_optimizer(self)
    train_dataloader = datamodule.train_dataloader() #create val_dataloader
    for epoch in range(epochs):
        self.train()
        for xb, yb in train_dataloader:
            pred = self(xb)
            loss = loss_func(pred, yb)

            loss.backward()
            opt.step()
            opt.zero_grad()

        self.eval()
        with torch.no_grad():
            valid_loss = sum(loss_func(self(xb), yb) for xb, yb in val_dataloader)
            acc = sum([accuracy(self(xb), yb) for xb, yb in val_dataloader]) / len(val_dataloader)

        print('Loss: ', epoch, valid_loss / len(val_dataloader))
        print('Acc: ', acc.cpu())
```

### Model
- Using `torch.nn.Module` to define functions whose state is given by `torch.nn.Parameter`
```Python
import argparse
from typing import Any, Dict

import numpy as np
import torch
import torch.nn as nn
import torch.nn.functional as F

FC1_DIM = 1024
FC2_DIM = 128
FC_DROPOUT = 0.5

class MLP(nn.Module):
    """Simple MLP suitable for recognizing single characters."""

    def __init__(
        self,
        data_config: Dict[str, Any],
        args: argparse.Namespace = None,
    ) -> None:
        super().__init__()
        self.args = vars(args) if args is not None else {}
        self.data_config = data_config

        input_dim = np.prod(self.data_config["input_dims"])
        num_classes = len(self.data_config["mapping"])

        fc1_dim = self.args.get("fc1", FC1_DIM)
        fc2_dim = self.args.get("fc2", FC2_DIM)
        dropout_p = self.args.get("fc_dropout", FC_DROPOUT)

        self.fc1 = nn.Linear(input_dim, fc1_dim)
        self.dropout = nn.Dropout(dropout_p)
        self.fc2 = nn.Linear(fc1_dim, fc2_dim)
        self.fc3 = nn.Linear(fc2_dim, num_classes)

    def forward(self, x):
        x = torch.flatten(x, 1)
        x = self.fc1(x)
        x = F.relu(x)
        x = self.dropout(x)
        x = self.fc2(x)
        x = F.relu(x)
        x = self.dropout(x)
        x = self.fc3(x)
        return x

    @staticmethod
    def add_to_argparse(parser):
        parser.add_argument("--fc1", type=int, default=FC1_DIM)
        parser.add_argument("--fc2", type=int, default=FC2_DIM)
        parser.add_argument("--fc_dropout", type=float, default=FC_DROPOUT)
        return parser
```
- If you want to make an `nn.Module` that can have different depths, check out the [`nn.Sequential`](https://pytorch.org/docs/stable/generated/torch.nn.Sequential.html) class.
```Python
class NewModel(nn.Module):
    def __init__(self):  # add args and kwargs here as you like
        super().__init__()
        
        self.layers = nn.Sequential(
            nn.Flatten(start_dim=1),
            nn.Linear(input_dim, fc1_dim),
            nn.BatchNorm1d(fc1_dim),
            nn.ReLU(),
            nn.Dropout(dropout_p),
            ...
        )
    def forward(self, xb):  
        return self.layers(xb)
```
### Putting Everything Together
```Python
# Assign fit function into the MLP model class
MLP.fit = fit 

# Define the model with args & data_config
from argparse import Namespace 
args = Namespace()  
args.fc1 = 512
args.fc_dropout = 0.3

digits_to_9 = list(range(10))
data_config = {"input_dims": (784,), "mapping": {digit: str(digit) for digit in digits_to_9}}

model = MLP(data_config, args=args)
model.to(device)

epochs = 4  # used in fit
bs = 16  # used by the DataModule

# create a datamodule object with batch size
datamodule = MNISTDataModule(dir=path, bs=bs)

model.fit(datamodule=datamodule)
```
