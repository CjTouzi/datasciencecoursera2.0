file <- unzip("./data/clusteringEx_data.zip")
unlink(file)
load("./data//samsungData.rda")
names(samsungData)[1:12]
table(samsungData$activity)


par(mfrow = c(1,2), mar= c(5,4,1,1))
samsungData <- transform(samsungData, activity= factor(activity))
sub1 <- subset(samsungData, subject ==1)
plot(sub1[,1], col=sub1$activity, ylab = names(sub1)[1])
plot(sub1[,2], col=sub1$activity, ylab = names(sub1)[2])
legend("bottomright", legend=unique(sub1$activity), col =unique(sub1$activity),pch=1)

source("./src/myplclust.R")
distanceMatrix <- dist(sub1[,1:3])
hclustering <- hclust(distanceMatrix)
par(mfrow = c(1,1), mar= c(3,3,3,3))
myplclust(hclustering, lab.col = unclass(sub1$activity))

par(mfrow = c(1,2))
plot(sub1[,10], pch=19, col =sub1$activity, ylab= names(sub1)[10])
plot(sub1[,11], pch=19, col =sub1$activity, ylab= names(sub1)[11])

source("./src/myplclust.R")
distanceMatrix <- dist(sub1[,10:13])
hclustering <- hclust(distanceMatrix)
par(mfrow = c(1,1), mar= c(3,3,3,3))
myplclust(hclustering, lab.col = unclass(sub1$activity))


svd1 <- svd (scale(sub1[,-c(562,563)]))
par(mfrow=c(1,2))
plot(svd1$u[,1], pch=19, col =sub1$activity)
plot(svd1$u[,2], pch=19, col =sub1$activity)
par(mfrow=c(1,1))
plot(svd1$v[,2],pch=19)
maxContrib <- which.max(svd1$v[,2])
maxContrib
distanceMatrix <- dist(sub1[,c(10:12, maxContrib)])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))
names(samsungData)[maxContrib]


# kcluster

kClust <- kmeans(sub1[,-c(562,563)], centers=6, nstart=1)
table(kClust$cluster, sub1$activity)

kClust <- kmeans(sub1[,-c(562,563)], centers=6, nstart=100)
table(kClust$cluster, sub1$activity)

# laying
plot(kClust$centers[1, 1:10], pch=19, ylab="Cluster Center")

# walking
plot(kClust$centers[4, 1:10], pch=19, ylab="Cluster Center")


# Air Pollution case study ------------------------------------------------

file<- unzip("./data/pm25_data.zip")
pm0 <- read.table("./pm25_data/RD_501_88101_1999-0.txt", comment.char = "#", header = FALSE, sep ="|", na.strings = "")
dim(pm0)
head(pm0)
cnames <- readLines("./pm25_data/RD_501_88101_1999-0.txt",1)
cnames <- strsplit(cnames, "|", fixed = TRUE)
cnames
names(pm0) <- cnames[[1]]
head(pm0)
names(pm0) <- make.names(cnames[[1]])
head(pm0)
x0 <- pm0$Sample.Value
class(x0)
str(x0)
summary(x0)
mean(is.na(x0))
pm1 <- read.table("./pm25_data/RD_501_88101_2012-0.txt", comment.char = "#", header = FALSE, sep ="|", na.strings = "")
dim(pm1)
names(pm1) <- make.names(cnames[[1]])
head(pm1)
x1 <- pm1$Sample.Value
str(x1)
summary(x0)
summary(x1)
mean(is.na(x1))
unlink(file)
boxplot(x0, x1, ylim=c(0,100))
boxplot(log(x0),log(x1))


# negtive value
negtive <- x1<0
str(negtive)
sum(negtive, na.rm = TRUE)
mean(negtive, na.rm=TRUE)
dates <- pm1$Date
str(dates)
dates <- as.Date(as.character(dates), "%Y%m%d")
str(dates)
hist(dates, "month")
hist(dates[negtive],"month")

site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))
head(site0)
site0 <- paste(site0[,1], site0[,2], sep=".")
site1 <- paste(site1[,1], site1[,2], sep=".")
head(site0)
str(site0)
str(site1)
both <- intersect(site0, site1)
both


pm0$County.site <- with(pm0,paste(County.Code, Site.ID, sep=".") )
pm1$County.site <- with(pm1,paste(County.Code, Site.ID, sep=".") )
cnt1 <- subset(pm1,State.Code == 36 & County.site %in% both)
cnt0 <- subset(pm0,State.Code == 36 & County.site %in% both)
sapply(split(cnt0, cnt0$County.site),nrow)
sapply(split(cnt1, cnt1$County.site),nrow)

pm1sub <- subset(pm1, State.Code ==36 & County.Code==63 & Site.ID == 2008)
pm0sub <- subset(pm0, State.Code ==36 & County.Code==63 & Site.ID == 2008)

dim(pm1sub)
dim(pm0sub)

dates1 <- pm1sub$Date
x1sub <- pm1sub$Sample.Value
plot(dates1, x1sub)
dates1 <- as.Date(as.character(dates1), "%Y%m%d")
str(dates1)
plot(dates1, x1sub)

dates0 <- pm0sub$Date
dates0 <- as.Date(as.character(dates0), "%Y%m%d")
x0sub <- pm0sub$Sample.Value
plot(dates0, x0sub)

par(mfrow=c(1,2), mar=c(4,4,2,1))
plot(dates0, x0sub, pch=20)
abline(h=median(x0sub, na.rm=T))
plot(dates1, x1sub, pch=20)
abline(h=median(x1sub, na.rm=T))

rng <- range(x0sub, x1sub,na.rm=T)
par(mfrow=c(1,2), mar=c(4,4,2,1))
plot(dates0, x0sub, pch=20, ylim=rng)
abline(h=median(x0sub, na.rm=T))
plot(dates1, x1sub, pch=20,ylim=rng)
abline(h=median(x1sub, na.rm=T),)

mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm=T))
summary(mn0)
mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm=T))
summary(mn1)
d0 <- data.frame(state = names(mn0), mean=mn0)
d1 <- data.frame(state = names(mn1), mean=mn1)
head(d0)

mrg <- merge(d0, d1, by="state")
head(mrg)

par(mfrow = c(1,1))
with(mrg, plot(rep(1999,52), mrg[,2],xlim=c(1998,2013)))
with(mrg, points(rep(2012,52), mrg[,3],xlim=c(1998,2013)))
segments(rep(1999,52),mrg[,2], rep(2012,52),mrg[,3])



