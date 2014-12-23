
# q1 ----------------------------------------------------------------------

fileUrl="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./data/microSurvey2006.csv", method="auto")
micro <- data.table(read.csv("./data/microSurvey2006.csv"))
head(micro)
names(micro)
agricultureLogical <- (micro$ACR == 3 & micro$AGS==6)
head(agricultureLogical)
which(agricultureLogical)[1:3]


# Q2 ----------------------------------------------------------------------
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url, destfile="./data/q2.jpg",mode="wb")

library(jpeg)
img <- readJPEG("data/q2.jpg", native=TRUE)
head(img)
quantile(img)
quantile(img, probs = c(0.3,0.8))



# Q3 ----------------------------------------------------------------------
fileUrl="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
download.file(fileUrl, destfile="./data/gdp.csv", method="auto")
fileUrl1="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl1, destfile="./data/edu.csv", method="auto")

library(data.table)

gdp <- data.table(read.csv("./data/gdp.csv", skip=4, nrows=215))

tail(gdp)
names(gdp)
setnames(gdp, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
head(gdp)
edu <- data.table(read.csv("./data/edu.csv", header=TRUE))
head(edu)
names(edu)
tail(edu)

intersect(gdp$X,edu$CountryCode)
length(!is.na(intersect(gdp$CountryCode,edu$CountryCode)))
length(levels(gdp$X))

dt <- merge(gdp, edu, all=TRUE, by=c("CountryCode"))
sum(!is.na(unique(dt$rankingGDP)))
head(dt)
dt[order(rankingGDP, decreasing=TRUE), list(CountryCode, Long.Name.x, Long.Name.y, rankingGDP, gdp)][13]


# Q4 ----------------------------------------------------------------------
dt[, mean(rankingGDP, na.rm=TRUE), by=Income.Group]


# Q5 ----------------------------------------------------------------------

breaks <- quantile(dt$rankingGDP, probs=seq(0, 1, 0.2), na.rm=TRUE)
dt$quantileGDP <- cut(dt$rankingGDP, breaks=breaks)
dt[Income.Group == "Lower middle income", .N, by=c("Income.Group", "quantileGDP")]




dt$rankingGroups=cut(dt$rankingGDP, breaks=quantile(dt$rankingGDP, probs = seq(0,1,0.2)), na.rm=TRUE))
dt[Income.Group == "Lower middle income", .N, by=c("Income.Group", "quantileGDP")]
table(dt$rankingGroups, dt$Income.Grou)
