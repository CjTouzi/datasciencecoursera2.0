# loading data
library(caret)
build <- read.csv("./pml-training.csv")
test <- read.csv("./pml-testing.csv")


dim(build)
dim(test)


## preprocessing

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

save(test, file="./test.RData")
rm(test)

# create validation data set using Train 
inTrain <- createDataPartition(y=build$classe, p=0.7, list=FALSE)
train <- build[inTrain,]
val <- build[-inTrain,]
rm(inTrain,nas,build)



##  classification problem

# reproducible
set.seed(123)

# random forest model
Mod1 <- train(classe ~ ., method = "rf", 
               data = train, importance = T, 
               trControl = trainControl(method = "cv", number = 2))

Mod1$finalModel

# out-of-sample errors
pred1 <- predict(Mod1, val)
confusionMatrix(pred1, val$classe)



# boost fitting model
Mod2 <- train(classe ~ ., 
                  method = "gbm", 
                  data = train, 
                  verbose = F, 
                  trControl = trainControl(method = "cv", number = 2))

Mod2$finalModel

# out-of-sample errors
pred2 <- predict(Mod2, val)
confusionMatrix(pred2, val$classe)



# Fit a model that combines predictors

predDF <- data.frame(pred1, pred2, classe =val$classe)
combModFit <- train(classe ~.,method="gam",data=predDF)


# predicting on validation data set
combPred <- predict(combModFit, predDF)
levels(combPred)
confusionMatrix(combPred, predDF$classe)




load("./test.RData")
rfPred <- predict(rfMode,test)
length(rfPred)
rest$c
confusionMatrix(rfPred, test$classe)



