x <- c("a","b","c","d")

for(i in seq_along(x)){
        
        print(x[i])
        
}

for (letter in x){
        
        print(letter)
}

for (i in 1:4){
        print(x[i])
}


x <- matrix(1:6, 2,3)

count <- 0 

while (count<10){
        print(count)
        count <- count+1
}

z <- 5

while (z>=3 && z<=10){        
        print(z)
        coin <- rbinom(1,1,0.5)
        if (coin ==1) { ## random walk 
                z <- z+1
                
        } else {
                z <- z-1
        }
  
}

for (i in 1:100){
        
        if (i<=20){
                
                next
        }
        
        print(i)
        
}


for (i in 1:100){
        
        if (i>20){
                
                return (i)
        }
               
}
print(i)

add2 <- function(x, y) {
        x+y
}

above10 <- function (x){
        use <- x >10 
        x[use]
        
}

above <- function (x, n=10){
        use <- x >n
        x[use]
}

columnmean <- function(y, removeNA =TRUE) {
        nc <- ncol(y)
        means <- numeric(nc)
        for (i in 1:nc) {
                
                means[i] <- mean(y[,i], na.rm = removeNA)
                
        }
        means
}

mydata <- rnorm(100)

sd(mydata)
sd(x=mydata)
args(lm)

f <- function(a, b=1, c=2, d=NULL){
     
}

f <- function(a, b){
        
        a^2
}

f(2)

# lazy evaluation
f <- function(a, b){
        
        print(a)
        print(b)
}

f(45)

# the "..." argument
myplot <- function(x, y, type="l",...){
        
        plot(x,y,type=type,...)
}

args(paste)
args(cat)
paste("a","b",sep=":")
paste("a","b",se=":")

lm <- function(x) {x*x}
search()
library(dplyr)
search()


# # lexical scopting  -----------------------------------------------------



# the values of free variable are searched 
# for in the environment in which the function was defined 

# - a function + an enviroument = funciton closure

f <- function(x,y){
        x^2+y/z
}

make.power <- function(n){
        
        pow <- function(x) {
                # n is defined in the environment
                x^n
        }
        pow
        
}

cube <- make.power(3)
square <- make.power(2)
cube(3)
square(3)
ls (environment(cube))
get("n", environment(cube))

#  negtive log like hood objective funciton 
make.NegLogLik <- function(data, fixed= c(FALSE,FALSE)) {
        
        params <- fixed
        function(p) {
                
                params[!fixed] <- p 
                # mean
                mu <- params[1]
                # sd
                sigma <- params[2]
                a <- -0.5* length(data) *log(2*pi*sigma^2)
                b <- -0.5*sum((data-mu)^2/sigma^2)
                -(a+b)
                
                
        }
        
}

set.seed(1); normals <- rnorm(100,1,2)
nLL <- make.NegLogLik(normals)
nLL
ls(environment(nLL))

optim(c(mu=0, sigma=1),nLL)$par

# fixing sigma=2 

nLL <- make.NegLogLik(normals, c(FALSE,2))
optimize(nLL, c(-1,3))$minimum
str(optimize)

# fixing mu=2 

nLL <- make.NegLogLik(normals, c(1,FALSE))
optimize(nLL, c(1e-6,10))$minimum
str(optimize)



x <- seq(1.7, 1.9, len=100)
y <- sapply(x,nLL)
plot(x, exp(-(y-min(y))), type="l")



# date class --------------------------------------------------------------------

x <- as.Date("1970-01-01")
x
unclass(x)

weekdays(x)
months(x)
quarters(x)


x <- Sys.time()
x


# POSIXlt
p <- as.POSIXlt(x)
names(unclass(p))
p$sec
p$mday


# POSIXct
c <- as.POSIXct(x)
x
unclass(x)
datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
y <- Sys.time()
x-y


