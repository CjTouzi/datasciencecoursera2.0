library(shiny)

shinyUI(
    pageWithSidebar(
            
    headerPanel("Time series decomposition"),
    
    sidebarPanel(   
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
                    "Adjust prices for inflation", value = FALSE)
        
    ),
    
    mainPanel(
        tabsetPanel(tabPanel("Main",plotOutput("plot", height = 800, width = 1000)),
                    tabPanel("Help Info",helpText("Select a stock to examine. 
                    Information will be collected from yahoo finance."))
                    
        )#tabsetPanel  
        
    )#mainPane;
    
))





