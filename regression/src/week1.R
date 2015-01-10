

# least square ------------------------------------------------------------


library(UsingR);data(galton)

par(mfrow = c(1,2))
hist(galton$child,breaks=100)
hist(galton$parent, breaks=100)

# Size of point represents number of points at that (X, Y) combination
par(mfrow = c(1,1))

freqData <- as.data.frame(table(galton$child, galton$parent))
names(freqData) <- c("child", "parent", "freq")
plot(as.numeric(as.vector(freqData$parent)), 
     as.numeric(as.vector(freqData$child)),
     pch = 21, col = "black", bg = "lightblue",
     cex = .15 * freqData$freq, 
     xlab = "parent", ylab = "child")


# linear fitting without intercept

lm(I(child-mean(child))~I(parent-mean(parent))-1, data=galton)


y <- galton$child
x <- galton$parent

beta1 <- cor(y,x)*sd(y)/sd(x)
beta0 <- mean(y)-beta1*mean(x)

rbind(c(beta0, beta1), coef(lm(y~x)))




