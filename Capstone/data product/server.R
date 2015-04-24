

# dat <- read.csv('data.csv')
# 
# options(RCHART_WIDTH = 500)
source("./data/helper.R")
shinyServer(function(input, output) {
    load("./data/tdm.Freq.df.RData")
    output$value <- renderPrint({ back_off_model(input$text ,tdm.Freq.df)})
  
}
)