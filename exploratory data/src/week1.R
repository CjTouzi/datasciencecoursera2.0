# principles of analytic grphics

# principle 1: Show comparisons
 # -eveidence for a hypothesis is always compar
 # - ask compare to what 

# principle 2: show causality, mechanism, explantion, systematic structure
 # what do you think

# principle 3: show multivariate data
 # - Multivariate = more than 2 variables
 # - the real world is multivariate 

# principle 4: integration of evidence
 # - completedly integrate words, numbers, images, diagrams
 # - Data graphs

# principle 5: Descibe and document the evident with appropriate labels,scales, sources

# principle 6: Content is king

# 1 Dimensions simple summary methods 

con <- unzip("./data/PM25data.zip")
pollution <- read.csv(con, colClasses =c ("numeric", "character","factor","numeric","numeric"))
unlink(con)
head(pollution)

# five-number summary 
# boxplots
# histograms
# desity plot
# barplot

summary(pollution$pm25)
boxplot(pollution$pm25, col="blue")
abline(h=12)
hist(pollution$pm25,col="green", breaks=10)
abline(v=12,lwd=2)
rug(pollution$pm25)

barplot(table(pollution$region), col="wheat", main =" Number of Countires in Each Region")


# two dimensions

boxplot(pm25~region, data=pollution, col="red")
par(mfrow= c(2,1), mar= c(4,4,2,1))
hist(subset(pollution, region == "east")$pm25, col="green")
hist(subset(pollution, region == "west")$pm25, col="green")
par(mfrow=c(1,1))
with(pollution, plot(latitude, pm25, col=region))
abline(h=12,lwd=2,lty=2)

# lattice plot
library(lattice)
state <- data.frame(state.x77, region= state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout=c(4,1))

# ggplot2
library(ggplot2)
data(mpg)
qplot(displ, hwy, data=mpg)

library(datasets)
hist(airquality$Ozone)
with(airquality, plot(Wind,Ozone))
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab="Month", ylab="Ozone (ppb)")
par("lty")
with(airquality, plot(Wind, Ozone))
title(main = "Ozone in New York")
with(airquality, plot(Wind, Ozone, main="Ozone in New Yor"))
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))
with(airquality, plot(Wind, Ozone, main="Ozone in New Yory"), type="n")
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month!=5), points(Wind, Ozone, col="red"))
legend("topright", pch=1, col=c("blue","red"),legend=c("May","Other Month"))

with(airquality, plot(Wind, Ozone, main="Ozone in New Yor"), pch=20)
model <- lm(Ozone ~Wind,airquality)
abline(model, lwd=2)

par(mfrow=c(1,2), oma=c(0,0,2,0))
with(airquality, {
    plot(Wind,Ozone, main="Ozone and Wind")
    plot(Solar.R,Ozone, main="Ozone and Solar")
    mtext("Weather", outer=TRUE)
})

x <- rnorm(100)
hist(x)
y <- rnorm(100)
plot(x,y)
par("mar")
example(points)
title("scatter plot")
legend("topleft", legend = "Data", pch=1)
fit <- lm(y~x)
abline(fit, col="blue", lwd=3)
plot(x, y, xlab="x", )

x <- rnorm(100)
y <- rnorm(100)
g <- gl(2,50)
g <- gl(2,50, labels =c("Male", "Female"))
str(g)

plot(x, y, type = "n")
points(x[g=="Male"], y[g=="Male"], col="green")
points(x[g=="Female"], y[g=="Female"], col="blue", pch=19)
?devices

# pdf 
# svg
# postcript

# Bitmap
# png
# jpeg
#tiff
# bmp



pdf(file ="myplot.pdf")
with(faithful, plot(eruptions, waiting))
title(main="Old")
dev.off()

dev.copy(png, file="gey.png")
dev.off()
