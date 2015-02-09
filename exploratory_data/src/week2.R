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
qplot(displ, hwy, data=mpg, facets= .~drv, geom = c("point","smooth"), method="lm")
qplot(hwy,data=mpg,facets=drv~.,binwidth=2)



# plot the data
# overlay a summary
# 

g<- ggplot(mpg, aes(displ, hwy))

g+ geom_point()+geom_smooth()

g+ geom_point()+geom_smooth(method="lm")



g+facet_grid(.~drv)+geom_point(color = "steelblue", size=4, alpha=0.5)+geom_smooth(size=2,linetype=1,method="lm")

g+geom_point(aes(color =drv), size=4, alpha=0.5)+geom_smooth(size=2,linetype=1,method="lm")+ theme_bw(base_family = "Times")


# outlier

testdat <- data.frame(x=1:100, y=rnorm(100))
testdat[50,2] <- 100 # outlier
plot(testdat$x, testdat$y, type="l", ylim=c(-3,3))

g <- ggplot(testdat, aes(x=x,y=y))
g+ geom_line()+ ylim(-3,3)

g+ geom_line()+ coord_cartesian(ylim=c(-3,3))



# categorize the continuous variable 
# calculate the deciles of the data
str(mpg)

cutpoint <- quantile(mpg$displ, seq(0,1,length=4),na.rm = TRUE)

# cut the data at the deciles and crate a new factor varible

mpg$displ2dec <- cut(mpg$displ, cutpoint)
levels(mpg$displ2dec)

g<- ggplot(mpg, aes(displ, hwy))
g + geom_point() +facet_wrap(fl~class, nrow=7, ncol=5)+ geom_smooth(method="lm", se=FALSE, col="steelblue")+ theme_bw(base_family = "Avenir", base_size = 10)

  






