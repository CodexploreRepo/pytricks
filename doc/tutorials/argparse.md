# Argparse
- Parser for command-line options, arguments and sub-commands

```Python
import math
import argparse

# container to hold arguments
parser = argparse.ArgumentParser(description='Calculate volume of a Cylinder')
# positional arguments:
parser.add_argument('radius', type=float,
                    help='Radius of Cylinder')
parser.add_argument('-H', '--height', type=int,  # keyword arguments
                    required=True, default=10,  # only avail in keyword argument
                    help='Height of Cylinder')

# 00_argparse.py 2 -H 4
args = parser.parse_args()  # to get all the parsed arguments, type: argparse.Namespace


def cylinder_volume(radius, height):
    vol = (math.pi)*(radius**2)*(height)
    return vol


if __name__ == "__main__":
    print(args)  # Namespace(radius=2, height=4)
    print(cylinder_volume(args.radius, args.height))

    args = vars(args)  # {'radius': 2, 'height': 4}
    print(cylinder_volume(args.get('radius', 2), args["height"]))

```
- Create `args` using `argparse.NameSpace`

```Python
from argparse import Namespace  # you'll need this

args = Namespace()  # edit this
args.fc1 = 512
args.fc_dropout = 0.3
```
