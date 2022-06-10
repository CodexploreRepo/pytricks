# Image Operations 
# Pillow `PIL` Library
- Install pillow: `pip install Pillow`
- Open an image using `PIL.Image.open()`:
  - `.open()` function to read the image from the file  
  - `.load()` to read the image into memory so that the file can now be closed. 
  - You use a with statement to create a context manager to ensure the file is closed as soon as it’s no longer needed.

In this example, the object is a JPEG image-specific type that’s a subclass of the Image class, as you confirm with the call to isinstance(). Note that both the class and the module where the class is defined share the same name, Image. You can :
```Python
from PIL import Image
file_path = "./img/buildings.jpg"
with Image.open(file_path) as img:
  img.load()
  
>>> type(img) #<class 'PIL.JpegImagePlugin.JpegImageFile'>
>>> isinstance(img, Image.Image) #True

print(img.size, img.mode, img.format) #(1920, 1273), 'RGB' 'JPEG'
img.show()  #display the image using .show()
```
