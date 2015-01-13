# dataUrl <- https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip

con <- unzip("./data/rprog-data-specdata.zip")
con

source("pollutantmean.R")
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)

unlink(con)
