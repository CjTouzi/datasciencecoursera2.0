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



