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


# Plot5 -------------------------------------------------------------------

library(dplyr)

SCC.motor <- {
        SCC %>%
                filter(grepl("motor|Motor|veh|Veh",Short.Name))
        
}
head(SCC.motor$Short.Name)
NEI.motor <- merge(NEI, SCC.motor,by="SCC")

NEI.motor.Yearly.Bal <- {
        NEI.motor  %>%
                # in Baltimore City
                filter(fips == "24510") %>%
                
                group_by(year)  %>%
                summarise(em= sum(Emissions, na.rm=TRUE)) 
        
}

with(NEI.motor.Yearly.Bal, 
{
        plot(year, em, type="l", main="motor vehicle sources emission \n across years in Baltimore", xlab="year", ylab=" total PM2.5 emission")
        points(year, em, pch=19)
}
)
