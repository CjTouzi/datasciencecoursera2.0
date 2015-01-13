pollutantmean <- function(directory, pollutant, id = 1:332) {
    
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    
    n <- 0 # total number of values ignoring missing values
    sum <- 0 # sum of values ignoring missing values
    
    for (i in id) { 
        
        csvfiles <- sprintf("%s/%03d.csv", directory, i)
        data <- read.csv(csvfiles, header=TRUE)
        n<- n+  length(na.omit(data[, as.character(pollutant)])) 
        sum <- sum + sum(data[, as.character(pollutant)], na.rm=TRUE)
        
    }
    
    sum/n
    
    
    
}