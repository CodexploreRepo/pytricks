# Inital Setup
- **Set color map**: `plt.set_cmap('gray')`
- **Marker**: `plt.plot(x, y_true, marker='x')` with marker options `x`, `.`
- **Color**: `plt.scatter(x, y_pred, color='r')`
- **Line Legend**: 
  ```Python
  plt.plot(x, y_true, label='function_a')
  plt.legend() #to show the legend
  ```
  - plot the legend outside of the figure
  ```Python
  plt.legend(bbox_to_anchor=(1.04, 1), loc="upper left") 
  ```
  <p align="center"><img width="400" src="https://user-images.githubusercontent.com/64508435/178966085-79f69c75-ac86-443b-b080-36aa6515585f.png"/></p>





# Add Patches on Figure/Image
```Python
from matplotlib.patches import Rectangle

fig, ax = plt.subplots(figsize=figsize)

rect = Rectangle((x0, y0), w, h, fill=False, lw=1, color="blue")
ax.add_patch(rect)

```
