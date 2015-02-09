# dataUrl <- https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip

con <- unzip("./data/rprog-data-specdata.zip")
con



# Part 1 ------------------------------------------------------------------


source("pollutantmean.R")
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)




# Part2 -------------------------------------------------------------------


source("complete.R")

complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))

complete("specdata", 30:25)
complete("specdata", 3)


# Part3 -------------------------------------------------------------------

source("corr.R")
source("complete.R")
cr <- corr("specdata", 150)
head(cr)
summary(cr)

cr <- corr("specdata", 400)
head(cr)
summary(cr)

cr <- corr("specdata", 5000)
summary(cr)
length(cr)


cr <- corr("specdata")
summary(cr)

length(cr)

unlink(con)


# submission --------------------------------------------------------------

source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript1.R")
submit()





