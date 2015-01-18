con <- unzip("./data/rprog-data-ProgAssignment3-data.zip")
outcome <- read.csv("./outcome-of-care-measures.csv", colClasses = "character")


head(outcome)
str(outcome)
names(outcome)

# Part1 -------------------------------------------------------------------

# a simple histogram
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])


# Part2 -------------------------------------------------------------------

source("best.R")

best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")

source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript3.R")
submit()


# Part 3 ------------------------------------------------------------------

source("rankhospital.R")
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")


rankhospital("MN", "heart attack", 5000)



# Part4 -------------------------------------------------------------------
source("rankall.R")
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

