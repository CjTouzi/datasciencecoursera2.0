
# Q1 ----------------------------------------------------------------------

x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

fit <- lm(y~x)
summary(fit)


# Q2 ----------------------------------------------------------------------


res <- resid(lm(y~x))
sqrt(sum(res^2))/sqrt(7)

class(res)


# Q3 ------------------------------------------------------------------

# confidence interval is the confidence for the average 

data(mtcars)
x <- mtcars$wt; y <- mtcars$mpg
fit <- lm(y ~ x)
xVals <- seq(min(x), max(x), by=.01)
newdata <- data.frame(x=mean(x))
predict(fit, newdata, interval= "confidence")


plot(x,y, frame=FALSE, 
     xlab="Carat", ylab="Dollars", 
     pch=21, col="black", bg="lightblue",cex=2)

abline(fit,lwd=2)
lines(xVals, p1[,2])
lines(xVals, p1[,3])
lines(xVals, p2[,2])
lines(xVals, p2[,3])

summary(fit)

mean(x)
b1 <- -5.3445 -qt(0.975, length(x)-2)*0.5591
b1
b0 <- 37.2851+ qt(0.975, length(x)-2)* 1.8776
b1 * 3+ b0

# Q4 ----------------------------------------------------------------------
help(mtcars)



# Q5 ----------------------------------------------------------------------


# predication interval is the confidence interval for one data, taking account the rand 
data(mtcars)
x <- mtcars$wt; y <- mtcars$mpg
fit <- lm(y ~ x)
xVals <- seq(min(x), max(x), by=.01)
newdata <- data.frame(x=3)


predict(fit,newdata, interval ="prediction")

# Q6 ----------------------------------------------------------------------

data(mtcars)

x <- 0.5*mtcars$wt; y <- mtcars$mpg

fit <- lm(y ~ x)
xVals <- seq(min(x), max(x), by=.01)
newdata <- data.frame(x=1)

summary(fit)
-10.689-qt(0.975,length(x)-2)*1.118


# Q9 ----------------------------------------------------------------------
data(mtcars)
x <- mtcars$wt; y <- mtcars$mpg
fit <- lm(y ~ x)
summary(fit)
1/(1-0.7528)



