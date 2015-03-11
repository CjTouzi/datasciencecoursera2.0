source("NLPfuncs.R")

# count lines of en_US.twitter.txt 
f <- file("./Coursera-SwiftKey/final//en_US//en_US.twitter.txt", open="rb")
lineCounter(f)

chunk <- readBin(f, "raw", 65536)
length(chunk)
