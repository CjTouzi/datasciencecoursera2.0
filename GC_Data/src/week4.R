
# Editing Text Variables --------------------------------------------------
camera <- read.csv("./data/cameras.csv")
names(camera)

tolower(names(camera))
splitNames <- strsplit(names(camera), "\\.")
splitNames[[5]]
splitNames[[6]]

mylist <- list(letters=c("A", "b", "C"),numbers=1:3, matrix(1:25,ncol=5))
head(mylist)
mylist[1]
mylist$letters
mylist[[1]]
splitNames[[6]][1]

firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)


reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews,2)

sub("_","",names(reviews),)

testName <- " this_is_a_test"
sub("_","",testName)
gsub("_","",testName)

grep("Alameda", camera$intersection)

table(grepl("Alameda", camera$intersection))
camera2 <- camera[!grepl("Alameda", camera$intersection)]

grep("Alameda", camera$intersection, value=TRUE)

grep("JeffStreet", camera$intersection)

library(stringr)

nchar("cheng Juan")
substr("Cheng Juan",1,7)

str_trim("Jeff     ")



# Regular Expression ------------------------------------------------------


# working with date -------------------------------------------------------

d1=date()
d1
class(d1)
d2= Sys.Date()
d2
class(d2)
format(d2, "%a %b %d")

x= c("1jan1960","2jan1960","31mar1960", "30jul1960");z=as.Date(x,"%d%b%Y")
z[1]-z[2]
as.numeric(z[1]-z[2])
weekdays(d2)
months(d2)
julian(d2)
library(lubridate);ymd("20140108")
mdy("08/04/2013")
dmy("03-04-1934")
ymd_hms("2011-08-03 10:14:23")
x=dmy(c("1jan2013","2jan2013","3jan2013","4jan2013"))
wday(x[1])
wday(x[1],label=TRUE)
