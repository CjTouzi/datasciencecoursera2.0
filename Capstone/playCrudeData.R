library(tm)
data("crude")
docs <- c("This is a text.", "This another one.")
VCorpus(VectorSource(docs))

# read & write ------------------------------------------------------------


reut21578 <- system.file("texts", "crude", package = "tm")
reuters <- VCorpus(DirSource(reut21578),
                   readerControl = list(reader = readReut21578XMLasPlain))
writeCorpus(reuters,path="./reuters/")




# show ----------------------------------
inspect(reuters[1:2])
print(reuters[1:2])
meta(reuters[[1]], "id")
names(reuters)
identical(reuters[[2]], reuters[["144"]])

# transformation ----------------------

# remove white space
reuters <- tm_map(reuters, stripWhitespace)

# lower cases
reuters <- tm_map(reuters, content_transformer(tolower))


# Removal of stopwords
reuters <- tm_map(reuters, removeWords, stopwords("english"))
tm_map(reuters, stemDocument)

# filter---------------------------------------------
idx <- meta(reuters, "id") == '237' &
    meta(reuters, "heading") == 'INDONESIA SEEN AT CROSSROADS OVER ECONOMIC CHANGE'
reuters[idx]
inspect(reuters[idx])

# meta data -------------------
DublinCore(crude[[1]], "Creator") <- "Ano Nymous"
meta(crude[[1]])
meta(crude, tag = "test", type = "corpus") <- "test meta"
meta(crude, type = "corpus")
meta(crude, "foo") <- letters[1:20]
meta(crude)
meta(crude, "foo", type="corpus") <- letters[1:20]
meta(crude)
meta(crude, type = "corpus")



# documentTermMatrix ------------------------------------------------------

dtm <- DocumentTermMatrix(reuters)
inspect(dtm[5:10, 740:743])
findFreqTerms(dtm, 20)
findAssocs(dtm, "opec", 0.8)
inspect(removeSparseTerms(dtm, 0.4))
plot(dtm, corThreshold = 0.1, weighting = TRUE)

# dictionary --------------------------------------------------------------

inspect(DocumentTermMatrix(reuters, list(dictionary = c("prices", "crude", "oil"))))



dtm <- as.matrix(dtm)
head(dtm)
dim(dtm)

# Converting subjects X articles to adjedcy matrix form-----------------
dtm <- as.matrix(dtm)
head(dtm)
dim(dtm)

dtm[dtm >= 1] <- 1
dtm <- t(dtm) %*% dtm
dtm[5:10, 5:10]


# closeness analysis-------------------------

closen <- closeness(g)
plot(closen, col = "red", xaxt = "n", lty = "solid", type = "b", xlab = "Words", 
     ylab = "closeness")
points(closen, pch = 16, col = "navy")
axis(1, seq(1, length(closen)), V(g)$name, cex = 5)


# Cluster -----------------------------------------------------------------

data("acq")
data("crude")
ws <- c(acq, crude)
print(ws)
# remove white space
library(dplyr)
ws <- c(acq, crude)
ws <- {
    ws %>%         
    tm_map(stripWhitespace) %>% 
    tm_map(content_transformer(tolower))  %>%
    tm_map(removeWords, stopwords("english"))  
}
print(ws)

# dtm
wsdtm <- DocumentTermMatrix(ws)
wsdtm <- as.matrix(wsdtm)
wskmeans <- kmeans(wsdtm, 2)
