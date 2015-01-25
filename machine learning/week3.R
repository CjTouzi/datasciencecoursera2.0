data(iris); library(ggplot2)
names(iris)
table(iris$Species)

inTrain <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)
training <- iris[inTrain, ]
testing <- iris[-inTrain, ]
head(inTrain)
dim(training); dim(testing)

qplot(Petal.Width, Sepal.Width, colour=Species, data=training)
library(caret); require(lattice)
modFit <- train(Species ~., method="rpart", data=training)
print(modFit$finalModel)

library(rattle);
fancyRpartPlot(modFit$finalModel)

predict(modFit, newdata=testing)


# Bagging -----------------------------------------------------------------


library(ElemStatLearn); data(ozone, package="ElemStatLearn")
ozone <- ozone[order(ozone$ozone),]
head(ozone)


ll <- matrix(NA, nrow=10, ncol=155)
for(i in 1:10) {
    
    ss <- sample(1:dim(ozone)[1], replace=TRUE)
    ozone0 <- ozone[ss,]; ozone0 <- ozone[order(ozone$ozone), ]
    loess0 <- loess(temperature ~ ozone, data=ozone0, span=0.2)
    ll[i,] <- predict(loess0, newdata=data.frame(ozone=1:155))
}


plot(ozone$ozone, ozone$temperature, pch=19, cex=0.5)

for(i in 1:10){ 
    lines( 1:155, ll[i,], col="grey", lwd=2)
}

dim(ll)
lines(1:155, apply(ll,2,mean), col="red", lwd=2)


predictors = data.frame(ozone=ozone$ozone)
tempature = ozone$temperature
treebag <- bag(predictors, tempature, B=10,
               bagControl = bagControl(fit=ctreeBag$fit,
                                       predict=ctreeBag$pred,
                                       aggregate= ctreeBag$aggregate))

ctreeBag$fit


# random forest -----------------------------------------------------------

data(iris); library(ggplot2)
inTrain <- createDataPartition(y=iris$Species,
                               p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
library(caret)
modFit <- train(Species~ .,data=training,method="rf",prox=TRUE)

modFit
getTree(modFit$finalModel, k=2)
irisP <- classCenter(training[,c(3,4)], training$Species, modFit$finalModel$prox)
irisP <- as.data.frame(irisP); irisP$Species <- rownames(irisP)
p <- qplot(Petal.Width, Petal.Length, col=Species,data=training)
p + geom_point(aes(x=Petal.Width,y=Petal.Length,col=Species),size=5,sha pe=4,data=irisP)


pred <- predict(modFit,testing); testing$predRight <- pred==testing$Species
table(pred,testing$Species)



# Boosting ----------------------------------------------------------------


