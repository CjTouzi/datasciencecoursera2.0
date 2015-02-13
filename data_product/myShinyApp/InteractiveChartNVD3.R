
##  this is a template of the shiny app


require(rCharts)
require(shiny)
require(data.table)
require(rNVD3)

runApp(list(
        ui = fluidPage(      
                
                titlePanel("Basic widgets"),
                
                fluidRow(
                        
                        # upload csv file
                        column(2,
                               fileInput('file1', 'Choose file to upload',
                                         accept = c(
                                                 'text/csv',
                                                 'text/comma-separated-values',
                                                 'text/tab-separated-values',
                                                 'text/plain',
                                                 '.csv',
                                                 '.tsv'
                                         )
                               ),
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
                               p('If you want a sample .csv or .tsv file to upload,',
                                 'you can first download the sample',
                                 a(href = 'mtcars.csv', 'mtcars.csv'), 'or',
                                 a(href = 'pressure.tsv', 'pressure.tsv'),
                                 'files, and then try uploading them.'
                               )
                        ),
                        
                        column(4, 
                               h3("Column"),
                               showOutput("chart1")
                        ),
                        
                        column(4, 
                               h3("Line"),
                               showOutput("chart2")
                        )
                        
                ),
                
                fluidRow( 
                        column(2,
                               
                               # table format
                               helpText("Check your table format"), 
                               tableOutput('contents'),
                               h3("Youtube"),
                               # insert Youtube
                               tags$embed(src="http://www.youtube.com/embed/XGSy3_Czz8k"),
                               tags$blockquote("Tidy data sets are all the same. Each messy data set is messy in its own way.", 
                                               cite = "Hadley Wickham")),
                        column(4, 
                               h3("Pie"),
                               showOutput("chart3")
                        ),
                        column(4, 
                               h3("Bar"),
                               showOutput("chart4")
                        )
                )
                
        ),
        
        
        server = function(input, output){
                
                output$contents <- renderTable({
                        
                        # input$file1 will be NULL initially. After the user selects
                        # and uploads a file, it will be a data frame with 'name',
                        # 'size', 'type', and 'datapath' columns. The 'datapath'
                        # column will contain the local filenames where the data can
                        # be found.
                        
                        inFile <- input$file1
                        
                        if (is.null(inFile))
                                return(NULL)
                        
                        t <- read.csv(inFile$datapath, header = input$header,
                                      sep = input$sep, quote = input$quote)
                        
                        head(t)
                })
                
                
                output$chart1 <- renderChart2({
                        
                        dat <- data.frame(
                                t = rep(0:23, each = 4), 
                                var = rep(LETTERS[1:4], 4), 
                                val = round(runif(4*24,0,50))
                        )
                        p8 <- nPlot(val ~ t, group =  'var', data = dat, 
                                    type = 'stackedAreaChart', id = 'chart'
                        )
                        p8
                })
                
                output$chart3 <- renderChart2({                       
                        p1 <- nPlot(mpg ~ wt, group = 'cyl', data = mtcars, type = 'scatterChart')
                        p1$xAxis(axisLabel = 'Weight (in lb)')
                        p1
                })
                
                output$chart2 <- renderChart2({
                        hair_eye_male <- subset(as.data.frame(HairEyeColor), Sex == "Male")
                        a <- nPlot(Freq ~ Hair, group = "Eye", data = hair_eye_male, 
                                   type = 'multiBarChart')
                        a
                        
                })
                
                output$chart4 <- renderChart2({
                        p4 <- nPlot( ~ cyl, data = mtcars, type = 'pieChart')
                        p4
                })
        }
))