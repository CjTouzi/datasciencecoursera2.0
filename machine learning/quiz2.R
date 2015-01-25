
# Q1 ----------------------------------------------------------------------


library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)

str(diagnosis)
str(predictors)

adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]



# Q2 ----------------------------------------------------------------------

library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
str(concrete)

library(Hmisc)



cuts <- levels(cut(training$FlyAsh, breaks=4))
rbPal <- colorRampPalette(c('red','blue'))
b <- rbPal(4)[as.numeric(cut(training$FlyAsh,breaks = 4))]
plot(training$CompressiveStrength, col=b, pch=16, main="FlyAsh")
legend("topleft",cuts,col=rbPal(4),pch=16)
plot(x= training$CompressiveStrength, y=training$FlyAsh, col=b, pch=16, main="FlyAsh VS CS")



?concrete
summary(training$Age)
cuts <- levels(cut(training$Age, breaks=4))
b <- rbPal(4)[as.numeric(cut(training$Age,breaks = 4))]
plot(training$CompressiveStrength, col=b, pch=16, main="Age")
legend("topleft",cuts,col=rbPal(4),pch=16)


featurePlot(x=training[,], y=training$CompressiveStrength,plot="pairs")



# Q3 ----------------------------------------------------------------------

library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
par(mfrow=c(1,2))
hist(training$Superplasticizer, xlim=c(0,0.02))
hist(log10(training$Superplasticizer+1), xlim=c(0,0.02))




# Q4 ----------------------------------------------------------------------

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

str(adData)
ss <- training[,grep('^IL', x = names(training) )]
preProc <- preProcess(ss, method='pca', thresh = 0.9, outcome = training$diagnosis)
preProc$numComp



# Q5 ----------------------------------------------------------------------

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]



subTraining  <- training[,grep('^IL', x = names(training))]
# subTraining$diagnosis  <- training$diagnosis
subTesting <- testing[,grep('^IL', x = names(testing) )]
# subTesting$diagnosis  <- testing$diagnosis


dim(subTesting)
dim(subTraining)

model1 <- train(training$diagnosis~.,  method='glm', data=subTraining)
summary(model1)

confusionMatrix(testing$diagnosis, predict(model1, subTesting))

#0.6463 

?preProcess
preProce <- preProcess(subTraining, method='pca', thresh=0.8)
preProce$numComp
trainingPC <- predict(preProce, subTraining)

model2 <- train(training$diagnosis~.,  method='glm', data=trainingPC)


confusionMatrix(testing$diagnosis, predict(model2, predict(preProce, subTesting)))
# 0.7195 
