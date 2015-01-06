
# normal 
nosim <- 1000
n <- 10
sd(apply(matrix(rnorm(nosim*n),nosim),1,mean))
1/sqrt(n)

# uniform 
sd(apply(matrix(runif(nosim*n),nosim),1,mean))
1/sqrt((12*n))

# possion
sd(apply(matrix(rpois(nosim*n,4),nosim),1,mean))
2/sqrt(n)

# fair flips 
sd(apply(matrix(sample(0:1, nosim*n,replace=TRUE),nosim),1,mean))
1/(2*sqrt(n))

# data example
library(UsingR)
data(father.son)
x <- father.son$sheight
n <- length(x)

hist(x, breaks=25)

round(c(var(x),var(x)/n, sd(x),sd(x)/sqrt(n)),2)

# binormal 
pbinom(8, size=10, prob = 0.5, lower.tail = FALSE)

# normal 
qnorm(.95,mean=0,sd=1)

pnorm(1160,mean=1020, sd=50, lower.tail = FALSE)

qnorm(0.75, mean=1020,sd=50)

pnorm(5,mean=11,sd=2)


# possion 
ppois(3,lambda=2.5*4)
ppois(40, 9*5)
# when n becomes very large and p is very small. 
# possion can be used to estimate bionomial 
pbinom(2,size=500, prob=0.01)
ppois(2,lambda = 500*0.01)







