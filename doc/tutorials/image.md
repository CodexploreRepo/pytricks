# Image Operations 

## 1. Pillow `PIL` Library
- Install pillow: `pip install Pillow`
- **Open Image** using `PIL.Image.open()`:
  - `.open()` function to read the image from the file  
  - `.load()` to read the image into memory so that the file can now be closed. 
  - You use a with statement to create a context manager to ensure the file is closed as soon as it’s no longer needed.
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
