# Typing
- [Basic Typing](#basic-typing)
- [`Union`, `Optional`, `Literal`](#union-optional-literal)
- [`NameTuple` Multiple Returns](#nametuple)
- [`isinstance` Type Check](#isinstance)


## Basic Typing
```Python
from typing import List, Tuple
from typing import Union, Optional, Literal

import numpy as np
import pathlib
```

## Union, Optional, Literal
```Python
@dataclass
class ExampleDataClass:
    expand_ratio: float = 0
    scanned_page_idxs: List[int] = [] #List of integer, by default is empty list
    
    # "Optional" example
    img: Optional[np.ndarray] = None #Optional arg -> Same as Union[int, None]
    
    # "Union" example 
    savepath: Union[str, pathlib.Path]
    
    # "Literal" example
    camelot_flavor: Literal["lattice", "stream"] = "stream"
```


## `isinstance`
- Checking the type
```Python
if not isinstance(savepath, pathlib.Path):
    savepath = pathlib.Path(savepath)
```

## `NameTuple`
- Return multiple file -> Need `NameTuple`
```Python
from typing import NamedTuple
def two_outputs(
    text: str,
) -> NamedTuple(
    "Outputs",
    [
        ("output_one", str),  # Return parameters
        ("output_two", str),
    ],
):
    pass
    return (o1, o2)
```
