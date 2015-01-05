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


# Plot3 -------------------------------------------------------------------
library(dplyr)
NEI_Baltimore_type <- {
        NEI %>% 
                filter(fips == "24510") %>%
                mutate(type= factor(type)) %>% 
                group_by(type, year) %>% 
                summarise(em= sum(Emissions, na.rm=TRUE))
        
        
}
head(NEI_Baltimore_type)
levels(NEI_type$type)


library(ggplot2)
p <- qplot(year, em, data = NEI_Baltimore_type, geom = c("point", "line"), colour = type, 
           main="PM2.5 emission in Baltimore \n by sources",
           ylab="total PM2.5 emission"
)
p + theme_classic()+
        theme(axis.title=element_text(face="bold.italic", size="14"), 
              legend.position="top", 
              plot.title = element_text(lineheight=.8, face="bold", size=14))
