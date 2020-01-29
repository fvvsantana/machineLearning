"
This code apply k-means over a dataset called iris. Then it finds the accuracy
of the classifier by counting how many classifications were right.

Here is an explanation about why I chose to standardize the data in this
project:
https://datascience.stackexchange.com/questions/6715/is-it-necessary-to-standardize-your-data-before-clustering
This is basically because when we don't standardize data, we are giving more
weight to a feature than the other. Instead, when we standardize, we are saying
that all the measures have the same importance.
In this case, I'll work with the iris dataset. I think all the features have
more or less the same weight to the clustering. So I'm going to standardize it.
"

# Import package that contains knn
library(class)
library('gtools')

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
    return(normDataset[,1:ncol(normDataset)-1])
}

# Calculate accuracy from two arrays
predAccuracy <- function(predCl, trueCl){
    return(
        (
            sum(predCl == trueCl, na.rm = TRUE) + sum(is.na(predCl) & is.na(trueCl))
        ) / length(predCl)
    )
}

"
    Calculate accuracy of clusters classification following a convention.
    The convention will be given by assignment between the array of clustersNames
    and the array of classesNames, where a cluster name in the position i refers
    to a class name in the position i.
"
clusterAccuracy <- function(clusters, trueClassification, clustersNames, classesNames){
    total = 0
    for(i in 1:length(clusters)){
        if(which(clustersNames == clusters[i])[1] == which(classesNames == trueClassification[i])[1]){
            total = total + 1
        }
    }
    return( total / length(clusters) )
}

"
Return accuracy of k-means and correct assignment among clusters and classes.
"
kmeansAccuracy <- function(clusters, trueClassification){
    # Fixed array with classes
    classesNames = unique(trueClassification)

    # Permutable array with clusters
    clustersNames = unique(clusters)
    nClusters = length(clustersNames)

    # Generate assignments among classes and clusters
    assignments = permutations(n = nClusters, r = nClusters, v = clustersNames)

    "
    For each of the assignments calculate accuracy, in the end get the position
    of the assignment of largest accuracy.
    "
    accuracies = vector('list', nrow(assignments))
    for(i in 1:nrow(assignments)){
        accuracies[i] = clusterAccuracy(clusters, trueClassification,
                                        assignments[i,], classesNames)
    }
    posOfBestAssignment = which.max(accuracies)

    # Return best accuracy and assignment
    ret = list()
    ret$accuracy = accuracies[posOfBestAssignment]
    ret$assignment = data.frame(class = classesNames, cluster = assignments[posOfBestAssignment,])
    return(ret)
}

# Plot dataset
plotDataset <- function(dataset){
    plot(dataset[,1:ncol(dataset)-1], col = dataset[, ncol(dataset)])
}

main <- function(){
    # Load data
    dataset = iris
    prepDataset = prepareDataset(dataset)

    # Classify
    result = kmeans(prepDataset, 3, iter.max = 10)

    # Find accuracy of k-means and best assignment among clusters and classes
    acc = kmeansAccuracy(result$cluster, dataset[, ncol(dataset)])

    # Metrics for comparison
    print(paste('Accuracy:', acc$accuracy))
    print(paste('BestAssignment:'))
    print(acc$assignment)
    #print(paste('BSS:', result$betweenss))
    #print(paste('RSS:', result$totss))
    print(paste('BSS/RSS:', result$betweenss/result$totss))
    #stopifnot(FALSE)
}

main()
