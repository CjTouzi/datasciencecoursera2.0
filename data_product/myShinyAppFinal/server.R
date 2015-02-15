require(rCharts)
library(shiny)
require(data.table)

shinyServer(function(input, output) {
    
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
        # n$xAxis(axisLabel = 'x')
        # n$yAxis(axisLabel = 'y')
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
    
    
})