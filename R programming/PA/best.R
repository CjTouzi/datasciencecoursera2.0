# Write a function called best that take two arguments: the 2-character abbreviated name of a state and an
# outcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector
# with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
# in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
# be one of "heart attack", "heart failure", or "pneumonia". Hospitals that do not have data on a particular
# outcome should be excluded from the set of hospitals when deciding the rankings.




best <- function(state, outcome) {
        
        ## Read outcome data
        
        data <- read.csv("./outcome-of-care-measures.csv", colClasses = "character")
        
        # [11] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" 
        # [17] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"  
        # [23] "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia" 
        
        
        ## Check that state and outcome are valid
        outcome.list <- c("heart attack","pneumonia","heart failure")  
        
        
        if (! outcome %in%  outcome.list) {
                
                stop("invalid outcome") 
                
        }
        
        state.list <- unique(data$State)
        
        if (! state %in% state.list) {
            
            stop("invalid state") 
            
        }
        
        
        names(data) <- tolower(names(data))
        outcome<- paste0("hospital.30.day.death..mortality..rates.from.",sub(" ",".",outcome))
        
        
        
        database <- data[data$state == state,]
        database$hospital.name[which.min(database[,outcome])]
 
}