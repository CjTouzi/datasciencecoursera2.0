# this apps uses times series decomposition as the stock entry position

library(quantmod)

fromDate <- '2005-01-01'
endDate <- '2014-04-12'
symbol <- "STI"


ret <- getSymbols(symbol, src='yahoo', 
                  index.class=c("POSIXt","POSIXct"), 
                  from=fromDate, to=endDate)

x <- to.monthly(get(ret))


# weekly time serious open price 
ts1 <- ts(Op(x),frequency = 12)



# decompose monthly open price
#seasonality assumed multiplicative 
deco <- decompose(ts1, filter = NULL)


library(manipulate)

myPlot <-function(v1){
        par(mfrow=c(4,1))
        plot(deco$x)
        abline(v=v1, col="blue")
        plot(deco$trend)
        abline(v=v1, col="blue")
        plot(deco$seasonal)
        abline(v=v1, col="blue")
        plot(deco$random)
        abline(v=v1, col="blue")
        
}

manipulate(
        myPlot(v1),
        v1=slider(0,5,step=0.1))




df <- data.frame(date=index(wx), 
                 data=deco$seasonal)

class(index(wx))

h1 <- hPlot(
        x = "date", 
        y = "data", 
        data = df, 
        type = "scatter")

h1$xAxis(
        type = "addTimeAxis",
        inputFormat = "%Y-%m-%d",
        outputFormat = "%Y-%m-%d"
)
h1





# plot(Re(fft(deco$seasonal))^2)
# 
# plot(ts1/deco$seasonal)
# 
# # use rchart to plot 
# library(rCharts)
# 
# # nomalize seasonal signal
# 
# normalize <- function(vec) {
#         
#         (vec-mean(vec))/(max(vec)-min(vec))
#         
#         
# }
# 
# 
# myplot1 <- function(vl){
#         
#         
#         
#         
# }
# 
# 
# deco$seasonal_nor <- normalize(deco$seasonal)
# 
# 
# df <- data.frame(date=index(wx), 
#                  data=deco$seasonal_nor)
# 
# class(index(wx))
# 
# h1 <- hPlot(
#         x = "date", 
#         y = "data", 
#         data = df, 
#         type = "scatter")
# 
# h1$xAxis(
#         type = "addTimeAxis",
#         inputFormat = "%Y-%m-%d",
#         outputFormat = "%Y-%m-%d"
# )
# h1
# 
# 
