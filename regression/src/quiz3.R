
# Q1 ----------------------------------------------------------------------

data(mtcars)
?mtcars
str(mtcars)

mtcars$cyl <- factor(mtcars$cyl)
str(mtcars)

# adjusted
fit <- lm(mpg ~ cyl+wt, data=mtcars)
fit

# unadjusted
fit1 <- lm(mpg ~cyl,data=mtcars)
fit1

# coefficient of c18


# Q2 ----------------------------------------------------------------------

# adjusted
fit <- lm(mpg ~ cyl+wt, data=mtcars)
fit

# unadjusted
fit1 <- lm(mpg ~cyl,data=mtcars)
fit1

# Q3 ----------------------------------------------------------------------
# adjusted
fit <- lm(mpg ~ cyl+wt, data=mtcars)
fit
# interaction
fit2 <- lm(mpg ~ cyl+wt +cyl*wt, data=mtcars)
fit2
summary(fit2)


# Q4 ----------------------------------------------------------------------

fit3 <- lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)



# Q5 ----------------------------------------------------------------------

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

fit5 <- lm(y~x)

hatvalues(fit5)


# Q6 ----------------------------------------------------------------------

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
fit5 <- lm(y~x)
hatvalues(fit5)
dfbetas(fit5)
