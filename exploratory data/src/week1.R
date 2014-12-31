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




