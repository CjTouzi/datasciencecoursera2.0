file <- unzip("./data/exdata-data-NEI_data.zip")
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
NEI <- tbl_df(NEI)
SCC <- readRDS("Source_Classification_Code.rds")
unlink(file)

head(NEI)
str(NEI)
head(SCC)
str(SCC)

# plot1 -------------------------------------------------------------------

library(dplyr)

NEI <- mutate(NEI, year= as.Date(as.character(year), "%Y"))

#NEI <- mutate(NEI, year= factor(as.Date(year, %Y))
#levels(NEI$year)

NEIbyYear <- {
        NEI %>%
                group_by(year)  %>%
                summarise(em= sum(Emissions, na.rm=TRUE)) 
        
}

NEIbyYear
with(NEIbyYear, 
{
        plot(year, em, type="l", main=" total PM2.5 emission from all sources across years", xlab="year", ylab=" total PM2.5 emission")
        points(year, em, pch=19)
}
)
