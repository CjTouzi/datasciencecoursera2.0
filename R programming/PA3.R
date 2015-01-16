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
best("NY", "hert attack")

outcomeList <- c("heart attack","pneumonia","heart failure")

"heart" %in% outcomeList

