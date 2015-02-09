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


set.seed(123)

# random forest model
Mod1 <- train(classe ~ ., method = "rf", 
               data = train, importance = T, 
               trControl = trainControl(method = "cv", number = 3))

Mod1$finalModel

save(Mod1, file = "Mod1.rda")

# out-of-sample errors
pred1 <- predict(Mod1, val)
cm1 <- confusionMatrix(pred1, val$classe)

cm1


# boost fitting model
Mod2 <- train(classe ~ ., 
                  method = "gbm", 
                  data = train, 
                  verbose = F, 
                  trControl = trainControl(method = "cv", number = 3))

Mod1$results


save(Mod2, file = "Mod2.rda")

# out-of-sample errors
pred2 <- predict(Mod2, val)
cm2 <- confusionMatrix(pred2, val$classe)

par(mfrow=c(1,2))

plot(cm1$byClass, main="random forest", xlim=c(0.99, 1.001))
text(cm1$byClass[,1]+0.0005, cm1$byClass[,2], labels=LETTERS[1:5], cex= 0.7)
plot(cm2$byClass, main="boosting", xlim=c(0.95, 1.001))
text(cm2$byClass[,1]+0.0015, cm2$byClass[,2], labels=LETTERS[1:5], cex= 0.7)


# comapre with random forest and booting model

# random forest model has better out-of-sample accuracy

# predict the test sample using random forest 

load("./test.RData")
test$classe <- as.character(predict(Mod1, test))

test$classe


# write prediction files
pml_write_files = function(x){
        n = length(x)
        for(i in 1:n){
                filename = paste0("./predict/problem_id_", i, ".txt")
                write.table(x[i], file = filename, quote = FALSE, row.names = FALSE, col.names = FALSE)
        }
}
pml_write_files(test$classe)



# Fit a model that combines predictors

# predDF <- data.frame(pred1, pred2, classe =val$classe)
# combModFit <- train(classe ~.,method="gam",data=predDF)
# 
# plot(combPred)
# plot(pred2)
# plot(pred1)

# the prediction values by comb predictor concentrated in A & B ???  

# # predicting on validation data set
# combPred <- predict(combModFit, predDF)
# 
# 
# levels(combPred)
# confusionMatrix(combPred, predDF$classe)




load("./test.RData")
rfPred <- predict(rfMode,test)
length(rfPred)
rest$c
confusionMatrix(rfPred, test$classe)

save(Mod1,file="./Mod1.RData")
save(Mod2,file="./Mod2.RData")


