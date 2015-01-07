
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



# Asymtotics
# law of large number in action 
n <- 1000
means <- cumsum(rnorm(n))/(1:n)
plot(means,type="l")

means <- cumsum(sample(0:1,n, replace=TRUE))/(1:n)
plot(means,type="l")




# confidence interval 

library(UsingR)
data(father.son)
x <- father.son$sheight
# infeet
(mean(x)+c(-1,1)*qnorm(0.975)*sd(x)/sqrt(length(x)))/12

# Wald confidence 
binom.test(56,100)$conf.int


# simulation 

# central limit for small n
n <-20
pvals <- seq(0.1,0.9, by =0.05)
nosim<-1000 
coverage <- sapply(pvals, function(p){
        phats <- rbinom(nosim, prob=p, size=n)/n
        ll <- phats-qnorm(0.975)*sqrt(phats*(1-phats)/n)
        ul <- phats+qnorm(0.975)*sqrt(phats*(1-phats)/n)
        mean(ll<p & ul>p)
        
})

plot(coverage,type="l")
abline(h=0.95, col="red")

# central limit for larger n
n <-100
pvals <- seq(0.1,0.9, by =0.05)
nosim<-1000 
coverage <- sapply(pvals, function(p){
        phats <- rbinom(nosim, prob=p, size=n)/n
        ll <- phats-qnorm(0.975)*sqrt(phats*(1-phats)/n)
        ul <- phats+qnorm(0.975)*sqrt(phats*(1-phats)/n)
        mean(ll<p & ul>p)
        
})

plot(coverage,type="l")
abline(h=0.95, col="red")

# fix with Agresti/Coull interval 

# (X+2)/(n+4)

n <-20
pvals <- seq(0.1,0.9, by =0.05)
nosim<-1000 
coverage <- sapply(pvals, function(p){
        
        # ading 2 secces and a failes  
        phats <- (rbinom(nosim, prob=p, size=n)+2)/(n+4)
        ll <- phats-qnorm(0.975)*sqrt(phats*(1-phats)/n)
        ul <- phats+qnorm(0.975)*sqrt(phats*(1-phats)/n)
        mean(ll<p & ul>p)
        
})

plot(coverage,type="l", ylim=c(0.9,1), main="Agresti/Coull interval ")
abline(h=0.95, col="red")


# possion simulation 


# small n
# recommondation: for small lamda, don't use asymptotic interval 



lambdavals <- seq(0.005,0.1,by=0.01)
nosim<-1000 
t <-100
coverage <- sapply(
        lambdavals , function(lambda){
        
        # ading 2 secces and a failes  
        lhats <- rpois(nosim, lambda = lambda*t)/t
        ll <- lhats-qnorm(0.975)*sqrt(lhats/t)
        ul <- lhats+qnorm(0.975)*sqrt(lhats/t)
        mean(ll<lambda & ul>lambda)
        
})

plot(coverage,type="l", ylim=c(0,1), main="t=100", xlab="lamda")
abline(h=0.95, col="red")


# large n

lambdavals <- seq(0.005,0.1,by=0.01)
nosim<-1000 
t <-1000
coverage <- sapply(
        lambdavals , function(lambda){
                
                # ading 2 secces and a failes  
                lhats <- rpois(nosim, lambda = lambda*t)/t
                ll <- lhats-qnorm(0.975)*sqrt(lhats/t)
                ul <- lhats+qnorm(0.975)*sqrt(lhats/t)
                mean(ll<lambda & ul>lambda)
                
        })

plot(coverage,type="l", ylim=c(0,1), main="t=1000", xlab="lamda")
abline(h=0.95, col="red")




