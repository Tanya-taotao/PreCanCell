# PreCanCell
A Simple and Effective Ensemble Learning Algorithm for Predicting Cancer and Non-Cancer Cells from Single-cell Transcriptomes.

# Description
PreCanCell first identified the differentially expressed genes (DEGs) between malignant and non-malignant cells commonly in five common cancer-associated single-cell transcriptome datasets. With each of the five datasets as the training set and the DEGs as the features, a single cell was classified as malignant or non-malignant by k-NN. Finally, the single cell was classified by the majority vote of the five k-NN classification results.

# Details
+ The input of the function `PreCanCell_data()` should be normalized expression dataframe with rows being genes, and columns being cells.
+ The function `PreCanCell_classifier()` is used to identify malignant and non-malignant cells from single-cell transcriptomes, containing 2 parameters: testdata and cores.
  + "testdata" is a output matrix of the function `PreCanCell_data()`.
  + "cores" is the number of threads.

# Installation
You can install the released version of PreCanCell with:
```
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")
devtools::install_github("WangX-Lab/PreCanCell")
```

# Examples
```
## Data preprocessing (select matched genes and 0-1 scale gene expression values) --------------
library(PreCanCell)
path <- system.file("extdata", "example.txt", package = "PreCanCell", mustWork = TRUE)
input <- read.table(path, stringsAsFactors = FALSE, header = TRUE, check.names = FALSE, sep = "\t", quote = "", row.names = 1)
testdata <- PreCanCell_data(input)
```

```
## Prediction of malignant and non-malignant cells ---------------------------------------------------------------------------
library(PreCanCell)
results <- PreCanCell_classifier(testdata, 2)
```

# Contact
E-mail any questions to Tao Yang yangtao@stu.cpu.edu.cn and Xiaosheng Wang xiaosheng.wang@cpu.edu.cn
