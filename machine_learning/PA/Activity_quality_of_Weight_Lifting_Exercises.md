# Activity quality of Weight Lifting Exercises
Cheng  
Monday, February 09, 2015  

### Summary

===========================

In this article, we report a method to predict common incorrect gestures during barbell lifts using random forest methods with a overall accuracy 0.9946 in the validation set and 100 % accuracy in the testing set.


### Background

===========================

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. In this project, we use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. Six young health participants were asked to perform one set of 10 repetitions of the Unilateral Dumbbell Biceps Curl in five different fashions: exactly according to the specification (Class A), throwing the elbows to the front (Class B), lifting the dumbbell only halfway (Class C), lowering the dumbbell only halfway (Class D) and throwing the hips to the front (Class E).More information is available from the website [here](http://groupware.les.inf.puc-rio.br/har) (see the section on the Weight Lifting Exercise Dataset). 

Read [more](http://groupware.les.inf.puc-rio.br/har#ixzz3RDCCaU6P)




### Feature Extraction & Selection

===========================

In this setion, we will load both the training and testing dataset downloaded [here](http://groupware.les.inf.puc-rio.br/static/WLE/WearableComputing_weight_lifting_exercises_biceps_curl_variations.csv). The `53` activity quality related features are extracted both in training (named as `build`) and testing dataset (named as `test`). Then we divide `build` dataset into training (named as `train`) and validation (named as `val`) dataset. Finally we have three dataset: The `train` for model building, `val` data for out-of-sample error measurement and `test` for final model test.  


```r
# loading data
library(caret)
```

```
## Loading required package: lattice
## Loading required package: ggplot2
```

```r
build <- read.csv("./pml-training.csv")
test <- read.csv("./pml-testing.csv")

dim(build)
dim(test)

# preprocessing
build[,7:159] <- sapply(build[,7:159],as.numeric) 
test[,7:159] <- sapply(test[,7:159], as.numeric) 


## feature extraction & selection

# activity features
build <- build[8:160]
test <- test[8:160]

# remove features that contains NAs in test set
nas <- is.na(apply(test,2,sum))

test <- test[,!nas]
build <- build[,!nas]

# create validation data set using Train 
inTrain <- createDataPartition(y=build$classe, p=0.7, list=FALSE)
train <- build[inTrain,]
val <- build[-inTrain,]
rm(inTrain,nas,build)
```

As a result, the dimension of `train` is 13737, 53 in the order of number of observations and features. Similarly, the dimension of `val` and `test` are  5885, 53 and 20, 53


### Classification Model

===========================

In this setion, we build both random forest and boosting model for activity classfication. We compare the overall accuracy of two models and random forest mdoel shows better performance. 

Here shows a table of performance


|Method | Accuracy| Kappa | AccuracySD|KappaSD|
|------|---------|-------|-----------|-----------|
|Random Forest|0.9806360|0.9754981|0.002020839|0.002560955|
|Boosting|0.9593798|0.9486100|0.004351168|0.005487971|





```r
set.seed(123)

# random forest model
Mod1 <- train(classe ~ ., method = "rf", 
               data = train, importance = T, 
               trControl = trainControl(method = "cv", number = 3))
```

```
## Loading required package: randomForest
## randomForest 4.6-10
## Type rfNews() to see new features/changes/bug fixes.
```

```r
# Mod1$finalModel

# out-of-sample errors of random forest model using validation dataset 
pred1 <- predict(Mod1, val)
cm1 <- confusionMatrix(pred1, val$classe)


# boost fitting model
Mod2 <- train(classe ~ ., 
                  method = "gbm", 
                  data = train, 
                  verbose = F, 
                  trControl = trainControl(method = "cv", number = 3))
```

```
## Loading required package: gbm
## Loading required package: survival
## Loading required package: splines
## 
## Attaching package: 'survival'
## 
## The following object is masked from 'package:caret':
## 
##     cluster
## 
## Loading required package: parallel
## Loaded gbm 2.1
## Loading required package: plyr
```

```r
# out-of-sample errors using validation dataset 
pred2 <- predict(Mod2, val)
cm2 <- confusionMatrix(pred2, val$classe)
```

We plot out both specificity versus sensitivity for both random forest and boosting model.The figure shows random forest is better in both aspects. Therefore, in the final test, we will only use random forest.



```r
# compare the sensitivity and specificity btw random forest and boosting method

par(mfrow=c(1,2))
plot(cm1$byClass, main="random forest", xlim=c(0.97, 1.005))
text(cm1$byClass[,1]+0.003, cm1$byClass[,2], labels=LETTERS[1:5], cex= 0.7)
plot(cm2$byClass, main="boosting", xlim=c(0.93, 1.001))
text(cm2$byClass[,1]+0.005, cm2$byClass[,2], labels=LETTERS[1:5], cex= 0.7)
```

![](Activity_quality_of_Weight_Lifting_Exercises_files/figure-html/unnamed-chunk-3-1.png) 

### Prediction and Output

===========================

In this setion, we use random forest model we built in last setion to predict the test data and output the result into text files.   


```r
test$classe <- as.character(predict(Mod1, test))

# write prediction files
pml_write_files = function(x){
        n = length(x)
        for(i in 1:n){
                filename = paste0("./predict/problem_id_", i, ".txt")
                write.table(x[i], file = filename, quote = FALSE, row.names = FALSE, col.names = FALSE)
        }
}
# pml_write_files(test$classe)
Mod1$finalModel
# summary(test$classe)
```

```
## 
## Call:
##  randomForest(x = x, y = y, mtry = param$mtry, importance = ..1) 
##                Type of random forest: classification
##                      Number of trees: 500
## No. of variables tried at each split: 2
## 
##         OOB estimate of  error rate: 0.64%
## Confusion matrix:
##      A    B    C    D    E  class.error
## A 3903    2    1    0    0 0.0007680492
## B   17 2633    8    0    0 0.0094055681
## C    0   18 2376    2    0 0.0083472454
## D    0    0   33 2218    1 0.0150976909
## E    0    0    2    4 2519 0.0023762376
```



