file <- unzip("./data/exdata-data-household_power_consumption.zip")

epc <- read.csv("./household_power_consumption.txt", header = T, sep=";", na.strings="?", nrows=108000,  check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
head(epc)
names(epc)
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")

epc07 <- subset(epc, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
head(epc07)
tail(epc07)
rm(epc)
dateTime <- paste(as.Date(epc07$Date),epc07$Time)
head(dateTime)
epc07$dateTime <- as.POSIXct(dateTime)
head(epc07)


Sys.setlocale("LC_TIME", "English")

# plot3
par(mfrow = c(1,1))
with(epc07, {
    plot(Sub_metering_1 ~ dateTime, type="l", ylab="Global Active Power (killowatts)",xlab="" )
    lines(Sub_metering_2 ~ dateTime, col="red")
    lines(Sub_metering_3 ~ dateTime, col="blue")
    
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))