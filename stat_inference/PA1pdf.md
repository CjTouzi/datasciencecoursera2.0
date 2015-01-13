#  Exponential Distribution and Central Limit Theorem
CJ  
Thursday, January 08, 2015  

### Overview

In this project we investigate the exponential distribution and compare it with the Central Limit Theorem. We sample 40 exponentials and calculate their mean and standard deviation. After a thousand of simulations, we compare the average of such mean and standard deviation with its theoretical values, whose value should be both 1/lambda for the mean and the standard deviation. Finally, the distributions of the sample mean and standard deviation are normalized and compared with the standard normal. 

### Simulation 

Firstly, calculate the theoretical values of exponential mean and standard deviation. When `lambda`= 0.2, both mean and standard deviation equal to `5`.  


```r
lambda <-0.2 
# therotical values of sd and mean
tsd <- 1/lambda
tsd
tmn <- 1/lambda
tmn
```

```
## [1] 5
## [1] 5
```
 
Now, we generate 1000 averages of 40 random exponentials. In the chunk, a function called `exps` generate a vector of size `n` contains transformation of `m` exponentials. For example, here we use function `mean`, which returns a vector of means of `m` exponetials. By passing the function `var` to our `exps` function, we generate 1000 variances of 40 random exponentials. 



```r
lambda <-0.2 

n<-1000 # Number of simulations simulations
m<-40 # Number of  exponentials.



exps<- function(ne,ns,lambda,seed, FUN=mean){
        
        set.seed(seed)
        x=NULL
        for (i in 1:ns) x=c(x, FUN(rexp(ne,lambda))) 
        data.frame(x)
        
        
} 

mns <- exps(40,1000,lambda, 1000, mean)

vars <- exps(40,1000,lambda,1000, FUN=var)
```

### Sample Mean versus Theoretical Mean

Plot the histogram of a thousand of simulated means and compare the average of these means with its theoretical value.


```r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 3.1.2
```

```r
# average of means
smn <- mean(mns$x)
smn 
# standard error
sse <- sd(mns$x)/sqrt(n) 
sse

# plot histogram
g1 <- ggplot(mns, aes(x=x)) 

myhist<- function(g, bw,title) {        
        hist <- g+ geom_histogram(binwidth=bw, colour="black", fill="white")+
                ggtitle(title)+
                theme(plot.title = element_text(lineheight=.8, face="bold"))+
                xlab("")+
                ylab("Count")
        hist 
}

hist1 <- myhist(g1, 0.1, title="Fig1: Sample Mean versus Theoretical Mean")

# add annotation 

notex <- 6
notey <- 70

hist1+ geom_vline(aes(xintercept=smn),color="red", linetype="dashed", size=1)+
        annotate("text", x = notex, y = notey, 
                 label = paste("sample mean:", as.character(round(smn,2))), color="red")+
        geom_vline(aes(xintercept=tmn),color="blue", linetype="dashed", size=1)+
        annotate("text", x = notex, y = notey+5, 
                 label = paste("theoretical mean:",  as.character(round(tmn,2))), color="blue")
```

![](PA1pdf_files/figure-html/unnamed-chunk-3-1.png) 

```
## [1] 4.986963
## [1] 0.02558013
```

As we can see from `Fig1`, the center of sample means is very close to the theoretical mean with a standard error 0.02558013. 


### Sample Variance versus Theoretical Variance

Next, we investigate on the sample variance. 


```r
lambda <-0.2 
n<-1000 # Number of simulations simulations
m<-40 # Number of  exponentials.

vars <- exps(40,1000,lambda,1000, FUN=var)
```

Plot the histogram of a thousand of simulated variances and compare the average of these variances with its theoretical value.


```r
library(ggplot2)

# average of variances
mv <- mean(vars$x)

# standard error
sse <- sd(vars$x)/sqrt(n) 
sse

# plot histogram
g2 <- ggplot(vars, aes(x=x)) 


hist2 <- myhist(g2, 1, title="Fig2: Sample Variance versus Theoretical Variance")

# add annotation 

notex <- 50
notey <- 45

hist2+ geom_vline(aes(xintercept=mv),color="red", linetype="dashed", size=1)+
        annotate("text", x = notex, y = notey, 
                 label = paste("sample variance:", as.character(round(mv,2))), color="red")+
        geom_vline(aes(xintercept=tsd^2),color="blue", linetype="dashed", size=1)+
        annotate("text", x = notex, y = notey+5, 
                 label = paste("theoretical variance:",  as.character(round(tsd^2,2))), color="blue")
```

![](PA1pdf_files/figure-html/unnamed-chunk-5-1.png) 

```
## [1] 0.3716744
```



###  Comparison with the Central Limit Theorem

The **law of large numbers (LLN)** states that the average of the results obtained from a large number of trials should be close to the expected value. As shown in both `Fig1` and `Fig2`, mean and variance are close to their theoretical values. Futher more, the `Central Limit Theorem` (CLT) states that the distribution of averages of iid variables, properly normalized, becomes that of a standard normal as the sample size increases. 

#### Nomarlization

Here we normalize both sample mean and variance and compare with the standard normal distribution. 


```r
normalize <- function(x, xbar, ste){
        
        (x-xbar)/ste
        
} 


mns <- exps(40,1000,lambda, 1000, FUN=mean)

vars <- exps(40,1000,lambda,1000, FUN=var)


Nmns <- as.data.frame(normalize(mns$x, mean(mns$x), sd(mns$x)))
names(Nmns) <- "x"
Nv <- as.data.frame(normalize(vars,mean(vars$x), sd(vars$x)))
names(Nmns) <- "x"
```

Now plot both distributions of sample mean and variance and overlay with the standard normal distribution.


```r
library(ggplot2)
require(gridExtra)
```

```
## Loading required package: gridExtra
```

```
## Warning: package 'gridExtra' was built under R version 3.1.2
```

```
## Loading required package: grid
```

```r
# plot histogram
g3 <- ggplot(Nmns, aes(x=x)) 
g4 <- ggplot(Nv, aes(x=x)) 


# plot density + standard normal distribution 
myNormPlot <- function(fh, title){
        
        g<- fh+ geom_histogram(aes(y=..density..), binwidth=0.2, colour="black", fill="white")+
        ggtitle(title)+
        theme(plot.title = element_text(lineheight=.8, face="bold"))+
        xlab("")+
        ylab("")+
        stat_function(fun = dnorm, size = 1)+
        xlim(-4,4)
        g
        
} 

g3 <- myNormPlot(g3,"(a) Normalized Sample Mean")
g4 <- myNormPlot(g4,"(b) Normalized Sample Variance")

grid.arrange(g3, g4, ncol=2, 
             main=textGrob("Fig3: Comparison with Standard Normal",
                           gp = gpar(fontsize = 14, 
                                     fontface = "bold"))
             )
```

![](PA1pdf_files/figure-html/unnamed-chunk-7-1.png) 

As we can see in `Fig3`, both `(a)` and `(b)` are close to standard normal distribution, which center at 0 and most of the data are within 3 times $\sigma$. 
But variance distribution is more skewing to the right. This might due to the limitation of the CLT that doesn't give the exact sample size. 













