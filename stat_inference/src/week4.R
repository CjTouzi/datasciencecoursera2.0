# power
mu0 =30
mua =32
sigma =4
n=16
z <- qnorm(1-alpha)

# same effect size 
power.t.test(n=16, delta=2, sd=4,type="one.sample", alt="one.side")$power

power.t.test(n=16, delta=100, sd=200,type="one.sample", alt="one.side")$power


power.t.test(n=16, delta=2/4, sd=1,type="one.sample", alt="one.side")$power


power.t.test(power=0.8, delta=2/4, sd=1,type="one.sample", alt="one.side")$n

power.t.test(power=0.8, delta=2, sd=4,type="one.sample", alt="one.side")$n


# multiple testing 

# Bonferroni correction- very conservative  

# controlling false discover rate (FDR)


set.seed(1010093)
pvalues <- rep(NA,1000)
for(i in 1:1000){
    x <- rnorm(20)
    y <- rnorm(20)
    pvalues[i] <- summary(lm(y~x))$coeff[2,4]
    
}

sum(pvalues<0.05)

sum(p.adjust(pvalues,method="bonferroni")<0.05)

sum(p.adjust(pvalues,method="BH")<0.05)


set.seed(1010093)
pvalues <- rep(NA,1000)

for(i in 1:1000){
    x <- rnorm(20)
    # First 500 beta=0, last 500 beta=2
    if (i<=500){y <- rnorm(20)} else { y<-rnorm(20,mean=2*x)}
    pvalues[i] <- summary(lm(y~x))$coeff[2,4]
  
}

true.status <- rep(c("zero", "not zero"), each=500)
table (pvalues<0.05, true.status)


table(p.adjust(pvalues,method="bonferroni")<0.05, true.status)

table(p.adjust(pvalues,method="BH")<0.05, true.status)

par(mfrow=c(1,2))
plot(pvalues, p.adjust(pvalues,method="bonferroni"))

# bootstraping 

library(UsingR)
library(ggplot2)
data(father.son)
x <- father.son$sheight
n <- length(x)

# number of bootstraping 
B <- 10000

# replace = TRUE
resamples <- matrix(sample(x, n*B, replace=TRUE),B,n)

dim(resamples)
resamples.medians <- apply(resamples,1, median)
sd(resamples.medians)
quantile(resamples.medians,c(0.025,0.975))
g <- ggplot(data.frame(resamples.medians = resamples.medians), aes(x= resamples.medians))
g <- g+geom_histogram(color="black",fill="blue",binwidth=0.05)
g        


hist(resamples.medians, breaks=100)

# permutation test & group comparisons

subdata <- InsectSprays[InsectSprays$spray %in% c("B","C"),]
y <- subdata$count
group <- as.character(subdata$spray)
test.stat <- function(w,g) mean(w[g=="B"])-mean(w[g=="C"])
observed.stat <- test.stat(y, group)        
        
permutations <- sapply(1:10000, function(i) test.stat(y,sample(group)))        
hist(permutations)

observed.stat
mean(permutations > observed.stat)



