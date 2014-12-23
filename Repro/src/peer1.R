# Load data ---------------------------------------------------------------

library(data.table)
act <- data.table(read.csv("./data/activity.csv"))
head(act)
tail(act)
names(act)

# What is mean total number of steps taken per day? -----------------------

# a histogram of th etotal number of steps taken each

stepsPerDay=act[,sum(steps, ra.rm=TRUE), by=date]
stepsPerDay$date <- as.Date(stepsPerDay$date, "%Y-%m-%d")
setnames(stepsPerDay,"V1", "totalSteps")
names(stepsPerDay)

library(ggplot2)
ggplot(stepsPerDay, aes(x=date, y=totalSteps)) +
    geom_bar(fill="orange", stat="identity") +
    labs(x="Date", y="Total Steps", title="Total Steps per Day")


# create a time seqence
start <- as.POSIXct(act$date[[1]], )
interval <- 5
end <- start + as.difftime(1, units="days")
TimeSeq<-seq(from=start, by=interval*60, to=end)




mean(stepsPerDay$totalSteps, na.rm=TRUE)
median(stepsPerDay$totalSteps,na.rm=TRUE)

library(plyr)

# What is the average daily activity pattern? -----------------------------

# average steps for each interval 
stepsPerInterval <- ddply(act, .(interval), summarize, avgSteps=mean(steps, na.rm=TRUE))
stepsPerInterval<-cbind(stepsPerInterval, timeSeq=TimeSeq[1:288])
plot(stepsPerInterval$timeSeq, stepsPerInterval$avgSteps, type="l")

# Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
 
maxstepsPerInterval <- stepsPerInterval$timeSeq[which.max(stepsPerInterval$avgSteps)]
strftime(maxstepsPerInterval, format="%H:%M:%S")


#  Imputing missing values ------------------------------------------------


# How many missing data? 
sum(is.na(act$steps),na.rm=FALSE)/length(act$steps)

# Devise a strategy for filling in all of the missing values in the dataset. 
# The strategy does not need to be sophisticated. 
# For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

# 3. Create a new dataset that is equal to the original dataset but with the missing data filled in.
MisRemovedAct <- act



# use mean for that 5-minute interval 
MisRemovedAct$steps[is.na(MisRemovedAct$steps)] <- mean(MisRemovedAct$steps, na.rm= TRUE)


# check imputing missing values
sum(is.na(MisRemovedAct$steps),na.rm=FALSE)



# and report the mean and median total number of steps taken per day. 
stepsPerDayNew=MisRemovedAct[,sum(steps, ra.rm=TRUE), by=date]
stepsPerDayNew$date <- as.Date(stepsPerDayNew$date, "%Y-%m-%d")
setnames(stepsPerDayNew,"V1", "totalSteps")
names(stepsPerDayNew)
cat("new mean:",mean(stepsPerDayNew$totalSteps))
cat("\t\told mean:",mean(stepsPerDay$totalSteps,na.rm=TRUE))
cat("new median:", median(stepsPerDayNew$totalSteps))
cat("\t\told median: ", median(stepsPerDay$totalSteps,na.rm=TRUE))


# make a histogram of the total number of steps taken each day and Calculate 
library(ggplot2)
ggplot(stepsPerDayNew, aes(x=date, y=totalSteps)) +
        geom_bar(fill="orange", stat="identity") +
        labs(x="Date", y="Total Steps", title="Total Steps per Day after Missing Data Imputting")

stepsPerDayNew$date[which.max(stepsPerDayNew$totalSteps)]
max(stepsPerDayNew$totalSteps)


# Do these values differ from the estimates from the first part of the assignment? 
# What is the impact of imputing missing data on the estimates of the total daily number of steps?
# median increase a little 




# Are there differences in activity patterns between weekdays and  and weekends -------

# For this part the weekdays() function may be of some help here. 
# Use the dataset with the filled-in missing values for this part.
# 
# Create a new factor variable in the dataset with two levels - 
# "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.

# set back to english in windows

Sys.setlocale("LC_TIME", "English")

MisRemovedAct$isWeekend <- ifelse(weekdays(as.Date(MisRemovedAct$date)) %in% 
                                      c("Saturday", "Sunday"), "weekend", "weekday")
MisRemovedAct$isWeekend<-as.factor(MisRemovedAct$isWeekend)


# average steps for each interval 
library(plyr)

stepsPerIntervalWeekday <- ddply(MisRemovedAct[MisRemovedAct$isWeekend=="weekday"], .(interval), summarize, avgSteps=mean(steps))

stepsPerIntervalWeekend <- ddply(MisRemovedAct[MisRemovedAct$isWeekend=="weekend"], .(interval), summarize, avgSteps=mean(steps))

# Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) 
# and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). 
library(ggplot2)
require(gridExtra)



p1 <- 
    ggplot(stepsPerIntervalWeekend, aes(x=TimeSeq[1:288], y=avgSteps)) +
    xlab("Time")+
    geom_line()+
    ggtitle("Weekend")+
    theme(plot.title = element_text(lineheight=0.8, face=quote(bold)))+
    theme(axis.text.x = element_text(size=12, colour = rgb(0,0,0)))+
    theme(axis.text.y = element_text(size=12, colour = rgb(0,0,0)))+
    theme(axis.title.y = element_text(size=17,  face=quote(bold), colour = rgb(0,0,0)))+
    theme(axis.title.x = element_text(size=17,  face=quote(bold), colour = rgb(0,0,0)))

p2 <- 
    ggplot(stepsPerIntervalWeekday, aes(x=TimeSeq[1:288], y=avgSteps)) +
    xlab("Time")+
    geom_line() +
    ggtitle("Weekday")+
    theme(plot.title = element_text(lineheight=0.8, face=quote(bold)))+
    theme(axis.text.x = element_text(size=12, colour = rgb(0,0,0)))+
    theme(axis.text.y = element_text(size=12, colour = rgb(0,0,0)))+
    theme(axis.title.y = element_text(size=17,  face=quote(bold), colour = rgb(0,0,0)))+
    theme(axis.title.x = element_text(size=17,  face=quote(bold), colour = rgb(0,0,0)))

grid.arrange(p1, p2, ncol=1)













