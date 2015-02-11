library(shiny)
library(rCharts)

runApp(list(
    ui = fluidPage(downloadButton('foo')),
    server = function(input, output) {
        
        plotInput = function(file) {
            # qplot(speed, dist, data = cars)
            a <- hPlot(Pulse ~ Height, data = MASS::survey, type = "bubble", 
                       title = "Zoom demo", 
                       subtitle = "bubble chart", 
                       size = "Age", group = "Exer")
            a$chart(zoomType = "xy")
            a$chart(backgroundColor = NULL)
            a$set(dom = 'chart3')
            a$save(file, standalone = TRUE)
            
        }
        output$foo = downloadHandler(
            
            filename = 'test.html',
            content = function(file) {
                plotInput(file)
               
   
            })
    }
))