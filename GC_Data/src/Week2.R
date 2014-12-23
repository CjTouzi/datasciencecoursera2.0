
# Reading from MySQL ------------------------------------------------------

# Data are structured in 

    # databasees
    # Tables within databases
    # Fields within tables

# each row is called a record


# install mySQL5.5-32bit
# http://biostat.mc.vanderbilt.edu/wiki/Main/RMySQL
# http://subhayan-mukerjee.blogspot.sg/2014/09/installing-rmysql-in-windows-to-connect.html

library(RMySQL)
ucscDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);
head(result)

hg19 <- dbConnect(MySQL(), user="genome", db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n=10); dbClearResult(query);
dim(affyMisSmall)
names(affyMisSmall)
dbDisconnect(hg19)


# HDF5 --------------------------------------------------------------------

# source("http://bioconductor.org/biocLite.R")
# biocLite("rhdf5")

# create a hdf5 file
library(rhdf5)
created = h5createFile("example.h5")

# create some groups
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

# write to groups
A = matrix(1:10, nr=5, nc=2)
A
h5write(A, "example.h5", "foo/A")
h5ls("example.h5")
B = array(seq(0.1, 2.0, by= 0.1), dim=c(5,2,2))
B
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

# write a data set 

df = data.frame(1L:5L, seq(0,1, length.out = 5), c("ab","cde", "fghi", "a","s"), stringsAsFactors = FALSE)
h5write(df, "example.h5","df")
h5ls("example.h5")

# reading data 
readA =h5read("example.h5", "foo/A")
readA

# writing and reading chunks
# index = list(rows, cols)

h5write(c(12,13,14),"example.h5","foo/A", index=list(1:3,1))
h5read("example.h5", "foo/A")


# Reading data from Web ---------------------------------------------------

# reading page: how netflix reverse engineered hollywood
# http://www.theatlantic.com/technology/archive/2014/01/how-netflix-reverse-engineered-hollywood/282679/2/

# web_scraping 


# getting data off webpages - readLines()

con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode =readLines(con)
close(con)
htmlCode

#  using XML
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td", xmlValue)

# GET from the httr package 
library(httr)
html2 =GET(url)
content2 =content(html2,as="text")
parsedHtml=htmlParse(content2, asText=T)
xpathApply(parsedHtml, "//title", xmlValue)

# accessing websites with passwords 
# without user name & password
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1

# with user name & pasword
pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user","passwd"))
pg2
names(pg2)


# using handles 

google= handle("http://google.com")
pg1 =GET(handle = google, path="/")



# API(application programming interface -----------------------------------

# access twitter
myapp = oauth_app("cjtouzi", key="kN7JqH2CpqJOuj9LqciWi6xCs", secret="Rkk8LEIM37P7QmHPJamQOKiFTVDOS6ukdYJK2EK6dets5b69DZ")
sig=sign_oauth1.0(myapp, token="2665373822-lNYD4qtK90jFFkZYRb6Vp9OvSYKCmFiu7T8jADP", token_secret="ekiJTeZNtQXY6qYBCfzw2y4vfINHvYRK8sitRpXQBByGQ")
homeTL=GET("https://api.twitter.com/1.1/statuses/home_timeline.json",sig)
json1=content(homeTL)
head(json1)
json2=jsonlite::fromJSON(toJSON(json1))
json2

# How to did I know what url to use? 
# https:// dev.twitter.com/docs/api/1.1/overview


# In general look at the documentation ------------------------------------

    # httr allows GET, POST, PUT, DELETE requests if you are authorized
    # you can authenticate with a user name or a password
    # most modern APIs use something like oauth
    # httr works well with Facebook, Google, Twitter, GIthub etc.


# Read from other sources -------------------------------------------------













