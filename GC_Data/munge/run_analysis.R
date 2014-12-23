
# Merges the training and the test sets to create one data set ------------

# run_analysis.R is in the munge folder 


dataDir="./data/peer/"

# join x
x_train<- read.table(paste0(dataDir,"UCI HAR Dataset/train/X_train.txt"))
x_test <- read.table(paste0(dataDir,"/UCI HAR Dataset/test/X_test.txt"))
x_all <- rbind(x_train,x_test)
rm(x_train);rm(x_test)

# join y 

y_train <- read.table(paste0(dataDir,"/UCI HAR Dataset/train/y_train.txt"))
y_test <- read.table(paste0(dataDir,"/UCI HAR Dataset/test/y_test.txt"))
y_all <- rbind(y_train,y_test)
rm(y_train);rm(y_test)

# join subject

sub_train <- read.table(paste0(dataDir,"/UCI HAR Dataset/train//subject_train.txt"))
sub_test <- read.table(paste0(dataDir,"/UCI HAR Dataset/test/subject_test.txt"))
sub_all <- rbind(sub_train, sub_test)
rm(sub_test,sub_train)


# Extracts only the measurements on the mean and standard  ----------------

# read features

feature <- read.table(paste0(dataDir,"/UCI HAR Dataset/features.txt"))
head(feature)

# extract mean & standard deviation features
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", feature[, 2])
x_all <-x_all[, meanStdIndices]
x_name <- feature[meanStdIndices,2]
rm(feature)


# name with descriptive features
x_name <- gsub("\\(\\)", "", x_name) # remove "()"
names(x_all)<-x_name
names(x_all)


# Uses descriptive activity names to name the activities and subject in the data --------

act <- read.table(paste0(dataDir,"/UCI HAR Dataset/activity_labels.txt"))
act[, 2] <- tolower(act[, 2] )
act


# change int levels to desicriptive levels 

y_all_new<- act[y_all[,1],2]
y_all_new<-as.factor(y_all_new)

head(sub_all)
# add new varibales to x dataset
x_all<- cbind(y_all_new,sub_all, x_all)

# change to desciptive names 
names(x_all)[names(x_all)=="y_all_new"] <- "activity"
names(x_all)[names(x_all)=="V1"] <- "subject"
dim(x_all)

# write out the 1st dataset
write.table(x_all, paste0(dataDir,"/UCI HAR Dataset/merged_data.txt")

rm(act,sub_all,y_all)

# average of each variable for each activity and each subject. ------------

# From the data set in step 4, 
# creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

library(plyr)
dt <- data.frame(x_all)

# catcolwise

result <- ddply(dt, ~subject+activity, numcolwise(mean))
write.table(result, paste0(dataDir,"/UCI HAR Dataset/data_with_means.txt"),row.name=FALSE) # write out the 2nd dataset
result[,1:4]


