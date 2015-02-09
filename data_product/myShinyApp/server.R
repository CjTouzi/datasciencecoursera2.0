# server.R

library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {

      output$plot <- renderPlot({
          
         data <- getSymbols(input$symb, src = "yahoo", 
          from = input$dates[1],
          to = input$dates[2],
          auto.assign = FALSE)
                     
#         ret <- getSymbols("COKE", src='yahoo'
#                           ,index.class=c("POSIXt","POSIXct"), from='1990-01-01')
#         x <- get(ret)
#         par(mfrow=c(1,2))
#         plot(x)
#         plot(x)
            
            mx <- to.monthly(data)
            xopen <- Op(mx)
            ts1 <- ts(xopen,frequency=12)
            deco <- decompose(ts1)

            par(mfrow=c(2,2))
            plot(deco$x)
            plot(deco$trend)
            plot(deco$seasonal)
            plot(deco$random)
#         chartSeries(data, theme = chartTheme("white"), 
#           type = "line", log.scale = input$log, TA = NULL)
    
    
    })

})
