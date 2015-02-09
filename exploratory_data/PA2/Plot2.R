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



# plot2 -------------------------------------------------------------------
library(dplyr)
NEI_Baltimore <- {
        
        NEI %>% 
                filter(fips == "24510") %>%
                group_by(year)  %>%
                summarise(em= sum(Emissions, na.rm=TRUE)) 
        
        
}

NEI_Baltimore

with(NEI_Baltimore, 
{
        plot(year, em, type="l", main=" total PM2.5 emission in Baltimore from all sources", xlab="year", ylab=" total PM2.5 emission")
        points(year, em, pch=19)
}
)

# text(baltimoresum$year, baltimoresum$Emissions, labels = round(baltimoresum$Emissions, digits = 0), 
#     pos = c(4,1,3,2), col = "red")  ## add the data point labels in red
