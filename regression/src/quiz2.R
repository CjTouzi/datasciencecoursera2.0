
# Q1 ----------------------------------------------------------------------

x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

fit <- lm(y~x)
summary(fit)


# Q2 ----------------------------------------------------------------------


res <- resid(lm(y~x))
class(res)


# Q3 ------------------------------------------------------------------

data(mtcars)
x <- mtcars$wt; y <- mtcars$mpg
fit <- lm(y ~ x)
xVals <- seq(min(x), max(x), by=.01)
newdata <- data.frame(x=xVals)
p1 <- predict(fit, newdata, interval= "confidence")
p2 <- predict(fit,newdata, interval ="prediction")


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



# Q6 ----------------------------------------------------------------------

x <- 2* mtcars$wt; y <- mtcars$mpg
fit <- lm(y ~ x)
summary(fit)


