corr <- function(directory, threshold = 0) {
        
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
   
        source("complete.R")
        library(dplyr)

        complet.list <- {
                complete(directory) %>%
                        filter(nobs>threshold)
        }
    
        nr <- nrow(complet.list)
        
        

        cor <- rep(0, nr)
        
        if (nr == 0) {
                
                return(cor)
                
        }
        
        for (i in 1: nr){
                
                csvfiles <- sprintf("%s/%03d.csv", directory, complet.list$id[i])   
                data <- read.csv(csvfiles, header=TRUE)
                data <- data[complete.cases(data),]
                cor[i] <- cor(data$sulfate, data$nitrate)
       
        }
        
        cor 
        
}