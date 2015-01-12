library(ggplot2)

lambda <-0.2 
n<-1000 # Number of simulations simulations
m<-40 # Number of  exponentials.

# therotical values of sd and mean

tsd <- 1/lambda
tmn <- 1/lambda


# mean of simulation 
set.seed(1000)
mn.sample=NULL
for (i in 1:n) mn.sample=c(mn.sample, mean(rexp(m,lambda))) 
mn.sample <- data.frame(mn.sample)


mns <- mean(mn.sample$mn.sample)
# theoretical mean

mn.theo
sd(mn.sample$mn.sample)


g <- ggplot(mn.sample, aes(x=mn.sample)) + 
        geom_histogram(binwidth=.1, colour="black", fill="white")+
        ggtitle("Sample Mean versus Theoretical Mean")+
        theme(plot.title = element_text(lineheight=.8, face="bold"))+
        xlab("")+
        ylab("Count")+
        xlim(2,8)



g+ geom_vline(aes(xintercept=mns),color="red", linetype="dashed", size=1)+
        annotate("text", x = 6, y = 70, label = paste("sample mean:", as.character(round(mns,2))), 
                 color="red")+
        geom_vline(aes(xintercept=mn.theo),color="blue", linetype="dashed", size=1)+
        annotate("text", x = 6, y = 75, label = paste("theoretical mean:", 
                                                       as.character(round(mn.theo,2))), color="blue")




# histom of variance
var.sample=NULL
set.seed(1000)
for (i in 1:n) var.sample=c(var.sample, var(rexp(m,lambda))) 
var.sample<- data.frame(var.sample)

mn.var <- mean(var.sample$var.sample)

mn.var 
sd(var.sample$var.sample)

var.theo=1/lambda^2


var.theo
sd.theo/sqrt(m)


g <- ggplot(var.sample, aes(x=var.sample)) + 
        geom_histogram(binwidth=1, colour="black", fill="white")+
        ggtitle("Sample Variance versus Theoretical Variance")+
        theme(plot.title = element_text(lineheight=.8, face="bold"))+
        xlab("")+
        ylab("Count")+
        xlim(0,60)
g


g+ geom_vline(aes(xintercept=mn.var),color="red", linetype="dashed", size=1)+
        annotate("text", x = 40, y = 40, label = paste("sample variance:", as.character(round(mn.var ,2))), 
                 color="red")+
        geom_vline(aes(xintercept=var.theo),color="blue", linetype="dashed", size=1)+
        annotate("text", x = 40, y = 45, label = paste("theoretical variance:", 
                                                      as.character(round(var.theo,2))), color="blue")


# comparison with normal distribution

nor.mn.sample <- data.frame((mn.sample$mn.sample- mn.theo)/sd.theo)
names(nor.mn.sample) <- "Nornalized.sample.mean"



nor.var.sample <- data.frame((var.sample$var.sample-var.theo)/sd.theo)
names(nor.var.sample) <- "Nornalized.sample.variance"


require(gridExtra)
plot1 <- ggplot(nor.mn.sample, aes(x=Nornalized.sample.mean))+ 
        geom_histogram(aes(y=..density..), binwidth=0.02, colour="black", fill="white")
        ggtitle("Sample Variance versus Theoretical Variance")+
        theme(plot.title = element_text(lineheight=.8, face="bold"))+
        xlab("")+
        ylab("Count")+
        xlim(-1,1)+
        stat_function(fun = dnorm, size = 2)
plot1+stat_function(fun = dnorm, size = 1)

xfit<-seq(-3,3,length=100) 
norm<-dnorm(xfit,mean=0,sd=1) 
lines(xfit, norm, col="blue", lwd=2)

g2 <- ggplot(nor.mn.sample, aes(x=Nornalized.sample.mean))+ 
        geom_histogram(binwidth=0.02, colour="black", fill="white")+
        ggtitle("Sample Variance versus Theoretical Variance")+
        theme(plot.title = element_text(lineheight=.8, face="bold"))+
        xlab("")+
        ylab("Count")+
        xlim(-1,1)
plot2 <- qplot(1)
grid.arrange(plot1, plot2, ncol=2)



g <- 
g <- g + stat_function(fun = dnorm, size = 2)
g + facet_grid(. ~ size)

