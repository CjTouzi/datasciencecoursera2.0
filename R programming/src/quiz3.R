library(datasets)
data(iris)
?iris
head(iris)
dim(iris)

sapply(iris[iris$Species=="virginica",1:4],mean)
names(iris)

? mtcars
names(mtcars)
head(mtcars)
with(mtcars, tapply(mpg, cyl, mean))
tapply(mtcars$mpg,mtcars$cyl, mean)
x <- with(mtcars, tapply(hp, cyl, mean))
x[[3]]-x[[1]]
debug(ls)
ls
