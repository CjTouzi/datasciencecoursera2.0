# checking & creating directories 

if (!file.exists("data")){
    
    dir.create("data")
}

# download data from internet

fileUrl="https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/cameras.csv", method = "auto")

cameraData <- read.csv("./data//cameras.csv")
names(cameraData)
tolower(names(cameraData))
toupper(names(cameraData))
splitNames=strsplit(names(cameraData), "\\.")
splitNames[[6]]

mylist <- list (letters= c("a", "b", "c"), numbers = 1:3, mat=matrix(1:25, ncol=5))
head(mylist)
mylist[[1]]
splitNames[[6]][1]

# take the first elment function 
firstElement <- function(x) {x[1]}
sapply(splitNames, firstElement)

fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile="./data/reviews.csv", method="auto")
download.file(fileUrl2, destfile="./data/solutions.csv", method="auto")

reviews <-read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
names(reviews)

# sub&gsub ----------------------------------------------------------------

testName <- "this_is_a_test"
sub("_", "",testName)
gsub("_", "",testName)



# finding values -grep(), greppl() ----------------------------------------
head(cameraData$intersection,5)
grep("Alameda", cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),]
nrow(cameraData2)


# more on grep() ----------------------------------------------------------

grep("Alameda", cameraData$intersection, value=T)
# help(grep)
grep("Alameda", cameraData$intersection)


# more useful string functions --------------------------------------------

library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek", 1, 7)
substr("Jeffrey Leek", 1, 10)
paste("Jef","Leek")
paste0("Jef","Leek")
str_trim("Jeff     ")



# import points about text in data sets -----------------------------------

## Names of varibles should be
    # - all lower case when possible
    # - descriptive (Diagnosis versus Dx)
    # - not duplicated
    # - not have underscores or dots or white spaces

## variables with character values
    # - Should usually be made into factor variables (depends on application)
    # should be descriptive (use TRUE/FALSe instead of 0/1 and Male/Female versus 0/1 or M/F)



