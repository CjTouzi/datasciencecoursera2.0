x <- vector("numeric", length= 10)
as.logical(x)
as.character(x)
x >- c("a","b","c")
as.character(x)

m <- matrix(nrow=2, ncol=3)
dim(m)
attributes(m)

m <- 1:10 
dim(m) <- c(2,5)
m

x<- 1:3
y<-10:12
cbind(x,y)

x <- list(1, "a",TRUE, 1+4i)
x

x <- factor(c("yes","yes","no","yes"))
x
table(x)
unclass(x)

x <- factor(c("yes","yes","no","yes"), levels=c("yes","no"))
x
x <- c(1,2, NA, 10, 3)
is.na(x)
is.nan(x)

x <- data.frame(foo=1:4, bar =c(T,T,F,F))
x
nrow(x)
ncol(x)

x <- 1:3
names(x)
names(x) <- c("foo","bar","norf")
names(x)


x <- lis(a=1, b=2, c=3)
x
m <- matrix(1:4, nrow=2, ncol=2)
dimnames(m) <- list(c("a","b"),c("c","d"))
m

x <- matrix(1:6,2,3)
x[1,2]
x[2,1]
x[1,]

x[1,2,drop=FALSE]

x <- list(foo=1:4, bar=0.6)
x[1]
x[[1]]
x$bar
x[["bar"]]
x["bar"]
x <- list(a=list(10,12,14),b=c(3.14,.81))
x[[c(1,3)]]

x <- list(aardvark=1:5)
x$a
x[["a"]]
x[["a",exact=FALSE]]

x <- c(1,2,NA,4,NA,5)
bad <- is.na(x)
x[!bad]

y <- c("a", "b",NA,"d",NA,"f")
good <- complete.cases(x,y)
good
x[good]
y[good]

airquality[1:6,]
good <- complete.cases(airquality)
airquality[good,][1:6,]

x <-1:4; y<-6:9
x+y
x>2
x>=2
y==8
x*y
x/y

x <- matrix(1:4,2,2); y<-matrix(rep(1,4),2,2)
x*y
x/y
x %*% y

y <- data.frame(a=1, b="a")
dput(y)
dput(y, file = "y.R")
new.y <- dget("y.R")
new.y

x <- "foo"
y <- data.frame(a=1. b="a")
dump(c("x", "y"), file= "xy.R")
rm(x,y)
source("xy.R")
y
x

str(file)

con <- file("src/foo.txt", "r")
data <- read.csv(con)
close(con)


df1 <- data.frame(id = seq(1,10,1), var1 = runif(10), var2 = runif(10))
gz1 <- gzfile("df1.gz", "w")
write.csv(df1, gz1)
close(gz1)

con <- gzfile("df1.gz")
x <- readLines(con, 3)
x
close(con)

con <- url("http://www.jhsph.edu","r")
x <- readLines(con)
head(x)

