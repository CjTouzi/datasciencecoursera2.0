library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

names(vowel.train)

vowel.train$y <- factor(vowel.train$y)
vowel.test$y <- factor(vowel.test$y)
set.seed(33833)

# create models
mod1 <- train(y ~ ., data = vowel.train, method = "rf", 
              trControl = trainControl(number = 4))
mod2 <- train(y ~ ., data = vowel.train, method = "gbm")



# predict test
predict1 <- predict(mod1, newdata = vowel.test)
predict2 <- predict(mod2, newdata = vowel.test)


# combine predictions
DF_combined <- data.frame(predict1, predict2, y = vowel.test$y)
fit_combined <- train(y ~ ., data = DF_combined, method = "gam")
predict3 <- predict(fit_combined, newdata = DF_combined)


# confusion matrixes
c1 <- confusionMatrix(predict1, vowel.test$y)
c2 <- confusionMatrix(predict2, vowel.test$y)
c3 <- confusionMatrix(predict3, DF_combined$y)
c1
c2
c3


# Q2 ----------------------------------------------------------------------

library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)

mod1 <- train( diagnosis~ ., data = training, method = "rf")
mod2 <- train(diagnosis~ ., data = training, method = "gbm")
mod3 <- train(diagnosis~ ., data = training, method = "lda")

# Stack the predictions together using random forests ("rf")

pre1 <- predict(mod1,testing)
pre2 <- predict(mod2,testing)
pre3 <- predict(mod3,testing)

DF_combined <- data.frame(pre1, pre2, pre3, diagnosis = testing$diagnosis)
combModFit <- train(diagnosis ~.,data=DF_combined, method="rf")
combPred <- predict(combModFit,DF_combined)

c <-confusionMatrix(combPred, testing$diagnosis)


c1 <- confusionMatrix(pre1, testing$diagnosis)
c2 <- confusionMatrix(pre2, testing$diagnosis)
c3 <- confusionMatrix(pre3, testing$diagnosis)
c$overall; c1$overall; c2$overall; c2$overall



# Q3 ----------------------------------------------------------------------

# fit a lasso model

set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(233)
fit <- train(CompressiveStrength ~ ., data = training, method = "lasso")

# Since we are interested in the shrinkage of coefficients as the penalty(lambda) increases, "
# penalty" looks promising for an xvar argument value.

fit$finalModel
plot.enet(fit$finalModel, xvar = "penalty", use.color = TRUE) 


# Q4 ----------------------------------------------------------------------

library(lubridate)  # For year() function below
dat = read.csv("./gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)
tstest =ts(testing$visitsTumblr)

library(forecast)
?bats
mod <- bats(tstrain)
fcast <- forecast(mod, level = 95, h = nrow(testing))
cf <- data.frame(lw=fcast$lower, up=fcast$upper, mean=fcast$mean)

testing$visitsTumblr > cf$lw & testing$visitsTumblr < cf$up 

length(testing$visitsTumblr[
        testing$visitsTumblr>cf$lw 
        & testing$visitsTumblr<cf$up])/length(testing$visitsTumblr)

# [1] 0.9617021



# Q5 ----------------------------------------------------------------------

# fitting a SVM model

set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]


set.seed(325)

library(e1071)
library(caret)

fit <- train(CompressiveStrength ~ ., data = training, method = "svmRadial")

prediction <- predict(fit, testing)
library(forecast)


accuracy(prediction, testing$CompressiveStrength)

