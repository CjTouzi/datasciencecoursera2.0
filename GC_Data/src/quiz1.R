
# q1 ----------------------------------------------------------------------

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "

download.file(fileUrl, destfile = "./data/microSurvey2006.csv" ,method="auto")

micro06 <- read.csv("./data/microSurvey2006.csv")
names(micro06)
head(micro06$wgtp1)

# $ Val: property value
table(micro06$VAL)

# q3 ----------------------------------------------------------------------

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="./data/nga.xlsx", method="auto")

dateDownloaded <- date()

library(rJava)
library(xlsxjars)
library(xlsx)

list.files("./data/")

colIndex <- 7:8
rowIndex <- 18:20
dat <- read.xlsx("./data/nga.xlsx", sheetIndex=1, header=TRUE, colIndex=colIndex, rowIndex=rowIndex)



# q4 ----------------------------------------------------------------------

fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
library(XML)
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
doc 
rootNode <-xmlRoot(doc)
xmlName(rootNode)
rootNode[[1]][[1]][[1]]
sum(xpathSApply(rootNode, "//zipcode", xmlValue)==21231)
names(rootNode)


# q5 ----------------------------------------------------------------------

require(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./data/microdata3.csv", method="auto")
DT <- fread("./data/microdata3.csv")
print( object.size(DT), units ="Mb")
head(DT$pwgtp15, 3)
"A"
system.time(replicate(100, sapply(split(DT$pwgtp15,DT$SEX),mean)))
"B"
system.time(replicate(100, tapply(DT$pwgtp15,DT$SEX,mean)))
"C"
system.time(replicate(100, mean(DT[DT$SEX==1,]$pwgtp15)))*2
"D"
system.time(replicate(100, DT[,mean(pwgtp15),by=SEX]))
"E"
system.time(replicate(100, rowMeans(DT)[DT$SEX==1]))*2

