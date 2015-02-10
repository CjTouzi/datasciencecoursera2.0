# this apps uses times series decomposition as the stock entry position

library(quantmod)


ret <- getSymbols("COKE", src='yahoo', index.class=c("POSIXt","POSIXct"), from='1990-01-01')
x <- get(ret)

# change to monthly data
mx <- to.monthly(x)

# monthly time serious open price 
ts1 <- ts(Op(mx),frequency = 12)

# decompose monthly open price
deco <- decompose(ts1)


# use rchart to plot 
library(rCharts)

class(as.Date(index(mx),format= "%m %y"))
class(index(mx))
df <- data.frame(date=format(index(mx),"%Y-%m"), 
                 data=deco$seasonal)

par(mfrow=c(1,2))

h1 <- hPlot(
        x = "date", 
        y = "data", 
        data = df, 
        type = "line")

h1$xAxis(
        type = "addTimeAxis",
        inputFormat = "%Y-%m",
        outputFormat = "%Y-%m"
)
h1




summary(deco$seasonal)
entry <- quantile(deco$seasonal, c(0.95, 0.05))

par(mfrow=c(1,2))

plot(deco$seasonal)
abline(h=entry, col="red")
deco <- decompose(ts1)

plot(decompose(ts1),xlab="Years+1")








library(rCharts)
h <- Highcharts$new()
h$xAxis(categories = c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
h$yAxis(list(list(title = list(text = 'Rainfall'))
             , list(title = list(text = 'Temperature'), opposite = TRUE)
             , list(title = list(text = 'Sea Pressure'), opposite = TRUE))
)
h$series(name = 'Rainfall', type = 'column', color = '#4572A7',
         data = c(49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4))
h$series(name = 'Temperature', type = 'spline', color = '#89A54E',
         data = c(7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6),
         yAxis = 1)

h$series(name = 'Sea-Level Pressure', type = 'spline', color = '#AA4643',
         data = c(1016, 1016, 1015.9, 1015.5, 1012.3, 1009.5, 1009.6, 1010.2, 1013.1, 1016.9, 1018.2, 1016.7),
         yAxis = 2)
h

