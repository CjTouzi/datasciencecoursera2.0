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
