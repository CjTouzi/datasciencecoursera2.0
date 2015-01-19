library(datasets);data(swiss);
require(stats);require(graphics)
pairs(swiss,panel= panel.smooth, main="swiss data", col=3+ (swiss$Catholic>50))

str(swiss)
?swiss

summary(lm(Fertility ~ ., data=swiss))

summary(lm(Fertility ~ Agriculture, data=swiss))$coefficient

library(rgl)
plot3d(seq(1:10),seq(2:11),seq(3:12))


data(swiss);par(mfrow=c(2,2))
fit <- lm(Fertility ~ ., data=swiss);
?influence.measures
plot(fit)

par(mfrow=c(1,1))
n <- 100; x <- c(10,rnorm(n)); y<- c(10,c(rnorm(n)))
plot(x,y, frame=FALSE, cex=2, pch=21,bg="lightblue",col="black")
abline(lm(y~x))
fit<-lm(y~x)
round(dfbetas(fit)[1:10,2],3)
round(hatvalues(fit)[1:10],3)

library(car)
fit <- lm(Fertility ~., data=swiss)
vif(fit)

fit1 <- lm(Fertility ~ Agriculture, data=swiss)
fit3 <- update(fit,Fertility ~ Agriculture+Examination+Education, data=swiss)
fit5 <- update(fit,Fertility ~ Agriculture+Examination+Education+Catholic+Infant.Mortality, data=swiss)
