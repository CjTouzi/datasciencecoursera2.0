
# components of tide data -------------------------------------------------

# four things you should have in data 
# 1. raw data
# 2. tidy data
# 3. cookbook
# 4. steps 1->2

# the tidy data
# 1, each variable you measure should be in one col
# 2. each different observation of that variable should be in a different row
# 3. there should be one table for each "kind" of variable
# 4. if you have multiple tables, they should include a column in the the table that allows them to be linked



# csv ---------------------------------------------------------------------

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.csv", method="auto")list.files("./data")
dateDownloaded <- date()
dateDownloaded
cameraData <- read.table("./data/cameras.csv", sep=",", header=TRUE)
head(cameraData ,3)


# xlsx --------------------------------------------------------------------

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.xlsx", method="auto")
dateDownloaded <- date()
library(xlsx)
list.files()
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, header=TRUE)
head(cameraData)
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex)
cameraDataSubset

# XML ---------------------------------------------------------------------

library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
doc
rootNode <- xmlRoot(doc)
rootNode
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
rootNode[[1]][[3]]
names(rootNode[[2]])
xmlSApply(rootNode, xmlValue)

# /node Top level node; //node Node at any levels 
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)
xpathSApply(rootNode, "//description", xmlValue)
xpathSApply(rootNode, "//calories", xmlValue)

## Reading 
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"

doc <- htmlTreeParse(fileUrl, useInternal=TRUE)

scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
sort(scores)
sort(teams)


# json --------------------------------------------------------------------

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$site_admin
myjson <- toJSON(iris, pretty=TRUE)
head(iris)
cat(myjson)
iris2 <- fromJSON(myjson)
head(iris2)
head(jsonData)


# data.table package ------------------------------------------------------
library(data.table)
DF = data.frame(x=rnorm(9), y=rep(c("a", "b", "c"), each = 3), z=rnorm(9))
head(DF)
DT= data.table(x=rnorm(9), y=rep(c("a", "b", "c"), each = 3), z=rnorm(9))
head(DT)
# see all the data tables in memory
tables()

# subsetting rows
DT[2,]
DT[DT$y == "a" ]
DT[c(2,3)]

# calculating values for variables with expressions
DT[, list(mean(x),sum(z))]
DT[, table(y)]

# adding new columns :=
DT[, w:=z^2]
DT
DT2 <- DT
DT[, y:=2]
head(DT, n=3)
head(DT2, n=3)

# multiple operations
DT[, m:={tmp<-(x+z); log2(tmp+5)}]
# plyr like operations
DT[, a:=x>0]
DT
DT[,b:=mean(x+w), by=a]
DT

# special variables
# .N An integer, length 1, containing the number r
set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]

# the keys of data table 
DT <- data.table(x=rep(c("a","b","c"), each =100), y=rnorm(300))
setkey(DT,x)
DT['a']

# join between two tables
DT1 <- data.table(x=c('a','b','c','dt1'), y=1:4)
DT2 <- data.table(x=c('a','b','c','dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1,DT2)

# fast reading
big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file))
system.time(read.table(file, header=TRUE, sep="\t"))
