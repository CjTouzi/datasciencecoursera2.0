require(rCharts)
require(shiny)
require(data.table)

runApp(list(
        port=5555,
        # Ui ------------------------------------------------------------------  
        ui =  fluidPage( 
                fluidRow(
                        column(4,
                               helpText("Select a stock to examine. 
                                Information will be collected from yahoo finance."),
                               
                               textInput("symb", "Symbol", "SPY"),
                               
                               dateRangeInput("dates", 
                                              "Date range",
                                              start = "2013-01-01", 
                                              end = as.character(Sys.Date())),
                               
                               actionButton("get", "Get Stock"),
                               
                               br(),
                               br()),
                        
                        column(4,
                               h3("Help text"),
                               showOutput("chart4", "Highcharts")),
                        
                        column(4, 
                               h3("Help text"),
                               showOutput("chart4", "Highcharts"))),
                
                fluidRow(
                        
                        column(4,
                               radioButtons("radio", label = h3("Radio buttons"),
                                            choices = list("Choice 1" = 1, "Choice 2" = 2,
                                                           "Choice 3" = 3),selected = 1)),
                        
                        column(4,
                               h3("Help text"),
                               showOutput("chart4", "Highcharts")),
                        
                        column(4, 
                               h3("Help text"),
                               showOutput("chart2", "Highcharts")))
                
        ),
 # Server ------------------------------------------------------------------  
 
        server = function(input, output){
                
                output$chart3 <- renderChart({
                        a <- hPlot(Pulse ~ Height, data = MASS::survey, type = "bubble", title = "Zoom demo", subtitle = "bubble chart", size = "Age", group = "Exer")
                        a$chart(zoomType = "xy")
                        a$chart(backgroundColor = NULL)
                        a$set(dom = 'chart3')
                        return(a)
                })
                
                output$chart2 <- renderChart({
                        survey <- as.data.table(MASS::survey)
                        freq <- survey[ , .N, by = c('Sex', 'Smoke')]
                        a <- hPlot(x = 'Smoke', y = 'N', data = freq, type = 'column', group = 'Sex')
                        a$chart(backgroundColor = NULL)
                        a$set(dom = 'chart2')
                        return(a)
                })
                
                output$chart4 <- renderChart({
                        survey <- as.data.table(MASS::survey)
                        freq <- survey[ , .N, by = c('Smoke')]
                        a <- hPlot(x = "Smoke", y = "N", data = freq, type = "pie")
                        a$plotOptions(pie = list(size = 150))
                        a$chart(backgroundColor = NULL)
                        a$set(dom = 'chart4')
                        return(a)
                })
                
        }
))



