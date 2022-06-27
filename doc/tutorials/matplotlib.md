# Add Patches on Figure/Image
```Python
from matplotlib.patches import Rectangle

fig, ax = plt.subplots(figsize=figsize)

rect = Rectangle((x0, y0), w, h, fill=False, lw=1, color="blue")
ax.add_patch(rect)

```
