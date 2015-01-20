
# Q1 ----------------------------------------------------------------------



library(MASS)
?shuttle

fit <- glm(use ~ wind, data=shuttle, family="binomial")

exp(fit$coefficients[2])


# Q2 ----------------------------------------------------------------------

fit2 <- glm(use ~ wind+magn, data=shuttle, family="binomial")

exp(fit2$coefficients)



# Q4 ----------------------------------------------------------------------

data(InsectSprays)
InsectSprays$spray <- factor(InsectSprays$spray)
levels(InsectSprays$spray)
names(InsectSprays)
?InsectSprays
fit3 <- glm(count ~ spray, data=InsectSprays, family="poisson")

1/exp(fit3$coefficients[2])



# Q5 ----------------------------------------------------------------------

download.file("https://dl.dropboxusercontent.com/u/7710864/data/gaData.rda",destfile="./data/gaData.rda",method="auto")
load("./data/gaData.rda")
gaData$julian <- julian(gaData$date)

plot(gaData$julian,gaData$visits,pch=19,col="darkgrey",xlab="Julian",ylab="Visits")
glm1 <- glm(gaData$visits ~ gaData$julian,family="poisson")
lines(gaData$julian,glm1$fitted,col="blue",lwd=3)

t <- log(seq(1:nrow(gaData)))

length(t)

glm2 <- glm(gaData$visits ~ gaData$julian+offset(t),family="poisson")

lines(gaData$julian,glm2$fitted,col="red",lwd=3)

glm3 <- glm(gaData$visits ~ gaData$julian+offset(log(10)*t),family="poisson")

lines(gaData$julian,glm2$fitted,col="yellow",lwd=3)



# Q6 ----------------------------------------------------------------------

x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)

plot(x,y)

knot <- 0
spline <- (x>0)*(x-knot)
xMat <- cbind(1,x,spline)
fit <- lm(y~xMat-1)
fit$coefficients[2]+fit$coefficients[3]
