file <- unzip("./data/exdata-data-NEI_data.zip")
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
head(NEI)
str(NEI)
head(SCC)
str(SCC)


# plot1 -------------------------------------------------------------------


NEI_year <- split(NEI, NEI$year)
sapply(NEI$Emissions, by= NEI$year, sum)


plot(as.numeric(names(em)), em, col="red", type="l", lwd="3", xlab="year", ylab="total PM2.5 emission")
points(as.numeric(names(em)), em, pch=19,col="red",cex=2)


# plot2 -------------------------------------------------------------------

NEI_b <- subset(NEI, NEI$fips=="24510")
head(em_b)
em_b <- sapply(split(NEI_b, NEI_b$year),nrow)
plot(as.numeric(names(em_b)), em_b, col="red", type="l", lwd="3", xlab="year", ylab="total PM2.5 emission", main="Baltimore City")
points(as.numeric(names(em_b)), em_b, pch=19,col="red",cex=2)


# Plot3 -------------------------------------------------------------------

ty <- sapply(split(NEI, list(NEI$type, NEI$year)),nrow)
head(ty)






