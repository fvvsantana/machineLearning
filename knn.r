"
This code tests the knn algoritm for classification over the dataset iris.
"

# Import package that contains knn
library(class)

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

# Calculate accuracy from two arrays
accuracy <- function(predCl, trueCl){
    return(
        (
            sum(predCl == trueCl, na.rm = TRUE) + sum(is.na(predCl) & is.na(trueCl))
        ) / length(predCl)
    )
}

# Plot dataset
plotDataset <- function(dataset){
    plot(dataset[,1:ncol(dataset)-1], col = dataset[, ncol(dataset)])
}

main <- function(){
    # Load data
    dataset = iris
    # Normalize and partition dataset
    dataset = prepareDataset(dataset)

    # Prepare sets to pass to classifier
    trainingSet = dataset$training[, 1:(ncol(dataset$training)-1)]
    testSet = dataset$test[, 1:(ncol(dataset$test)-1)]
    trainingTrueClass= dataset$training[,ncol(dataset$training)]
    testTrueClass = dataset$test[,ncol(dataset$test)]

    # Classify
    result = knn(trainingSet, testSet, cl = trainingTrueClass, k = 1)

    # Confusion matrix
    confusionMatrix = table(result, testTrueClass)
    print(confusionMatrix)
    # Accuracy
    accuracyRate = accuracy(result, testTrueClass)
    print(accuracyRate)
    # Plot dataset
    plotDataset(dataset$training)

}

main()
