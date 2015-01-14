complete <- function(directory, id = 1:332) {
        
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
  
        df <- data.frame(id, nobs=rep(0, length(id)))
        
        for(j in 1: length(id)){  

                csvfiles <- sprintf("%s/%03d.csv", directory, id[[j]])   
                data <- read.csv(csvfiles, header=TRUE)
                df$nobs[j] <- nrow(data[complete.cases(data),])
                
                
        }
        df
        
}