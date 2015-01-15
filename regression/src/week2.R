library(UsingR);data(diamond)
plot(diamond$carat, diamond$price,
     xlab= "Mass(carats)",
     ylab="Pirce(Sin $)",
     bg="lightblue",
     col="black", cex=1.1, pch=21,frame=FALSE)
abline(lm(price~ carat, data=diamond), lwd=2)
fit <- lm(price~ carat, data=diamond)
coef(fit)

fit2 <- lm(price ~ I(carat - mean(carat)), data=diamond)
coef(fit2)

fit3 <- lm(price ~ I(carat*10), data=diamond)
coef(fit3)

newx <- c(0.16, 0.27, 0.24)
coef(fit)[1]+coef(fit)[2]*newx

predict(fit, newdata =data.frame(carat=newx))

e <- resid(fit)
yhat <- predict(fit)

max(abs(e-(diamond$price-yhat)))

x <- runif(100,-3,3); y <- x+sin(x)+rnorm(100,sd=.2)
plot(x,y); abline(lm(y~x))

plot(x, resid(lm(y~x)))
abline(h=0)

# heteroskedasticity
x <- runif(100,0 ,6); y <- x+rnorm(100,mean=0, sd=0.001*x)
plot(x,y); abline(lm(y~x))
plot(x, resid(lm(y~x)))
abline(h=0)

y <- diamond$price; x <- diamond$carat; n <- length(y)
fit <- lm(y~x)
summary(fit)$sigma

sqrt(sum(resid(fit)^2)/(n-2))
data(anscombe); example(anscombe)



# T Test for Regression Coeffcients --------------------------------------
library(UsingR);data(diamond)
y <- diamond$price; x <- diamond$carat; n <- length(y)
beta1 <- cor(y,x) * sd(y)/sd(x)
beta0 <- mean(y)-beta1 * mean(x)
e <- y- beta0- beta1*X
sigma <- sqrt(sum(e^2)/(n-2))
ssx <- sum((x-mean(x)^2))
fit <- lm(y~x)
summary(fit)$coefficients
sumCoef <- summary(fit)$coefficients

# 95% confidence interval
sumCoef[1,1]+c(-1,1)*qt(0.975,df=fit$df)*sumCoef[1,2]

sumCoef[2,1]+c(-1,1)*qt(0.975,df=fit$df)*sumCoef[2,2]

# prediction intervals
plot(x,y, frame=FALSE, 
     xlab="Carat", ylab="Dollars", 
     pch=21, col="black", bg="lightblue",cex=2)
abline(fit, lwd=2, col= "red")
xVals <- seq(min(x), max(x), by=.01)
yVals<- beta0 + beta1 * xVals
se1 <- sigma * sqrt(1/n-(xVals-mean(x))^2/ssx)
se2 <- sigma * sqrt(1+1/n+(xVals-mean(x))^2/ssx)
lines(xVals, yVals+qt(0.975,df=n-2)*se1)
lines(xVals, yVals-qt(0.975,df=n-2)*se1)
lines(xVals, yVals+qt(0.975,df=n-2)*se2)
lines(xVals, yVals-qt(0.975,df=n-2)*se2)

newdata <- data.frame(x=xVals)
p1 <- predict(fit, newdata, interval= "confidence")
p2 <- predict(fit,newdata, interval ="prediction")

plot(x,y, frame=FALSE, 
     xlab="Carat", ylab="Dollars", 
     pch=21, col="black", bg="lightblue",cex=2)
abline(fit,lwd=2)
lines(xVals, p1[,2]); lines(xVals, p1[,3])
lines(xVals, p2[,2]);lines(xVals, p1[,3])

# multivariable linear models 

n <-100; x<-rnorm(n); x2 <- rnorm(n); x3 <- rnorm(n)
y <- x + x2 + x3 + rnorm(n,sd=.1)                                                
coef(lm(y~ x+ x2 + x3 -1)) # the -1removes the intercept term 

