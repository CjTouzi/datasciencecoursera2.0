require(rCharts)
library(shiny)
require(data.table)
require(rNVD3)

runApp(list(        
        ui= fluidPage(titlePanel("Interactive Charts"),                
                sidebarLayout(  
                        sidebarPanel(),
                        mainPanel(tabsetPanel(
                                        tabPanel("Examples", 
                                                 
                                           fluidRow(column(6, 
                                                           showOutput("column", "Highcharts")
                                                           ),
                                                    column(6, 
                                                           helpText("hi")
                                                           )), 
                                           fluidRow(column(6, 
                                                           helpText("hi")
                                                           ),
                                                    column(6, 
                                                           helpText("hi")
                                                           ))
                                                 ),
                                        tabPanel("Column",verbatimTextOutput("Line")), 
                                        tabPanel("Line", verbatimTextOutput("Line")), 
                                        tabPanel("Pie", verbatimTextOutput("Pie")), 
                                        tabPanel("Bar", verbatimTextOutput("Bar")), 
                                        tabPanel("Table", tableOutput("table"))
                                )
                        )
                )
        ),
        server = function(input, output){  
                
                
                output$bubble <- renderChart({
                        a <- hPlot(Pulse ~ Height, data = MASS::survey, type = "bubble", title = "Zoom demo", subtitle = "bubble chart", size = "Age", group = "Exer")
                        a$chart(zoomType = "xy")
                        a$chart(backgroundColor = NULL)
                        a$set(dom = 'bubble')
                        return(a)
                })
                
                output$column <- renderChart({
                        
                        survey <- as.data.table(MASS::survey)
                        freq <- survey[ , .N, by = c('Sex', 'Smoke')]
                        a <- hPlot(x = 'Smoke', y = 'N', data = freq, type = 'column', group = 'Sex')
                        a$chart(backgroundColor = NULL)
                        a$set(dom = 'column')
                        return(a)
                })
                
                output$pie <- renderChart({
                        survey <- as.data.table(MASS::survey)
                        freq <- survey[ , .N, by = c('Smoke')]
                        a <- hPlot(x = "Smoke", y = "N", data = freq, type = "pie")
                        a$plotOptions(pie = list(size = 150))
                        a$chart(backgroundColor = NULL)
                        a$set(dom = 'pie')
                        return(a)
                })
                output$scatter <- renderChart({                        
                        a <- Highcharts$new()
                        a$chart(type = "spline", backgroundColor = NULL)
                        a$series(data = c(1, 3, 2, 4, 5, 4, 6, 2, 3, 5, NA), dashStyle = "longdash")
                        a$series(data = c(NA, 4, 1, 3, 4, 2, 9, 1, 2, 3, 1), dashStyle = "shortdot")
                        a$legend(symbolWidth = 80)
                        a
                })
                
                
                
        }

))