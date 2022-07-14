# Inital Setup
- Set color map: `plt.set_cmap('gray')`
- Marker: `plt.plot(x, y_true, marker='x')` with marker options `x`, `.`
- Color: `plt.scatter(x, y_pred, color='r')`
- Line Legend: 
```Python
plt.plot(x, y_true, label='function_A')
plt.legend() #to show the legend
```




# Add Patches on Figure/Image
```Python
from matplotlib.patches import Rectangle

fig, ax = plt.subplots(figsize=figsize)

rect = Rectangle((x0, y0), w, h, fill=False, lw=1, color="blue")
ax.add_patch(rect)

```
