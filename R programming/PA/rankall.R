rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    state <- sort(unique(data$State))
    hospital <- rep("", length(state))
    source("rankhospital.R")
    
    for (i in 1:length(state)) {

        hospital[i] <- rankhospital(state[i], outcome, num)
        
    }
    
    
    data.frame(hospital=hospital, state=state)
    
    
  
}