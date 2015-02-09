


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



library(caret);library(kernlab); data(spam)

# slice data into training set and testing set
inTrain <- createDataPartition(y=spam$type, p= 0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
dim(spam)
mdoelFit <- train(type~., data=training, method="glm")
args(train.default)
args(trainControl)



# example Wage ------------------------------------------------------------



library(ISLR);library(ggplot2); library(caret)
data(Wage)
summary(Wage)
str(Wage)

inTrain <- createDataPartition(Wage$wage, p= 0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
dim(training); dim(testing)

# caret 
featurePlot(x=training[,c("age","education", "jobclass")], y=training$wage,plot="pairs")
qplot(age, wage, data=training)

qplot(age,wage, col=jobclass, data=training)
qq <- qplot(age, wage, col= education, data=training)
qq +geom_smooth(method="lm", formula=y~x)

library(Hmisc)
cutWage <- cut2(training$wage, g=3)
table(cutWage)
p1 <- qplot(cutWage,age, data=training, fill=cutWage,geom=("boxplot"))
p1
p2 <- qplot(cutWage,age, data=training, fill=cutWage,geom=c("boxplot", "jitter"))

require("gridExtra")
grid.arrange(p1,p2, ncol=2)
t1 <- table(cutWage, training$jobclass)
t1
prop.table(t1,1)
qplot(wage, colour=education,data=training,geom="density")



# Preprocess --------------------------------------------------------------



library(caret);library(kernlab); data(spam)

# slice data into training set and testing set
inTrain <- createDataPartition(y=spam$type, p= 0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
dim(spam)
# skewed data
hist(training$capitalAve, main="", xlab="ave, capital run length")
mean(training$capitalAve)
sd(training$capitalAve)

# standardizing
testCapAve <- testing$capitalAve
trainCapAve <- training$capitalAve
testCapAveS <- (testCapAve-mean(trainCapAve))/sd(trainCapAve)
mean(testCapAveS)

preObj <- preProcess(training[,-58], method=c("center","scale"))
trainCapAve <- predict(preObj, training[,-58])$capitalAve
mean(trainCapAve)
sd(trainCapAve)
testCapAveS <- predict(preObj, testing[,-58])$capitalAve
mean(testCapAveS)
sd(testCapAveS)


set.seed(32343)
modelFit <- train(type ~., data=training, preProcess=c("center","scale"), method="glm")
modelFit

preObj <- preProcess(training[,-58], method=c("BoxCox"))
trainCapAveS <- predict(preObj, training[,-58])$capitalAve
par(mfrow=c(1,2)); hist(trainCapAveS); qqnorm(trainCapAveS)



set.seed(13343)
training$capAve <- training$capitalAve
selectNA <- rbinom(dim(training)[1], size=1, prob=0.05)==1
training$capAve[selectNA] <- NA


# Impute and standardize
preObj <- preProcess(training[,-58], method="knnImpute")
require("RANN")
capAve <- predict(preObj, training[,-58])$capAve

# Standarzie true values

capAveTruth <- training$capitalAve
capAveTruth <- (capAveTruth-mean(capAveTruth))/sd(capAveTruth)


# imputing data quanlity test
quantile(capAve- capAveTruth)
quantile((capAve-capAveTruth)[selectNA])


# Coverariate creation ----------------------------------------------------

library(kernlab); data(spam)
spam$capitalAveSq <- spam$capitalAve^2



library(ISLR);library(ggplot2); library(caret)
data(Wage)
summary(Wage)
str(Wage)

inTrain <- createDataPartition(Wage$wage, p= 0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
dim(training); dim(testing)
table(training$jobclass)
dummies <- dummyVars(wage ~ jobclass, data=training)
head(predict(dummies, newdata=training))

# throw less import variables
nsv <-nearZeroVar(training,saveMetrics = TRUE)
nsv

library(splines)
bsBasis <- bs(training$age,df=3)
head(bsBasis)


lm1 <- lm(wage ~ bsBasis, data=training)
plot(training$age,training$wage, pch=19, cex=0.5 )
points(training$age,predict(lm1, newdata=training), col="red", pch=19, cex=0.5)

predict(bsBasis, age=testing$age)



# preprocessing with PCA --------------------------------------------------


library(caret);library(kernlab); data(spam)


# slice data into training set and testing set
inTrain <- createDataPartition(y=spam$type, p= 0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
dim(spam)
M <- abs(cor(training[,-58]))
diag(M) <- 0 # remove self correlation 
which(M>0.8, arr.ind = T)

names(spam)[c(34,32)]
plot(spam[,34],spam[,32])

smallSpam <- spam[,c(34,32)]
prComp <- prcomp(smallSpam)
names(prComp)
plot(prComp$x[,1], prComp$x[,2])
prComp$rotation

typeColor <- ((spam$type=="spam")*1+1)
prComp <- prcomp(log10(spam[,-58]+1))
names(prComp)
prComp$rotation[,1]
prComp$rotation[,2]
plot(prComp$x[,1], prComp$x[,2], col= typeColor, xlab="PC1", ylab="PC2")



preProc <- preProcess(log10(spam[,-58]+1), method="pca", pcaComp=2)
spamPC <- predict(preProc, log10(spam[,-58]+1))
plot(spamPC[,1], spamPC[,2], col=typeColor, )

trainPC <- predict(preProc, log10(training[,-58]+1))
modelFit <- train(training$type~. , method="glm", data=trainPC )
summary(modelFit)
testPC <- predict(preProc, log10(testing[,-58]+1))
confusionMatrix(testing$type, predict(modelFit, testPC))


modelFit <- train(training$type ~., method="glm", preProcess="pca",data=training)
confusionMatrix(testing$type, predict(modelFit, testing))




# faithful eruptions ------------------------------------------------------

library(caret); data(faithful); set.seed(333)
inTrain <- createDataPartition(y= faithful$waiting, p=0.5,list=FALSE)
trainFaith <- faithful[inTrain,]; testFaith <- faithful[-inTrain,]
head(trainFaith)
plot(trainFaith)

lm1 <- lm(eruptions ~ waiting, data=trainFaith)
summary(lm1)
plot(trainFaith$waiting, trainFaith$eruptions, pch=19, col="blue",xlab="waiting", ylab="Duration")
lines(trainFaith$waiting,lm1$fitted.values,lwd=3)
newdata <- data.frame(waiting=80)
predict(lm1, newdata)


par(mfrow=c(1,2))
plot(trainFaith$waiting, trainFaith$eruptions, pch=19, col="blue",xlab="waiting", ylab="Duration")
lines(trainFaith$waiting,lm1$fitted.values,lwd=3)
plot(testFaith$waiting, testFaith$eruptions, pch=19, col="blue",xlab="waiting", ylab="Duration")
lines(testFaith$waiting,predict(lm1,newdata=testFaith),lwd=3)


sqrt(sum((lm1$fitted.values-trainFaith$eruptions)^2))
sqrt(sum((predict(lm1,newdata=testFaith)-testFaith$eruptions)^2))

pred1 <- predict(lm1, newdata=testFaith, interval="prediction")
ord <- order(testFaith$waiting)
par(mfrow=c(1,1))
plot(testFaith$waiting, testFaith$eruptions, pch=19, col="blue")
matlines(testFaith$waiting[ord], pred1[ord,],type="l",col=c(1,2,2),lty=c(1,1,1),lwd=3)

modFit <- train(eruptions ~waiting, data=trainFaith, method="lm")
summary(modFit$finalModel)



# multivariate regreesion -------------------------------------------------



library(ISLR); library(ggplot2); library(caret);
data(Wage);Wage <- subset(Wage, select=-c(logwage))
summary(Wage)
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
training <- Wage[inTrain, ]; testing <- Wage[-inTrain, ]
dim(training);dim(testing)
featurePlot(x=training[,c("age","education", "jobclass")], y=training$wage,plot="pairs")
qplot(age, wage, data=training)
qplot(age, wage, colour=education, data=training)

modFit <- train(wage ~ age+ jobclass+ education, method="lm", data=training)
finMod <- modFit$finalModel
print(modFit)

plot(finMod, 1 ,pch=19, cex=0.5, col="black")
qplot(finMod$fitted.values, finMod$residuals, colour=race, data=training)
plot(finMod$residuals, pch=19)

pred <- predict(modFit, testing)
qplot(wage, pred, colour=year, data=testing)


modFitAll <- train(wage~., data=training, method="lm")
prec <- predict(modFitAll, testing)
qplot(wage, prec,data=testing)
