
file <- "D:/GitHub//datasciencecoursera2.0/Repro/reports/repdata-data-StormData.csv.bz2" 
databz <- bzfile(file, "r")
storm <- read.csv(databz)
unlink(databz)