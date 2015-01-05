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


# Plot4 -------------------------------------------------------------------

head(NEI)
SCC <- tbl_df(SCC)
head(SCC)

library(dplyr)

SCC.Coal <- {
        SCC %>%
                filter(grepl("coal|Coal",Short.Name))
        
}

head(SCC.Coal$Short.Name)

NEI.Coal <- merge(NEI, SCC.Coal,by="SCC")

NEI.Coal.Yearly <- {
        NEI.Coal  %>%
                group_by(year)  %>%
                summarise(em= sum(Emissions, na.rm=TRUE)) 
        
}


with(NEI.Coal.Yearly , 
{
        plot(year, em, type="l", main=" total Coal related PM2.5 emission \n across years", xlab="year", ylab=" total PM2.5 emission")
        points(year, em, pch=19)
}
)
