# Typing
- Basic Typing:

```Python
from typing import List, Tuple
from typing import Union, Optional, Literal

import numpy as np
import pathlib

def to_json(self, savepath: Union[str, pathlib.Path]) -> None:
  pass
  
@dataclass
class ExampleDataClass:
    expand_ratio: float = 0
    scanned_page_idxs: List[int] = [] #List of integer, by default is empty list
    img: Optional[np.ndarray] = None #Optional arg -> Same as Union[int, None]
    savepath: Union[str, pathlib.Path]
    
    # 2 String Option
    camelot_flavor: Literal["lattice", "stream"] = "stream"
     
```
