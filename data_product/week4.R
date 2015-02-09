
# Yhat --------------------------------------------------------------------

con <- unzip("./data/annual_all_2011.zip",exdir="./data")
d <- read.csv("./data/annual_all_2011.csv")
levels(d$Parameter.Name)
levels(d$Pollutant.Standard)
sub <- subset(d, Parameter.Name %in% c("PM2.5 - Local Conditions", "Ozone")
              & Pollutant.Standard %in% c("Ozone 8-Hour 2008", "PM25 Annual 2006"),
              c(Longitude, Latitude, Parameter.Name, Arithmetic.Mean))
str(sub)

pollavg <- aggregate(sub[,"Arithmetic.Mean"],
                     sub[,c("Longitude", "Latitude", "Parameter.Name")],
                    mean, na.rm=TRUE)
names(pollavg)[4] <- "level"
pollavg <- transform(pollavg, Parameter.Name = factor(Parameter.Name))
monitors <- data.matrix(pollavg[,c("Longitude", "Latitude")])

rm(d,sub)
unlink(con)


library(fields)

## Input is data frme with 
## lon: longitude
## lat: latitude
## radius: Radius in miles for finding monitors

pollutant <- function(df){
    
    x <- data.matrix(df[,c("lon","lat")])
    r <- df$radius
    d <- rdist.earth(monitors,x)
    use <- lapply(seq_len(ncol(d)), function(i){
        which(d[,i] < r[i])
    })
    levels <- sapply(use, function(idx){
        with(pollavg[idx,], tapply(level, Parameter.Name, mean))
    })
        dlevels<- as.data.frame(t(levels))
        data.frame(df,dlevels)

}

library(yhatr)

model.require <- function() {
    library(fields)
}

model.transform <- function(df) {
    
    df
    
}

model.predict <- function(df) {
    
    pollutant(df)
    
}

yhat.config <- c(username = "cjtouzi@gmail.com",
                 apikey = "c8ee5ba14c8bbccf031336f5bc408888",
                 env="http://sandbox.yhathq.com/")

yhat.deploy("pollutant")

# use yhat server function 
library(yhatr)
df <- data.frame(lat=39.28, lon=-76, radius=60)
df
yhat.config <- c(username = "cjtouzi@gmail.com",
                 apikey = "c8ee5ba14c8bbccf031336f5bc408888",
                 env="http://sandbox.yhathq.com/")
yhat.predict("pollutant", df)










