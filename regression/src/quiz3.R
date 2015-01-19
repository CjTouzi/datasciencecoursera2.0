
# Q1 ----------------------------------------------------------------------

data(mtcars)
?mtcars
str(mtcars)

mtcars$cyl <- factor(mtcars$cyl)
str(mtcars)

fit <- lm(mpg ~ cyl+wt, data=mtcars)
fit1 <- lm(mpg ~cyl,data=mtcars)
fit1
fit
# coefficient of c18


# Q2 ----------------------------------------------------------------------

fit <- lm(mpg ~ cyl+wt, data=mtcars)
fit1 <- lm(mpg ~cyl,data=mtcars)
fit1
fit
