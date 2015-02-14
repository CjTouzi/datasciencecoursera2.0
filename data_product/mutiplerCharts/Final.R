require(rCharts)
library(shiny)
require(data.table)
# require(rNVD3)

runApp(list(                
        
        ui= fluidPage(
            
        fluidRow(                
                column(2,""),
                column(6,
                       h1("Interactive Charts For Everyone"),
                       tags$hr(),
                       tags$blockquote("Tell me and I forget, teach me and I remember, involve me and I learn"),
                       tags$blockquote("--------- Benjamin Franklin")
                       
                )
        ),
        tags$hr(),
        
        fluidRow(
                
                column(2,""),
                column(10,
                       tabsetPanel(tabPanel("Example",
                                        column(4,
                                               h3("Data Story"),
                                               tags$hr(),
                                               h3("Data Example"),
                                               dataTableOutput('stackedAreaTable'),
                                               h3("save example to .csv"),
                                               downloadButton('foo2')
                                        ),                                     
                                        column(6, showOutput("stackedArea"))),
                                   
                                   tabPanel("Charting",
                                            
                                            column(4, 
                                                   h3("Data Example"),
                                                   tags$hr(),
                                                   fileInput('file1', 'Choose CSV File',
                                                             accept=c('text/csv', 
                                                                      'text/comma-separated-values,text/plain', 
                                                                      '.csv')),
                                                   tags$hr(),
                                                   checkboxInput('header', 'Header', TRUE),
                                                   radioButtons('sep', 'Separator',
                                                                c(Comma=',',
                                                                  Semicolon=';',
                                                                  Tab='\t'),
                                                                ','),
                                                   radioButtons('quote', 'Quote',
                                                                c(None='',
                                                                  'Double Quote'='"',
                                                                  'Single Quote'="'"),
                                                                '"'),  
                                                   tags$hr(),
                                                   radioButtons("radio1", label = h4("Show"),
                                                                choices = list("See your Table" = 1, "Plot!" = 2), 
                                                                selected = 1),                                            
                                                   # actionButton("down1", label = "Save to HTML")
                                                   tags$hr(),
                                                   h4("Save to standard-alone html file"),
                                                   downloadButton('foo'),
                                                   p('If you want a sample .csv or .tsv file to upload,',
                                                     'you can first download the example csv'
                                                   )
                                                   ), 
                                            column(6,
                                                   conditionalPanel("input.radio1 == 1",dataTableOutput('t1')),
                                                   conditionalPanel("input.radio1 == 2",showOutput("mp1"))
                                                   )
                                                  )                                            
                                            )                     
                       )
                               
        )),
        server = function(input, output){ 
                
                expData1 <- reactive({
                    
                    dat <- data.frame(
                        x = rep(0:23, each = 4), 
                        z = rep(LETTERS[1:4], 4), 
                        y = round(runif(4*24,0,50))
                    ) 
                    
                })
                expChart1 <- reactive({
                    dat <-  expData1()
                    n <- nPlot(y ~ x, group =  'z', data = dat, 
                               type = 'multiBarChart', id = 'chart',width=800
                    )
                    n$xAxis(axisLabel = 'x')
                    n$yAxis(axisLabel = 'y')
                    n
                })
            
                ## stackedArea pannel                
                output$stackedArea <- renderChart2({ 
                   
                    n <- expChart1()
                    n$addParams(dom = "visual")  
                    n
                })
                
                output$stackedAreaTable <- renderDataTable({                                            
                        dat <-  expData1()
                        head(dat,n=4)
                },                
                options = list(searching = FALSE,paging = FALSE,searchable = FALSE))
   
                dataInput1 <- reactive({
                    inFile <- input$file1                    
                    if (is.null(inFile))
                        return(NULL)
                    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                                       quote=input$quote)
                })
                
                chartInput1 <- reactive({
                    
                    data <- dataInput1()
                    names(data) <- c("x","z","y")
                    n <- nPlot(y ~ x, group =  'z', data = data ,type='multiBarChart',id = 'chart',width=800)
                    # n$xAxis(axisLabel = names(dataInput1())[1])
                    # n$yAxis(axisLabel = names(dataInput1())[3]) 
                    
                })
 
                output$t1 <- renderDataTable({
                    
                    # input$file1 will be NULL initially. After the user selects
                    # and uploads a file, it will be a data frame with 'name',
                    # 'size', 'type', and 'datapath' columns. The 'datapath'
                    # column will contain the local filenames where the data can
                    # be found.
                    dataInput1()
                    

                })
                
                
                output$mp1 <- renderChart2({                                   
                    chartInput1()
                })
                
                plotInput = function(file) {
                    # qplot(speed, dist, data = cars)
#                     a <- hPlot(Pulse ~ Height, data = MASS::survey, type = "bubble", 
#                                title = "Zoom demo", 
#                                subtitle = "bubble chart", 
#                                size = "Age", group = "Exer")
                    a <- chartInput1()
                    a$save(file, standalone = TRUE)
                    
                }
                
                output$foo = downloadHandler(                   
                    filename = 'mychart.html',
                    content = function(file) {
                        plotInput(file)
                           
                    })
                output$foo2 = downloadHandler(                   
                    filename = 'ex1.csv',
                    content = function(file) {
                    write.table(expData1(),file=file,sep=",",col.names = TRUE,quote = TRUE)  
                        
                    })
                

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






