diabetesRisk <- function(glucose) glucose / 200
# install.packages("shiny")
library(shiny)

# A shiny project is a directory containing at least two parts
# One named ui.R (for user interface) controls how it looks.
# One named server.R that controls what it does.


# minimu ui.R  ------------------------------------------------------------

library(shiny)
shinyUI(
        pageWithSidebar(
        headerPanel("Data science FTW!"),
        sidebarPanel(
                # third level html heading
                h3('Sidebar text')
        ),
        
        mainPanel(
                h3('Main Panel text')
        )
))



# server.r ----------------------------------------------------------------

library(shiny)
shinyServer(
        function(input, output) {
        }
)