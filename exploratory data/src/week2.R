# xyplot(y~x| f*g, data)

library(lattice)
xyplot(Ozone~Wind,data=airquality )

airquality<-transform(airquality, Month=factor(Month))
xyplot(Ozone ~ Wind | Month, data=airquality, layout=c(5,1))

p <- xyplot(Ozone~Wind,data=airquality )
print(p)


set.seed(10)
x <- rnorm(100)
f <- rep(0:1,each=50)
f
y<- x+f- f*x +rnorm(100, sd=0.5)
f <- factor(f, labels =c ("Group 1", "Group2"))
xyplot(y~x | f, layout=c(1,2))

xyplot(y~x | f, panel =function(x,y,...){
        panel.xyplot(x,y,...)
        panel.abline(h=median(y),lty=2)
})

xyplot(y~x | f, panel =function(x,y,...){
        panel.xyplot(x,y,...)
        panel.lmline(x,y,col=2)
})


# ggplot2 
library(ggplot2)
str(mpg)
qplot(displ, hwy, data=mpg)

# use different color for drv variables
qplot(displ, hwy, data=mpg,color=drv)
qplot(displ, hwy, data=mpg,geom=c("point", "smooth"))

qplot(hwy,data=mpg,fill=drv)
qplot(displ, hwy, data=mpg, facets= .~drv)
qplot(hwy,data=mpg,facets=drv~.,binwidth=2)

str(maacs)











