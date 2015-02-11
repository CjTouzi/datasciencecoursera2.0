library(shiny)
library(ggplot2)
runApp(list(
    ui = fluidPage(downloadButton('foo')),
    server = function(input, output) {
        plotInput = function() {
            qplot(speed, dist, data = cars)
        }
        output$foo = downloadHandler(
            filename = 'test.png',
            content = function(file) {
                device <- function(..., width, height) {
                    grDevices::png(..., width = width, height = height,
                                   res = 300, units = "in")
                }
                ggsave(file, plot = plotInput(), device = device)
                
               
            })
    }
))