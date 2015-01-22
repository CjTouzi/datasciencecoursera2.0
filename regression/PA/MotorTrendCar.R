# loadi in the mtcars dataset
data(mtcars)

# transfor certain variables into factors.
fl <- c("cyl", "vs", "gear", "carb", "am")
mtcars[,fl] <- lapply(fl, function(fl) {factor(mtcars[,fl])})
# add brand column 
mtcars$brand <- make.names(rownames(mtcars))
mtcars$gpm <- 1/mtcars$mpg
str(mtcars)
gpmwt <- lm(gpm ~ wt, data = mtcars); gpmwt



# Exploratory Analysis
# panel.smooth function is built in.
# panel.cor puts correlation in upper panels, size proportional to correlation
source("./PA/panelCor.R")

pairs(mpg ~ ., data = mtcars,lower.panel=panel.smooth, upper.panel=panel.cor)


? mtcars
# 
gpmwt <- lm(gpm ~ wt, data = mtcars)

initialmodel <- lm(mpg ~ ., data = mtcars)
bestmodel <- step(initialmodel, direction = "both")
bestmodel$coefficients
make.names(rownames(mtcars))

