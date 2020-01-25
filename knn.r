# Tutorial:
# https://towardsdatascience.com/k-nearest-neighbors-algorithm-with-examples-in-r-simply-explained-knn-1f2c88da405c

# Normalize the feature columns of a dataset
normalizeDataset <- function(dataset){
    # Normalize features
    features = dataset[, 1:ncol(dataset)-1]
    normFeatures = as.data.frame(lapply(features, scale))

    # Append classifications to features
    df = cbind(normFeatures, dataset[, length(dataset)])
    names(df)[length(df)] = names(dataset)[length(dataset)]

    return(df)
}

# Normalize and partition dataset
prepareDataset <- function(dataset){
    # Normalize dataset
    normDataset = normalizeDataset(dataset)

    # Create training and test partitions
    trainingIndices = sample(1:nrow(normDataset), 0.9 * nrow(normDataset))
    ret = list()
    ret$training = normDataset[trainingIndices,]
    ret$test = normDataset[-trainingIndices,]
    return(ret)
}

main <- function(){
    # Load data
    dataset = head(iris)
    # Normalize and partition dataset
    dataset = prepareDataset(dataset)
    print(dataset)
}

main()
