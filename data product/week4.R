library(methods)
setClass("polygon", representation(x="numeric", y="numeric"))

setMethod("plot", "polygon",
          function(x, y, ...) {
              plot(x@x, x@y, type = "n", ...)
              xp <- c(x@x, x@x[1])
              yp <- c(x@y, x@y[1])
              lines(xp, yp)
          })

library(methods)
showMethods("plot")
p <- new("polygon", x = c(1, 2, 3, 4), y = c(1, 2, 3, 1))
plot(p)
