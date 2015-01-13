lambda <-0.2 
n<-1000 # Number of simulations simulations
m<-40 # Number of  exponentials.



exp.means <- function(ne,ns,lambda,seed){
        
        set.seed(seed)
        mns=NULL
        for (i in 1:ns) mns=c(mns, mean(rexp(ne,lambda))) 
        data.frame(mns)
        
        
} 


exps <- function(ne,ns,lambda,seed, FUN=mean){
        
        set.seed(seed)
        mns=NULL
        for (i in 1:ns) mns=c(mns, FUN(rexp(ne,lambda))) 
        data.frame(mns)
        
        
} 
mns <- exps(40,1000,lambda, 1000, mean)

class(mns)
mns <- exp.means(40,1000,lambda, 1000)

library(ggplot2)

g <- ggplot(mns, aes(x=mns)) 

myhist<- function(g, bw,title) {        
        hist <- g+ geom_histogram(binwidth=bw, colour="black", fill="white")+
                ggtitle(title)+
                theme(plot.title = element_text(lineheight=.8, face="bold"))+
                xlab("")+
                ylab("Count")
        hist 
}

myhist(g,0.1, title="Histgram")



}