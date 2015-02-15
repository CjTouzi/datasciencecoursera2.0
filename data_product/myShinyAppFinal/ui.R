require(rCharts)
require(shiny)
require(data.table)

shinyUI(
    fluidPage(        
        fluidRow(                
            column(2,""),
            column(6,
                   h1("Interactive Charts For Everyone"),
                   tags$hr(),
                   tags$blockquote("Tell me and I forget, teach me and I remember, involve me and I learn"),
                   tags$blockquote("--------- Benjamin Franklin"),
                   h4("Contact me at cjtouzi@gmail.com"),
                   # h4("or"),
                   # a(href="https://www.linkedin.com/profile/view?id=135606722&trk=nav_responsive_tab_profile_pic"),
                   h4("I'd like to hear from you")
            )
        ),
        tags$hr(),
        
        fluidRow(
            
            column(2,""),
            column(10,
                   tabsetPanel(tabPanel("Example",
                                        column(4,  
                                               # tags$hr(),
                                               h3("How to Use"),
                                               h4("1. Download the example .csv"),
                                               h4("2. Save your data as .csv format"),
                                               h4("3. Upload your csv under charting tab"),
                                               h4("4. Plot and  Save as standard alone html"),
                                               h4("6. Use it anywhere you like (such as PPT)" ),
                                               tags$hr(),
                                               dataTableOutput('stackedAreaTable'),
                                               h3("save example to .csv"),
                                               downloadButton('foo2')
                                        ),                                     
                                        column(6, showOutput("stackedArea","nvd3"))),
                               
                               tabPanel("Charting",
                                        
                                        column(4, 
                                               h3("Upload Your Data Here"),
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
                                               conditionalPanel("input.radio1 == 2",showOutput("mp1","nvd3"))
                                        )
                               )                                            
                   )                     
            )
    
    )))
