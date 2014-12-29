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
