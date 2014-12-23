

# Q1 ----------------------------------------------------------------------


micro<-read.csv("./data/getdata-data-ss06hid.csv")
names(micro)[123]
strsplit(names(micro)[123],"wgtp")


# Q2 ----------------------------------------------------------------------


gdp <- read.csv("./data/getdata-data-GDP.csv")
names(gdp)
cleanedData <- gsub(",", "", gdp[5:194, 5])
numData <- as.numeric(cleanedData)
mean(numData)
head(cleanedData, 30)
countryNames <- gdp[5:194,4]
grep("^United",countryNames)

edu <- read.csv("./data/getdata-data-EDSTATS_Country.csv")

names(edu)
newGdpData <- gdp[6:194, c(1, 2, 4, 5)]
colnames(newGdpData) <- c("CountryCode", "Ranking", "Economy", "GDP")
rownames(newGdpData)<- NULL
names(edu)
mergedData <- merge(newGdpData, edu, by.x="CountryCode", by.y="CountryCode", all=TRUE)
names(mergedData)
length(grep("Fiscal year end: June", as.character(mergedData[,13])))



# Q5 ----------------------------------------------------------------------

library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
dim(sampleTimes)
head(sampleTimes)
sampleTimes <- as.Date(sampleTimes)
length(sampleTimes)
head(sampleTimes)
length(sampleTimes[year(sampleTimes)=="2012"])
length(sampleTimes[year(sampleTimes)=="2012" & weekdays(sampleTimes)=="Monday"])

names(sampleTimes)
