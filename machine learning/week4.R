library(ElemStatLearn);data(prostate)
str(prostate)





# example on predictor combination ----------------------------------------

library(ISLR); data(Wage); library(ggplot2); library(caret);


Wage <- subset(Wage,select=-c(logwage))

# Create a building data set and validation set
inBuild <- createDataPartition(y=Wage$wage,
                               p=0.7, list=FALSE)

validation <- Wage[-inBuild,]; buildData <- Wage[inBuild,]

inTrain <- createDataPartition(y=buildData$wage,
                               p=0.7, list=FALSE)
training <- buildData[inTrain,]; testing <- buildData[-inTrain,]

dim(training)
dim(testing)
dim(validation)

# Build two different models
mod1 <- train(wage ~.,method="glm",data=training)
mod2 <- train(wage ~.,method="rf",
              data=training, 
              trControl = trainControl(method="cv"),number=3)


pred1 <- predict(mod1,testing); pred2 <- predict(mod2,testing)
qplot(pred1,pred2,colour=wage,data=testing)

# use generalized addctive model

predDF <- data.frame(pred1,pred2,wage=testing$wage)
combModFit <- train(wage ~.,method="gam",data=predDF)
combPred <- predict(combModFit,predDF)


# testing error
sqrt(sum((pred1-testing$wage)^2))
sqrt(sum((pred2-testing$wage)^2))
sqrt(sum((combPred-testing$wage)^2))


# Predict on validation data set

pred1V <- predict(mod1,validation); pred2V <- predict(mod2,validation)
predVDF <- data.frame(pred1=pred1V,pred2=pred2V)
combPredV <- predict(combModFit,predVDF)


# Evaluate on validation

sqrt(sum((pred1V-validation$wage)^2))
sqrt(sum((pred2V-validation$wage)^2))
sqrt(sum((combPredV-validation$wage)^2))


# Time series forcasting

library(quantmod)
from.dat <- as.Date("01/01/08", format="%m/%d/%y")
to.dat <- as.Date("12/31/13", format="%m/%d/%y")
getSymbols("GOOG", src="google", from = from.dat, to = to.dat)
head(GOOG)


# decompose a time series into parts
googOpen <- Op(GOOG)
ts1 <- ts(googOpen,frequency=360)
plot(ts1,xlab="Years+1", ylab="GOOG")
plot(decompose(ts1),xlab="Years+1")

# Training and test sets
ts1Train <- window(ts1,start=1,end=5)
ts1Test <- window(ts1,start=5,end=7)
ts1Train

plot(ts1Train)

library(forecast)
lines(ma(ts1Train,order=3),col="red")


# ets1 <- ets(ts1Train,model="MMM")
# fcast <- forecast(ets1)
# plot(fcast); lines(ts1Test,col="red")

