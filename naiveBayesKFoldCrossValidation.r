"
Tutorials about cross validation:
https://stackoverflow.com/questions/22909197/creating-folds-for-k-fold-cv-in-r-using-caret
http://www.sthda.com/english/articles/38-regression-model-validation/157-cross-validation-essentials-in-r/
https://www.analyticsvidhya.com/blog/2018/05/improve-model-performance-cross-validation-in-python-r/

Caret's available models:
https://topepo.github.io/caret/available-models.html

"

'
For this code I needed to install caret by doing:

    # Didn\'t work to me:
    install.packages("caret", dependencies = c("Depends", "Suggests"))

    # This worked to me (copy and paste on R console):
    install.packages("caret")
    install.packages("ggplot2")
    library(caret)

'

# Import package that contains knn
library(class)
library(caret)
#library('caret')

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
predAccuracy <- function(predCl, trueCl){
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
    # Set a seed to make this experiment replicable
    set.seed(123)

    # Separe train and test sets
    trainIndex = createDataPartition(iris$Species, p = .8,
                                  list = FALSE,
                                  times = 1)
    irisTrain = iris[trainIndex,]
    irisTest = iris[-trainIndex,]


    # Define training control
    train.control = trainControl(method = "cv", number = 10)
    # Train the model
    model = train(Species ~., data = irisTrain, method = 'nb',
               trControl = train.control, preProcess = c('center','scale'))

    # Print cross validation result
    print('Cross validation result:')
    print(model)

    # Print test result
    prediction = predict(model, newdata = irisTest)
    results = confusionMatrix(prediction, irisTest$Species)
    print('Testing results:')
    print(results)


    cat('\n\n--------------------------------------------------------\n\n')
    cat('\nOverall:\nCross validation accuracy:', model$results$Accuracy[1], '\n')
    cat('Testing accuracy:', results$overall[1], '\n')

}

main()
