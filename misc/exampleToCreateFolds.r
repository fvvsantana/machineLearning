# Tutorials:
# https://stackoverflow.com/questions/22909197/creating-folds-for-k-fold-cv-in-r-using-caret
# http://www.sthda.com/english/articles/38-regression-model-validation/157-cross-validation-essentials-in-r/
# https://www.analyticsvidhya.com/blog/2018/05/improve-model-performance-cross-validation-in-python-r/
#

'
For this code I needed to install caret by doing:

    # Didn\'t work
    install.packages("caret", dependencies = c("Depends", "Suggests"))

    # I hope this works
    install.packages("caret")
    install.packages("ggplot2")
    library(caret)
    # First install.packages("caret"), and install.packages("ggplot2"), then library(caret)

'

# Import package that contains knn
library(class)
library(caret)

main <- function(){
    # Load data
    dataset = iris
    # Create fold indices from the last column of the dataset
    foldIndices = createFolds(dataset[, ncol(dataset)])
    str(foldIndices)
    # Get the instances corresponding to these indices
    folds = lapply(foldIndices, function(ind, dat) dat[ind,], dat = dataset)
    str(folds)
    print(unlist(lapply(folds, nrow)))



}

main()
