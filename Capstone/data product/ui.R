library(shiny)

# Define UI for random distribution application 
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Coursera Data Science Capstone Project"),
    h3("- predicting your next word"),
    h5("Copy right by Cheng Juan (2015-now)"),    
    br(),
    br(),
    sidebarLayout(
        sidebarPanel(
            # Copy the line below to make a text input box
            textInput("text", label = h3("Text input"), value = "Enter text here, data science"),
#             textInput("text", label = "input your setence", 
#                       value="Let us always meet each other with smile"),
            submitButton(text="go!!!"),
            br(),
            h5("your result:"),
            verbatimTextOutput("value")
        ),
        
        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        mainPanel(
            h3("A Flow Chart of how to predict words"),
            img(src="flow.png", height = 600, width = 600)
            # <img src="flow.png" />
    
        )
    )
))