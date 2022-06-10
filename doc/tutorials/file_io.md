# File I/O
In Python, a file operation takes place in the following order:
- Open a file
- Read or write (perform operations)
- Close the file (**needs to be closed so that the resources that are tied with the file are freed**)

## Open File
- `open()` Python has a built-in function to open a file. 
  - This function returns a *file object*, also called a **handle**, as it is used to read or modify the file accordingly.
  - *Mode*: read `r`, write `w` or append `a` to the file, `x` open for **exclusive creation**, failing if the file already exists to prevent write/append to a file that already exists.
  - *Binary*: open the file in text mode or binary mode
    - **Text Mode** `t`: returns strings when reading from the file.
    - **Binary Mode** `b`: returns bytes and this is the mode to be used when dealing with non-text files like images or executable files. 
  - *Encoding*: the default encoding is platform dependent. In windows, it is `cp1252` but `utf-8` in Linux. 
    - Hence, when working with files in text mode, it is highly recommended to specify the encoding type.

```Python
f = open("test.txt")                              # equivalent to 'r' or 'rt'
f = open("test.txt", mode='r', encoding='utf-8')  # write in text mode with 'utf-8' encoding
f = open("img.bmp",'rb')                          # read and write in binary mode
```

## Close File
- Closing a file to free up the resources that were tied with the file. 
  - Extra Info: Python has a garbage collector to clean up unreferenced objects but we must not rely on it to close the file, but have to actively close it.
- `with` statement: the best way to close a file is by using the 
  - This ensures that the file is closed when the block inside the with statement is exited.
  - We don't need to explicitly call the close() method. It is done internally.

```Python
with open("test.txt", 'r', encoding = 'utf-8') as f:
   # perform file operations
```

## Write File
- `write()` writing a string or sequence of bytes (for binary files).
  - Note: need to append `\n` at the end of the line 
```Python
with open("test.txt",'w',encoding = 'utf-8') as f:
   f.write("This is my first file\n")
   f.write("This file\n\n")
   f.write("contains three lines\n")
```

## Read File
```Python
f.readlines()
#['This is my first file\n', 'This file\n', 'contains three lines\n']
```
