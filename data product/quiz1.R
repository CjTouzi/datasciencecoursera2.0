

# Q1 ----------------------------------------------------------------------


library(manipulate)
myPlot <- function(s) {
        plot(cars$dist - mean(cars$dist), cars$speed - mean(cars$speed))
        abline(0, s)
}

myPlot(1)

manipulate(myPlot(s), s = slider(0, 2, step = 0.1))



# Q2 ----------------------------------------------------------------------

library(rCharts)

dTable(airquality, sPaginationType = "full_numbers")



# Q4 ----------------------------------------------------------------------

dir.create("./quiz1-Q4")



# Q5 ----------------------------------------------------------------------

dir.create("./quiz1-Q5")


