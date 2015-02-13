require(rCharts)
require(shiny)
require(data.table)
require(rNVD3)

runApp(list(
        ui= fluidPage(
                
                titlePanel("Interactive Charts"),
                
                sidebarLayout(
                        
                        sidebarPanel(
                                
#                                 fileInput('file1', 'Choose file to upload',
#                                           accept = c(
#                                                   'text/csv',
#                                                   'text/comma-separated-values',
#                                                   'text/tab-separated-values',
#                                                   'text/plain',
#                                                   '.csv',
#                                                   '.tsv'
#                                           )
#                                 ),
#                                 tags$hr(),
#                                 checkboxInput('header', 'Header', TRUE),
#                                 radioButtons('sep', 'Separator',
#                                              c(Comma=',',
#                                                Semicolon=';',
#                                                Tab='\t'),
#                                              ','),
#                                 radioButtons('quote', 'Quote',
#                                              c(None='',
#                                                'Double Quote'='"',
#                                                'Single Quote'="'"),
#                                              '"'),
#                                 tags$hr(),
#                                 p('If you want a sample .csv or .tsv file to upload,',
#                                   'you can first download the sample',
#                                   a(href = 'mtcars.csv', 'mtcars.csv'), 'or',
#                                   a(href = 'pressure.tsv', 'pressure.tsv'),
#                                   'files, and then try uploading them.'
#                                 )
                         ),
                        
                        mainPanel(                                
                                tabsetPanel(
                                        
#                                         tabPanel("Example" 
# #                                                  # fluidRow(column(6, showOutput("chart1","Highcharts")),
# #                                                  fluidRow(column(6, helpText("hi")),
# #                                                           column(6, showOutput("chart2", "Highcharts"))), 
# #                                                  fluidRow(column(6, showOutput("chart3", "Highcharts")),
# #                                                           column(6, showOutput("chart4", "Highcharts")))
#                                                  ), 
                                        tabPanel("Column"), 
                                        tabPanel("Line", verbatimTextOutput("Line")), 
                                        tabPanel("Pie", verbatimTextOutput("Pie")), 
                                        tabPanel("Bar", verbatimTextOutput("Bar")), 
                                        tabPanel("Table", tableOutput("table"))
                                )
                        )
                )
        ),
        server = function(input, output){
                # show table
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
                
                output$chart1 <- renderChart({

#                         haireye = as.data.frame(HairEyeColor)
#                         n1 <- nPlot(Freq ~ Hair, group = 'Eye', type = 'multiBarChart',
#                                     data = subset(haireye, Sex == 'Male')
#                         )                        
#                         return(n1)
     
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