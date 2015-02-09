# this apps uses times series decomposition as the stock entry position

library(quantmod)

from.dat <- as.Date("01/01/08", format="%m/%d/%y")
to.dat <- as.Date("12/31/13", format="%m/%d/%y")
stock_name <- "GOOG"
ret <- getSymbols("COKE", src='yahoo', index.class=c("POSIXt","POSIXct"), from='1990-01-01')
x <- get(ret)
plot(x)

mx <- to.monthly(x)
xopen <- Op(mx)
ts1 <- ts(xopen,frequency=12)
plot(ts1,xlab="Years+1", ylab="GOOG")
deco <- decompose(ts1)
summary(deco$seasonal)
entry <- quantile(deco$seasonal, c(0.95, 0.05))

par(mfrow=c(1,2))

plot(deco$seasonal)
abline(h=entry, col="red")


plot(decompose(ts1),xlab="Years+1")




