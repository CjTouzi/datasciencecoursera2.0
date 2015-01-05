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



# PLot6 -------------------------------------------------------------------

library(dplyr)

SCC.motor <- {
        SCC %>%
                filter(grepl("motor|Motor|veh|Veh",Short.Name))
        
}

head(SCC.motor$Short.Name)
NEI.motor <- merge(NEI, SCC.motor,by="SCC")


NEI.motor.Yearly.Bal.Los <- {
        NEI.motor  %>%
                # in Baltimore City
                filter(fips == "24510" | fips == "06037") %>%
                group_by(year, fips)  %>%
                summarise(em= sum(Emissions, na.rm=TRUE)) 
        
}
head(NEI.motor.Yearly.Bal.Los)

NEI.BA <- filter(NEI.motor.Yearly.Bal.Los, fips == "24510")
NEI.MD <- filter(NEI.motor.Yearly.Bal.Los, fips == "06037")

par(mar=c(4,4,4,2))
par(mfrow = c(2,1))
with(NEI.BA, {
        plot(year, em, col="blue", type="l", ylim=c(0, 500), xlab="year", ylab="Total PM2.5 Emission", main="BA")
        points(year, em, pch=19,col="blue")
        
        }
        )
with(NEI.MD, {
        plot(year, em, col="red", type="l", ylim=c(3000, 5000), xlab="year",  ylab="Total PM2.5 Emission",main="MD")
        points(year, em, pch=19,col="red")
        
}
)

# library(ggplot2)
# p <- qplot(year, em, data = NEI.motor.Yearly.Bal.Los, geom = c("point", "line"), 
#            colour = fips,
#            main="PM2.5 emission in Baltimore \n by sources",
#            ylab="total PM2.5 emission"
# )
# 
# 
# 
# p + theme_classic()+
#         scale_color_manual("City: ",labels = c("CA", "MD"), values = c("blue", "red")) +
#         theme(axis.title=element_text(face="bold.italic", size="14"), 
#               legend.position="top", 
#               plot.title = element_text(lineheight=.8, face="bold", size=14))



