
# Loop function -----------------------------------------------------------

# lapply: loop over a list 
# sapply 
# apply
# tapply
# mapply
# split


# lapply always return a list
str(lapply)

x <- list(a=1:5, b=rnorm(10))
lapply(x,mean)

x <-1:4
lapply(x,runif)
args(runif)
lapply(x, runif, min=0, max=10)

x <- list(a=matrix(1:4,2,2),b=matrix(1:6,3,2))
# anonymous function 
lapply(x,function(elt) elt[,1])

x <- list(a=1:5, b=rnorm(10))
sapply(x, mean)


# apply over the margins of an array

# MarGin is an integer verctor indicating which margins should be retained

str(apply)

x <- matrix(rnorm(200),20,10)

# mean of each column 
apply(x,2,mean)
apply(x,1,sum)

apply(x, 1, quantile,probs=c(0.25,0.75))

a <- array(rnorm(2*2*10), c(2,2,10))
apply(a, c(1,2),mean)
rowMeans(a, dim=2)

# mapply is a multivariate apply of sort which applies a function in parallel over a set of arguments

str(mapply)

list (rep(1,4), rep(2,3), rep(3,2),rep(4,1))
mapply(rep,1:4,4:1)

noise <- function(n,mean,sd) {
        rnorm(n,mean,sd)
}

noise(5,1,2)
noise(1:5,1:5,2)
mapply(noise, 1:5,1:5,2)

# tapply: apply to vectors

str(tapply)
x <- c(rnorm(10), runif(10), rnorm(10,1))
x
f <- gl(3,10)
tapply(x, f, mean)
tapply(x, f, mean, simplify = FALSE)
tapply(x,f,range)

# split 
str(split)
# f: factor

x <- c(rnorm(10), runif(10), rnorm(10,1))
x
f <- gl(3,10)
split(x, f)
library(datasets)
head(airquality)

s <- split(airquality, airquality$Month)
lapply(s, function(x) columnmean(x[,c("Ozone","Solar.R","Wind")]))
sapply(s, function(x) columnmean(x[,c("Ozone","Solar.R","Wind")]))

# splitting on more than one level

x <- rnorm(10)
x
f1 <- gl(2,5)
f2 <- gl(5,2)
f1
f2
interaction(f1,f2)
split(x,list(f1,f2))

# warning
log(-1)

printmessage <- function(x) {
        
        if (x>0)
                print("x is greater than zero")
        else 
                print("x is less than or equal to zero")
        # still return but not print in the console 
        invisible(x)
        
}

printmessage(3)

printmessage(NA)

printmessage2 <- function(x) {
        
        if (is.na(x)) 
                print("x is missing value")
        else if (x>0)
                print("x is greater than zero")
        else 
                print("x is less than or equal to zero")
        # still return but not print in the console 
        invisible(x)
        
}

printmessage2(NA)

# debugging tools in R 

# traceback, debug, browser, trace, trace, recover, 
mean(z)
traceback()

lm(y~x)
traceback()

debug(lm)
lm(y~x)











