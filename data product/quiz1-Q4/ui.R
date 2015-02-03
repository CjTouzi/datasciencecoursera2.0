library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("Data science FTW!"),
        sidebarPanel(
                h2('Big text'),
                h3('Sidebar')
        ),
        mainPanel(
                h3('Main Panel text')
        )
))