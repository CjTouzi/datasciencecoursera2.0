require(rNVD3)


runApp(list(
        
        ui=pageWithSidebar(
                headerPanel("rNVD3: Interactive Charts from R using NVD3.js"),
                
                sidebarPanel(
                        selectInput(inputId = "gender",
                                    label = "Choose Gender",
                                    choices = c("Male", "Female"),
                                    selected = "Male"),
                        selectInput(inputId = "type",
                                    label = "Choose Chart Type",
                                    choices = c("multiBarChart", "multiBarHorizontalChart"),
                                    selected = "multiBarChart"),
                        checkboxInput(inputId = "stack",
                                      label = strong("Stack Bars?"),
                                      value = FALSE)
                ),
                mainPanel(
                        showOutput("myChart")
                )
        ),
        
        server = function(input, output){
                output$myChart <- renderChart({
                        hair_eye = as.data.frame(HairEyeColor)
                        p6 <- nvd3Plot(Freq ~ Hair | Eye, data = subset(hair_eye, Sex == input$gender), 
                                       type = input$type, id = 'myChart', width = 800)
                        p6$chart(color = c('brown', 'blue', '#594c26', 'green'), stacked = input$stack)
                        return(p6)
                })
                
        }))
        
