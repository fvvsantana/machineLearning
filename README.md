# Learning Machine Learning

## Description

This project was made for learning to use different machine learning techniques in R. There is no real implementation of the algorithms in this repository, we just use it.

The main concepts/algorithms presented in this repository are:
* K-means clustering
* K-nearest neighbors algorithm
* Naive Bayes classifier
* K-Fold Cross-Validation

On top of each file, there is a description of what the file is about.

## Usage

These scripts were executed using R version 3.6.2. Also, it's needed to have Caret installed, in our case the version is 3.6.2.

To execute each file on Linux, enter the interactive mode of R:
```
    R
```
Then load the source file you want to, for example:
```
    source('knn.r')
```
Loads the script [knn.r](knn.r) and shows up a beautiful chart of the dataset iris, where we can easily identify the clusters of classes by color.
To run every other R script, change 'knn.r' by the relative path of the script.

## Tech stack
* R (Caret)
