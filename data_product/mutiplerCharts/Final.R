require(rCharts)
library(shiny)
require(data.table)
require(rNVD3)
require(shinysky)

runApp(list(        
        
        
        ui= fluidPage(
        fluidRow(
                
                column(2,""),
                column(6,
                       h1("Interactive Charts For Everyone"
                        )
                )
        ),
        br(),
        fluidRow(
                column(2,""),
                column(4,
                       h3("Data Example"),
                       dataTableOutput('stackedAreaTable'),                       
                               
                               h3("Action button"),
                               actionButton("up", label = "Upload Your Data"),
                               actionButton("Plot", label = "Plot"),
                               actionButton("down", label = "Save HTML")
                                                
                               
                       ),
                column(6, showOutput("stackedArea"))

                
                
#                 column(4,
#                        wellPanel(
#                                h3("Action button"),
#                                actionButton("action2", label = "Upload Your Data"),
#                                hr(),
#                                p("Current Value:", style = "color:#888888;"), 
#                                verbatimTextOutput("action"),
#                                a("See Code", class = "btn btn-primary btn-md", 
#                                  href = "https://gallery.shinyapps.io/068-widget-action-button/")
#                                
#                        ))
                
                       
                   
        )

#         titlePanel("Interactive Charts For Everyone"),
#                       
#                       sidebarLayout(                                
#                               sidebarPanel(
#                                       helpText("This ",
#                                                "the specified number of observations, the",
#                                                "summary will be based on the full dataset.")
#                                       ),
#                               mainPanel(fluidRow(
#                                         column(8, showOutput("stackedArea")),
#                                         column(3, 
#                                                wellPanel( 
#                                                        actionButton("st1", label = "Data Structure", block=FALSE),
#                                                        actionButton("up1", label = "Upload Your Data",block=FALSE),
#                                                        actionButton("plot1", label = "Plot it",block=FALSE),
#                                                        actionButton("save1", label = "Save to HTML",block=FALSE))
#                                               
#                                                
# #                                                tableOutput('stackedAreaTable'),
# 
#                                                )
#                                                  ),
#                                         br(),br()
# 
#                                       )
#                       )
        ),
        server = function(input, output){ 
                
                
                ## stackedArea pannel
                
                output$stackedArea <- renderChart2({
                        
                        dat <- data.frame(
                                x = rep(0:23, each = 4), 
                                z = rep(LETTERS[1:4], 4), 
                                y = round(runif(4*24,0,50))
                        )

                        
                        n <- nPlot(y ~ x, group =  'z', data = dat, 
                                    type = 'stackedAreaChart', id = 'chart',width=800
                        )
                        
                })
                
                output$stackedAreaTable <- renderDataTable({
                        
                        # input$file1 will be NULL initially. After the user selects
                        # and uploads a file, it will be a data frame with 'name',
                        # 'size', 'type', and 'datapath' columns. The 'datapath'
                        # column will contain the local filenames where the data can
                        # be found.
                        
                        dat <- data.frame(
                                x = rep(0:23, each = 4), 
                                z = rep(LETTERS[1:4], 4), 
                                y = round(runif(4*24,0,50))
                        )    
                        head(dat,n=4)
                },
                options = list(searching = FALSE,paging = FALSE,searchable = FALSE))
                
          
        }
        
))




# other chart -------------------------------------------------------------


# output$chart2 <- renderChart2({
#         hair_eye_male <- subset(as.data.frame(HairEyeColor), Sex == "Male")
#         a <- nPlot(Freq ~ Hair, group = "Eye", data = hair_eye_male, 
#                    type = 'multiBarChart')
#         a
#         
# })
# 
# output$chart3 <- renderChart2({                       
#         p1 <- nPlot(mpg ~ wt, group = 'cyl', data = mtcars, type = 'scatterChart')
#         p1$xAxis(axisLabel = 'Weight (in lb)')
#         p1
# })
# 
# output$chart4 <- renderChart2({   
#         
#         # cite:http://walkerke.github.io/2014/03/tfr-in-europe/
#         
#         library(WDI)
#         library(rCharts)
#         library(plyr)
#         
#         countries <- c("AL", "AT", "BE", "BA", "BG", "HR", "CZ", "DK", "FI", "FR", "DE", "GR", 
#                        "HU", "IS", "IE", "IT", "NL", "NO", "PL", "PT", "RO", "RS", "SK", "SI", 
#                        "ES", "SE", "CH", "GB")
#         
#         tfr <- WDI(country = countries, indicator = "SP.DYN.TFRT.IN", start = 1960, end = 2011)
#         #Clean up the data a bit
#         tfr <- rename(tfr, replace = c("SP.DYN.TFRT.IN" = "TFR"))
#         
#         tfr$TFR <- round(tfr$TFR, 2)
#         
#         # Create the chart
#         tfrPlot <- nPlot(
#                 TFR ~ year, 
#                 data = tfr, 
#                 group = "country",
#                 type = "lineChart")
#         
#         # Add axis labels and format the tooltip
#         tfrPlot$yAxis(axisLabel = "Total fertility rate", width = 62)
#         
#         tfrPlot$xAxis(axisLabel = "Year")
#         
#         tfrPlot$chart(tooltipContent = "#! function(key, x, y){
#                                       return '<h3>' + key + '</h3>' + 
#                                       '<p>' + y + ' in ' + x + '</p>'} !#")
#         tfrPlot
#         
# }) 






