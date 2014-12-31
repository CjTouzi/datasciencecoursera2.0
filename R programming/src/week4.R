str(str)
str(lm)
str(airquality)
f <- gl(40,10)
str(f)
s <- split(airquality, airquality$Month)
str(s)


# simulation --------------------------------------------------------------
# d for density,
# r for random number
# q for quantile
# p for cumulative 

x <- rnorm(10)
x
x <- rnorm(10,20,2)
x
set.seed(1)
rnorm(5)

rpois(10,1)

rpois(10,2)

ppois(2,2) # pr(x<=2) 
ppois(4,2) # pr(x<=4) 

set.seed(20)
x <- rnorm(100)
e <- rnorm(100,0,2)
y <- 0.5+2*x +e
plot(x,y)

set.seed(10)
x <- rbinom(100,1,0.5)
e <- rnorm(100,0,2)
y <- 0.5+2*x +e
summary(y)
plot(x,y)



# Possion -----------------------------------------------------------------

set.seed(1)
x <- rnorm(100)
log.mu <- 0.5+0.3*x
y<- rpois(100, exp(log.mu))
summary(y)
plot(x,y)


# Random Sampling ---------------------------------------------------------

set.seed(1)
sample(1:10,4)
sample(letters,5)
sample(1:10) # perputation

sample(1:10, replace=TRUE)

# R profiler --------------------------------------------------------------

# system.time, user time: CPU time, elapsed time- human time

system.time(readLines("http://www.jhsph.edu"))

hilert <- function(n){
        
        i<-1:n
        1/outer(i-1,i,"+")
}

x <- hilert(1000)
system.time(svd(x))

# Rprof()

# by.total
# by.self
# sample.interval 
# sampling.time










