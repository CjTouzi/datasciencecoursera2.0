# t distribution, degree of freedom
# comparison between T distribution and z distribution
# # distribution with different df

library(manipulate)
library(ggplot2)
k <- 1000
xvals <- seq(-5,5, length=k)
myplot <- function(df){
        d <- data.frame(y= c(dnorm(xvals), dt(xvals,df)), 
                       x=xvals, 
                       dist= factor(rep(c("Normal","T"),c(k,k))))
        
        g <- ggplot(d,aes(x=x,y=y))        
        g <- g+ geom_line(size=2, aes(colour=dist))    
        g
        
}

manipulate(myplot(mu), mu=slider(1,20,step=1))

# comparison between T distribution and z distribution 
# quantile with different df

pvals <- seq(.5,.99,by=.01)

myplot2 <- function(df){
        d <- data.frame(n= qnorm(pvals), 
                        t=qt(pvals, df),
                        p=pvals)
        
        g <- ggplot(d,aes(x=n,y=t))        
        g <- g+ geom_abline(size=2, col="lightblue")+
                geom_line(size=2, col="black")+
                geom_vline(xintercept=qnorm(0.975))+
                geom_hline(yintercept= qt(0.975,df))+
        
        g
        
}

manipulate(myplot2(df), df=slider(1,20,step=1))


# sleep data
# t test for matching group 

data(sleep)
head(sleep)

library(ggplot2)
g <- ggplot(sleep, aes(x = group, y = extra, group = factor(ID)))
g <- g + geom_line(size = 1, aes(colour = ID)) + 
        geom_point(size =10, pch = 21, fill = "salmon", alpha = .5)
g

g1 <- sleep$extra[1:10];g2<- sleep$extra[11:20]
diff <- g2-g1
mn <- mean(diff); s <- sd(diff); n <- 10
t.test(diff)
t.test(g2,g1,paired = TRUE)

# t test for independent group


n1 <- length(g1); n2 <- length(g2)




# pooled variance

sp <- sqrt(( (n1-1)*sd(g1)^2 +(n2-1)*sd(g2)^2 )/ (n1+n2-2))
sp
md <- mean(g2)-mean(g1)
semd <- sp*sqrt(1/n1+1/n2)
rbind(
        md+c(-1,1)*qt(.0975, n1+n2-2)*semd,
        t.test(g2,g1,paired = FALSE, var.equal = TRUE)$conf,
        t.test(g2,g1,paired = TRUE)$conf
        
        )



library(datasets); data(ChickWeight);
library(reshape2)
head(ChickWeight)
length(levels(ChickWeight$Chick))
str(ChickWeight)
## defiend wight gain or loss

wideCW <- dcast(ChickWeight, Diet + Chick ~ Time, value.var = "weight")
head(wideCW)
names(wideCW)[-(1 : 2)] <- paste("time", names(wideCW)[-(1 : 2)], sep = "")

library(dplyr)
wideCW <- mutate(wideCW,
                 gain = time21 - time0
)
head(wideCW)

library(ggplot2)
g <- ggplot(ChickWeight, aes(x = Time, y = weight, 
                             colour = Diet, group = Chick))+ 
        geom_line()+ 
        stat_summary(aes(group = 1), geom = "line", fun.y = mean, size = 1, col = "black")+ 
        facet_grid(. ~ Diet)
g

g <- ggplot(wideCW, aes(x = factor(Diet), y = gain, fill = factor(Diet)))
g <- g + geom_violin(col = "black", size = 2)
g

wideCW14 <- subset(wideCW, Diet %in% c(1, 4))
rbind(
        t.test(gain ~ Diet, paired = FALSE, var.equal = TRUE, data = wideCW14)$conf,
        t.test(gain ~ Diet, paired = FALSE, var.equal = FALSE, data = wideCW14)$conf
)


library(UsingR);data(father.son)
t.test(father.son$sheight, father.son$fheight, paired=TRUE)



choose(8,7) *0.5^8+choose(8,8) *0.5^8
pbinom(6, size=8,prob=0.5,lower.tail = FALSE)

# 10 or more people get infection
ppois(9,5, lower.tail = FALSE) # p-value





