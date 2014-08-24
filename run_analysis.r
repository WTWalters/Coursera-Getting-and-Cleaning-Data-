#run_analysis.R
#
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#
#Author:Whit Walters 


#Step 1
#setwd("C:/R/Cleaning/Project")
#wd<-getwd()
#wd
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
dim(trainData) 
head(trainData)
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
table(trainLabel)
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
testData <- read.table("/UCI HAR Dataset/test/X_test.txt")
dim(testData) 
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt") 
table(testLabel) 
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
joinData <- rbind(trainData, testData)
dim(joinData) 
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) 
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) 

# Step 2  
features <- read.table("./UCI HAR Dataset/features.txt")
dim(features)  
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) 
joinData <-joinData[, meanStdIndices]
dim(joinData) 
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # Remove the "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # Capitalize the  M
names(joinData) <- gsub("std", "Std", names(joinData)) # Capitalize the  S
names(joinData) <- gsub("-", "", names(joinData)) # Remove "-" in column names 

# Step 3
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# Step 4
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData) 
write.table(cleanedData, "merged_data.txt") # Write out the first dataset

# Step 5 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
subjectLen <- length(table(joinSubject)) 
activityLen <- dim(activity)[1] 
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanedData$subject
    bool2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}
head(result)
write.table(result, "data_with_means.txt") # Write out the 2nd dataset


#Postscript data check
# data <- read.table("./data_with_means.txt")
# data[1:12, 1:3]
