

# Load data ---------------------------------------------------------------

file <- "D:/GitHub//datasciencecoursera2.0/Repro/data/repdata-data-StormData.csv.bz2" 
if (!file.exists(file)) {
        url <- "http://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
        download.file(url, file,  method = "auto")
} else {message("StormData.csv.bz2.zip already exists")}        

databz <- bzfile(file, "r")
storm <- read.csv(databz)
head(storm)
unlink(databz)




library(dplyr)
storm_clean <- select(storm, EVTYPE, FATALITIES, INJURIES, PROPDMG, PROPDMGEXP,CROPDMG, CROPDMGEXP)
                       
# data cleaning -----------------------------------------------------------
# translate all letters to lowercase
storm_clean$EVTYPE <- tolower(storm_clean$EVTYPE)

# The documentation says there are 48 Event Types, 
# but due to different ways of saying the same thing as well as typos, 
# there are over 890 event types.

# remove the space at the beginning
# returns string w/o leading whitespace
trim.leading <- function (x)  sub("^\\s+", "", x)
storm_clean$EVTYPE <- trim.leading(storm_clean$EVTYPE)
length(sort(unique(storm_clean$EVTYPE)))

# classify 
# "avalanche"
storm_clean$EVTYPE <- sub("avalance", "avalanche", storm_clean$EVTYPE)
storm_clean$EVTYPE <- sub("avalance", "avalanche", storm_clean$EVTYPE)
storm_clean$EVTYPE <- sub("accumulated snowfall", "avalanche", storm_clean$EVTYPE)

# "Blizzard"
storm_clean$EVTYPE <- sub("^blizz.*", "blizzard", storm_clean$EVTYPE)

# "Coastal Flood"
storm_clean$EVTYPE <- sub("^coastal.*", "Coastal Flood", storm_clean$EVTYPE)

# Cold/Wind Chill
storm_clean$EVTYPE <- sub(".*cold.*", "Cold/Wind Chill", storm_clean$EVTYPE)

# Debris Flow
storm_clean$EVTYPE <- sub("cold.*", "Cold/Wind Chill", storm_clean$EVTYPE)

# dust devil
storm_clean$EVTYPE <- sub(".*microburst.*", "dust devil", storm_clean$EVTYPE)
storm_clean$EVTYPE <- sub("^dust devil.*", "dust devil", storm_clean$EVTYPE)
storm_clean$EVTYPE <- sub("^dust devel.*", "dust devil", storm_clean$EVTYPE)

# Drought
storm_clean$EVTYPE <- sub("^drought.*", "drought", storm_clean$EVTYPE)

# Excessive Heat 



length(sort(unique(storm_clean$EVTYPE)))
sort(unique(storm_clean$EVTYPE))









