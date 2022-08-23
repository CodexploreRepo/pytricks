# Pathlib
```Python
import pathlib
file_path = pathlib.Path('/mnt/c/Upskills/repos/table_extraction/data/filename.pdf')
```
- `file_path.parent` get the parent folder of the file (`/mnt/c/Upskills/repos/table_extraction/data`)
- `file_path.stem`   get the file name without extension (`filename`)
- `file_path.exists()` to check if the path exists
- `file_path.mkdir(parents=True, exist_ok=True)` check if the folder exists & create if not.

### Open the file 
- To open the file path and write into that:
```Python
file_path = Path("/mnt/c/Upskills/repos/mnist.pkl.gz")
content = requests.get(url + filename).content
file_path.open("wb").write(content)
```
