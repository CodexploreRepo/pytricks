# PDF
- [PDF Miner](#pdf-miner)

# PDF Miner
- PDF Miner Six
- Resources: [Tutorial](https://pdfminer-docs.readthedocs.io/programming.html#basic-usage)
- To parse PDF files, you need to use at least two classes: 
  - `PDFParser`: fetches data from a file
  - `PDFDocument`: stores it
- Also need
  - `PDFPageInterpreter`: process the page contents 
  - `PDFDevice`: translate it to whatever you need. 
  - `PDFResourceManager`: used to store shared resources such as fonts or images.

<p align="center"><img width="300px" src="https://user-images.githubusercontent.com/64508435/176409276-83890d72-e332-427c-9616-c5b3f62aa02d.png"/>
<br>Figure 1 shows the relationship between the classes in PDFMiner</p>



