download.file("https://dl.dropboxusercontent.com/u/7710864/data/ravensData.rda"
              ,destfile="./data/ravensData.rda",method="auto")
load("./data/ravensData.rda")
head(ravensData)


# Visualizing fitting logistic regression curves --------------------------

library(manipulate)
x <- seq(-10, 10, length = 1000)
manipulate(
        plot(x, exp(beta0 + beta1 * x) / (1 + exp(beta0 + beta1 * x)), 
             type = "l", lwd = 3, frame = FALSE),
        beta1 = slider(-2, 2, step = .1, initial = 2),
        beta0 = slider(-2, 2, step = .1, initial = 0)
)


# Ravens logistic regression ----------------------------------------------

logRegRavens <- glm(ravensData$ravenWinNum ~ ravensData$ravenScore,family="binomial")
summary(logRegRavens) 
anova(logRegRavens,test="Chisq")



# Possion mass function ---------------------------------------------------


par(mfrow = c(1, 3))
plot(0 : 10, dpois(0 : 10, lambda = 2), type = "h", frame = FALSE)
plot(0 : 20, dpois(0 : 20, lambda = 10), type = "h", frame = FALSE)
plot(0 : 200, dpois(0 : 200, lambda = 100), type = "h", frame = FALSE)



# Leek Group Website Traffic ----------------------------------------------
download.file("https://dl.dropboxusercontent.com/u/7710864/data/gaData.rda",destfile="./data/gaData.rda",method="auto")
load("./data/gaData.rda")
gaData$julian <- julian(gaData$date)
head(gaData)
plot(gaData$julian,gaData$visits,pch=19,col="darkgrey",xlab="Julian",ylab="Visits")
lm1 <- lm(gaData$visits ~ gaData$julian)
abline(lm1,col="red",lwd=3)

round(exp(coef(lm(I(log(gaData$visits + 1)) ~ gaData$julian))), 5)

