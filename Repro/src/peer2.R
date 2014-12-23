

storm <- read.csv(bzfile("./data/repdata-data-StormData.csv.bz2"))     

# Health and Economic Impact of Weather Events in the US ------------------

# names(storm)

# lower case
event_type <- tolower(storm$EVTYPE)
length(unique(event_type))
# translate all letters to lowercase

# remove all punct. characters with a space
event_type <- gsub("[[:blank:][:punct:]+]", " ", event_type)
# data processing 
storm$EventTypeCode<- event_type
head(storm$EventTypeCode)
length(unique(event_type))

tolower(names(storm))
head(storm$MAG)

popHealthFactor<- c("fatalities","injuries")
EcoFactor <- c("prop_dmg, crop_dmg")



# Across the United States, 
# which types of events 
# (as indicated in the EVTYPE variable) 
# are most harmful with respect to population health?

library(plyr)

fatalCount <- ddply(storm, .(EventTypeCode), summarize, fatalities = sum(FATALITIES))
injurCount <- ddply(storm, .(EventTypeCode), summarize, injuries = sum(INJURIES))



as.POSIXct(strptime(storm$BGN_DATE[1:10], "%m/%d/%Y %H:%M:%S"))

fatalCount <- ddply(storm, .~EventTypeCode, summarize, fatalities = sum(FATALITIES))
injurCount <- ddply(storm10year, .(EventTypeCode), summarize, injuries = sum(INJURIES))

fatalTop10 <- fatalCount[order(fatalCount$fatalities,decreasing = T)[1:10],] 
fatalTop10 
injurTop10 <- injurCount[order(injurCount$injuries,decreasing = T)[1:10],] 
injurTop10

# 2001-2011
storm$BGN_DATE <- as.POSIXct(strptime(storm$BGN_DATE, "%m/%d/%Y %H:%M:%S"))
head(storm$BGN_DATE)

date <- as.POSIXct(strptime("01/01/2001 00:00:00", "%m/%d/%Y %H:%M:%S"))
storm10year <- storm[storm$BGN_DATE>date, ]
head(storm10year$BGN_DATE, n=20)

fatalCount10year <- ddply(storm10year, .(EventTypeCode), summarize, fatalities = sum(FATALITIES))

injurCount10year <- ddply(storm10year, .(EventTypeCode), summarize, injuries = sum(INJURIES))



fatalTop10In10Year <- fatalCount10year[order(fatalCount10year$fatalities,decreasing = T)[1:10],] 
fatalTop10In10Year
injurTop10In10Year <- injurCount10year[order(injurCount10year$injuries,decreasing = T)[1:10],] 
injurTop10In10Year


# plot 

library(ggplot2)
library(gridExtra)

# Set the levels in order
p1 <- ggplot(data=fatalTop10,
             aes(x=reorder(EventTypeCode, fatalities ), y=fatalities , fill=fatalities)) +
        geom_bar(stat="identity") +
        coord_flip() +
        theme(axis.text.x = element_text(size=12, colour = rgb(0,0,0)))+
        theme(axis.text.y = element_text(size=12, colour = rgb(0,0,0)))+
        ylab("Total number of fatalities \n1950-2011") +
        xlab("Event type") +
        theme(legend.position="none")

p2 <- ggplot(data=injurTop10,
             aes(x=reorder(EventTypeCode, injuries), y=injuries, fill=injuries)) +
        geom_bar(stat="identity") +
        coord_flip() + 
        theme(axis.text.x = element_text(size=12, colour = rgb(0,0,0)))+
        theme(axis.text.y = element_text(size=12, colour = rgb(0,0,0)))+
        ylab("Total number of injuries \n1950-2011") +
        xlab("") +
        theme(legend.position="none")

p3 <- ggplot(data=fatalTop10In10Year,
             aes(x=reorder(EventTypeCode, fatalities ), y=fatalities , fill=fatalities)) +
        geom_bar(stat="identity") +
        coord_flip() +
        theme(axis.text.x = element_text(size=12, colour = rgb(0,0,0)))+
        theme(axis.text.y = element_text(size=12, colour = rgb(0,0,0)))+
        ylab("Total number of fatalities \n2001-2011\n") +
        xlab("Event type") +
        theme(legend.position="none")

p4 <- ggplot(data=injurTop10In10Year,
             aes(x=reorder(EventTypeCode, injuries), y=injuries, fill=injuries)) +
        geom_bar(stat="identity") +
        coord_flip() + 
        ylab("Total number of injuries \n2001-2011") +
        xlab("") +
        theme(axis.text.x = element_text(size=12, colour = rgb(0,0,0)))+
        theme(axis.text.y = element_text(size=12, colour = rgb(0,0,0)))+
        theme(legend.position="none")



grid.arrange(p1, p2, p3, p4, main="Harmful weather for health in the US \nTop 10 ")


# Economic Effects of Weather Events --------------------------------------

storm$PROPDMG[1:10]
storm$PROPDMGEXP[1:10]
levels(storm$PROPDMGEXP)

storm$PROPDMGEXP <- as.factor(toupper(storm$PROPDMGEXP))
storm$CROPDMGEXP <- as.factor(toupper(storm$CROPDMGEXP))

