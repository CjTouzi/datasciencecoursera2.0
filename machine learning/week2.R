


library(caret);library(kernlab); data(spam)


# slice data into training set and testing set
inTrain <- createDataPartition(y=spam$type, p= 0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
dim(spam)

# training data
set.seed(32343)
modelFit <- train(type ~., data=training, method="glm")
modelFit
modelFit$finalModel


# predicte the out-of-sample error
prediction <- predict(modelFit, newdata=testing)
prediction

# cal the out-of-sample error
confusionMatrix(prediction, testing$type)



# data slicing ------------------------------------------------------------

library(caret);library(kernlab); data(spam)

# slice data into training set and testing set
inTrain <- createDataPartition(y=spam$type, p= 0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
dim(spam)


# kfold 
set.seed(32343)
folds <- createFolds(y=spam$type, k=10, list=TRUE, returnTrain=TRUE)
sapply(folds, length)
folds[[1]][1:10]
folds[[10]][1:10]

folds1 <- createFolds(y=spam$type, k=10, list=TRUE, returnTrain=FALSE)
sapply(folds1, length)
folds1[[1]][1:10]
folds1[[10]][1:10]

# resempling
set.seed(32343)
folds3 <- createResample(y=spam$type,times=10, list=TRUE)
sapply(folds3,length)
folds3[[1]][1:10]

# Time slices
set.seed(32343)
folds3 <- createTimeSlices(y=tme,times=10, list=TRUE)


