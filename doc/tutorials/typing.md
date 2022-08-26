# Typing
- [Basic Typing](#basic-typing)
- [`Union`, `Optional`, `Literal`](#union-optional-literal)
- [ `TypedDict` Type Hints for Dictionaries ](#typeddict)
- [`NameTuple` Multiple Returns](#nametuple)
- [`Callable`](#callable)
- [`isinstance` Type Check](#isinstance)


## Basic Typing
```Python
from typing import List, Tuple, Dict, Any
from typing import Union, Optional, Literal

import numpy as np
import pathlib

def __init__(
        self,
        data_config: Dict[str, Any], #Dict Type
        args: argparse.Namespace = None,
        path: Union[pathlib, str]
    )
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

## `TypedDict`
- How to define `TypedDict` class

```Python
from typing import TypedDict

class Movie(TypedDict):
    name: str
    year: int
```
- Here is an example of how the type Movie can be used:
```Python
movie: Movie = {'name': 'Blade Runner',
                'year': 1982}

def record_movie(movie: Movie) -> None: 
    #do something here
    pass

record_movie({'name': 'Blade Runner', 'year': 1982})

# an assignment to a variable with a previously declared TypedDict type
movie: Movie
#...
movie = {'name': 'Blade Runner', 'year': 1982}


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
## `Callable`
```Python
from typing import Callable
```
## `isinstance`
- Checking the type
```Python
if not isinstance(savepath, pathlib.Path):
    savepath = pathlib.Path(savepath)
```


