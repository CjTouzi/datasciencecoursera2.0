
##  this is a template of the shiny app


require(rCharts)
require(shiny)
require(data.table)
runApp(list(
        ui = fluidPage(
                
                titlePanel("Basic widgets"),
   
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
                               br(),
                               
                               checkboxInput("log", "Plot y axis on log scale", 
                                             value = FALSE),
                               
                               checkboxInput("adjust", 
                                             "Adjust prices for inflation", value = FALSE)),
                        
                        column(4, 
                               h3("Help text"),
                               showOutput("chart1", "Highcharts")
                        ),
                        
                        column(4, 
                               h3("Help text"),
                               showOutput("chart2", "Highcharts")
                        )
                        
                ),
                
                fluidRow(
                        
                        column(4,
                               h3("Spend 5 minutes"),
                               # insert Youtube
                               tags$embed(src="http://www.youtube.com/embed/XGSy3_Czz8k"),

                               tags$blockquote("Tidy data sets are all the same. Each messy data set is messy in its own way.", 
                                               cite = "Hadley Wickham")),
                              
                                
                        
                        
                        column(4, 
                               h3("Help text"),
                               showOutput("chart3", "Highcharts")
                               ),
                        
                        column(4, 
                               h3("Help text"),
                               showOutput("chart4", "Highcharts")
                               )
                        )
                
        ),
       
       
                
        server = function(input, output){
                
                output$chart1 <- renderChart({
                        a <- hPlot(Pulse ~ Height, data = MASS::survey, type = "bubble", title = "Zoom demo", subtitle = "bubble chart", size = "Age", group = "Exer")
                        a$chart(zoomType = "xy")
                        a$chart(backgroundColor = NULL)
                        a$set(dom = 'chart1')
                        return(a)
                })
                
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