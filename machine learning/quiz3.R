
# Q1 ----------------------------------------------------------------------

library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
?createDataPartition
InTrain <- createDataPartition(segmentationOriginal$Class, p=0.6, list=FALSE)
training <- segmentationOriginal[InTrain, ]
testing <- segmentationOriginal[-InTrain, ]

?segmentationOriginal
head(segmentationOriginal$Class)
set.seed(125)

modelFit <- train(Class ~. , method="rpart", data=training)
modelFit$finalModel


library(rattle)
fancyRpartPlot(modelFit$finalModel)

# newdata <- data.frame(TotalIntench2=c(23000, 50000, 57000, NA), 
#                       FiberWidthCh1= c(10, 10, 8,8),
#                       PerimStatusCh1=c(2,NA,NA,NA),
#                       VarIntenCh4= c(NA, 100,100,NA),
#                       PerimStatusCh1=c(NA,NA,NA,2)
#                       )




# Q3 ----------------------------------------------------------------------

library(pgmm)
data(olive)
olive = olive[,-1]
names(olive)
library(caret)
library(rpart)
modelFit <- rpart(Area ~. , data=olive)

library(rattle)
fancyRpartPlot(modelFit$finalModel)

levels(olive$Area)
newdata = as.data.frame(t(colMeans(olive)))
predict(modelFit, newdata)


# Q4 ----------------------------------------------------------------------
#  fit a logistic regression model (method="glm", 
#  be sure to specify family="binomial")


library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)
?SAheart

modelFit <- train(chd~ age +alcohol +obesity +tobacco + typea +ldl,
                  data= trainSA, 
                  method="glm", family="binomial")

trainPre <- predict(modelFit, trainSA)
testPre <- predict(modelFit, testSA)


# Calculate the misclassification rate

missClass = function(values,prediction)
{
        sum(((prediction > 0.5)*1) != values)/length(values)

}

missClass(trainSA$chd, trainPre)
missClass(testSA$chd, testPre)

# Test Set Misclassification: 0.31 
# Training Set: 0.27



# Q5 ----------------------------------------------------------------------

library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

vowel.train$y <- factor(vowel.train$y)
str(vowel.train)

vowel.test$y <- factor(vowel.test$y)
str(vowel.train)

set.seed(33833)

modFit <- train(y~ .,data=vowel.train,method="rf")
?varImp
varImp(modFit)
