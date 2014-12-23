# subset quick review

set.seed(13435)
X<- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X<- X[sample(1:5),]
X$var2[c(1,3)]=NA
X
X[(X$var1<=3 & X$var3>11),]
X[(X$var1<=3 | X$var3>15),]
X[which(X$var2>8),]
sort(X$var1)
sort(X$var1, decreasing = T)
sort(X$var2, na.last = T)

# order the varibles by a particular varible

X[order(X$var2, X$var3), ]

library(plyr)
arrange(X,var1)
arrange(X,desc(var1))
X$var4 <- rnorm(5)
X
Y <- cbind (X, rnorm(5))
Y

if (!file.exists("./data")) { dir.create("./data/")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/restaurants.csv", method="auto")
restData <- read.csv("./data/restaurants.csv")
head(restData)
tail(restData)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = T)
table(restData$zipCode, useNA = "ifany")
table(restData$councilDistrict, restData$zipCode)
summary(restData$councilDistrict)
table(restData$zipCode,restData$councilDistrict)
sum(is.na(restData$councilDistrict))
all(restData$zipCode>0)
min(restData$zipCode)
colSums(is.na(restData))
colSums(cbind(restData$zipCode))
table (restData$zipCode %in% c("21212"))
table (restData$zipCode %in% c("-21212"))
table (restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"), ]

# cross tabs
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)
str(DF)
head(DF)
data(ozone)
oz = as.data.frame(ozone)
head(oz)
str(oz)
summary(oz)

# 2-way Frequency Table
mytable <- table (DF$Gender, DF$Freq)
mytable
margin.table(mytable, 1)
margin.table(mytable, 2)
prop.table(mytable)
prop.table(mytable,1)
prop.table(mytable,2)

# 3-way frequency table 
mytable <- table(DF$Gender, DF$Freq, DF$Dept)
ftable(mytable)

# xtabs() function allows you to create crosstabulations using formula style input
# 3-way Frequency table
mytable <- xtabs(~Gender+Freq+Dept, data=DF)
ftable(mytable)
summary(mytable)

# crosstable in the gmodels package produces crosstabulations modeled 
library(gmodels)
CrossTable(DF$Gender, DF$Dept)

# cross table Freq as function  
xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt

# flat tables 

warpbreaks$breaks <- rep (1:9, len=54)
warpbreaks$breaks
xt = xtabs(breaks ~. ,data= warpbreaks)
xt 
str(warpbreaks)
ftable(xt)

# size of a data set 
fakeData = rnorm(1e5)
object.size(fakeData)
# format(fakeData,  units ="auto")
print(object.size(fakeData))
a <- rnorm(10^7)
print(object.size(a),units="b")
print(object.size(a),units="auto")
print(object.size(a),units="Mb")
remove(a)