levels(storm$PROPDMGEXP)

exp_transform <- function(e) {
        # h -> hundred, k -> thousand, m -> million, b -> billion   
        #switch(e,'h'=2,'H'=2,0)
        if (e %in% c('H')) return(2)
        if (e %in% c('K')) return(3)
        if (e %in% c('M')) return(6)
        if (e %in% c('B')) return(9)
        if ((as.numeric(e)) %in% seq(1:8)) return(as.numeric(e)) 
        if (e %in% c('', '-', '?', '+')) return(-1)
        return(-2)
        
}

propDmgExp <- sapply(storm$PROPDMGEXP, FUN=exp_transform)
propDmgDollar <- as.numeric(storm$PROPDMG * (10 ** propDmgExp))
rm(propDmgExp)
cropDmgExp <- sapply(storm$CROPDMGEXP, FUN=exp_transform)
cropDmgDollar<- as.numeric(storm$CROPDMG * (10 ** cropDmgExp))
rm(cropDmgExp)

EcoDmg<- data.frame(BGN_DATE=storm$BGN_DATE, EventTypeCode=storm$EventTypeCode, propDmgDollar, cropDmgDollar)

PropDmgCost <- ddply(EcoDmg, .(EventTypeCode), summarize, propDmg = sum(propDmgDollar))
CropDmgCost <- ddply(EcoDmg, .(EventTypeCode), summarize, CropDmg = sum(cropDmgDollar))

PropDmgTop10 <- PropDmgCost[order(PropDmgCost$propDmg,decreasing = T)[1:10],] 
PropDmgTop10[1,1:2]

CropDmgTop10 <- CropDmgCost[order(CropDmgCost$CropDmg,decreasing = T)[1:10],] 
CropDmgTop10[1,1:2]



# 2001-2011
date <- as.POSIXct(strptime("01/01/2001 00:00:00", "%m/%d/%Y %H:%M:%S"))
EcoDmg10year <- EcoDmg[EcoDmg$BGN_DATE>date,]
dim(EcoDmg10year)


PropDmgCost10year <- ddply(EcoDmg10year, .(EventTypeCode), summarize, propDmg = sum(propDmgDollar))
CropDmgCost10year <- ddply(EcoDmg10year, .(EventTypeCode), summarize, CropDmg = sum(cropDmgDollar))

PropDmg10yearTop10 <- PropDmgCost10year[order(PropDmgCost10year$propDmg,decreasing = T)[1:10],] 
PropDmg10yearTop10[1,1:2]


CropDmg10yearTop10 <- CropDmgCost10year [order(CropDmgCost10year$CropDmg,decreasing = T)[1:10],] 
CropDmgTop10[1,1:2]

# plot 

library(ggplot2)
library(gridExtra)

# Set the levels in order
p1 <- ggplot(data=PropDmgTop10,
             aes(x=reorder(EventTypeCode, propDmg), y=log10(propDmg), fill=propDmg)) +
        geom_bar(stat="identity") +
        coord_flip() +
        ylab("Property damage Dollar cost(log10)\n1950-2011 ") +
        xlab("Event type") +
        theme(axis.text.x = element_text(size=12, colour = rgb(0,0,0)))+
        theme(axis.text.y = element_text(size=12, colour = rgb(0,0,0)))+
        theme(legend.position="none")


p2 <- ggplot(data=CropDmgTop10,
             aes(x=reorder(EventTypeCode, CropDmg), y=log10(CropDmg), fill=CropDmg)) +
        geom_bar(stat="identity") +
        coord_flip() + 
        ylab("Crop damage Dollar cost(log10)\n1950-2011") +
        xlab("") +
        theme(axis.text.x = element_text(size=12, colour = rgb(0,0,0)))+
        theme(axis.text.y = element_text(size=12, colour = rgb(0,0,0)))+
        theme(legend.position="none")


p3 <- ggplot(data=PropDmg10yearTop10,
             aes(x=reorder(EventTypeCode, propDmg), y=log10(propDmg), fill=propDmg)) +
        geom_bar(stat="identity") +
        coord_flip() +
        theme(axis.text.x = element_text(size=12, colour = rgb(0,0,0)))+
        theme(axis.text.y = element_text(size=12, colour = rgb(0,0,0)))+
        ylab("Property damage Dollar cost(log10)\n2001-2011 ") +
        xlab("Event type") +
        theme(legend.position="none")


p4 <- ggplot(data=CropDmg10yearTop10,
        aes(x=reorder(EventTypeCode, CropDmg), y=log10(CropDmg), fill=CropDmg)) +
        geom_bar(stat="identity") +
        coord_flip() + 
        theme(axis.text.x = element_text(size=12, colour = rgb(0,0,0)))+
        theme(axis.text.y = element_text(size=12, colour = rgb(0,0,0)))+
        ylab("Crop damage Dollar cost(log10) \n2001-2011") +
        xlab("") +
        theme(legend.position="none")

grid.arrange(p1, p2, p3, p4, main="Harmful weather events for Economic in the US \n Top 10 ")

