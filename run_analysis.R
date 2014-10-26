# 1. Merge the training and the test sets to create one data set.

## Read in data from the Training subset

subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subjectId"))

xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")

yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")

trainData <- cbind(yTrain, subjectTrain, xTrain)


## Reading in data from the Test subject

subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subjectId"))

xTest <- read.table("UCI HAR Dataset/test/X_test.txt")

yTest <- read.table("UCI HAR Dataset/test/y_test.txt")

testData <- cbind(yTest, subjectTest, xTest)


sensorData <- rbind(trainData, testData)



# 2. Extracting only the measurements on the mean and standard deviation for each measurement.

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("feature_id", "feature_label"))

features_mean_std <- features[grepl("mean\\(\\)", features$feature_label) | grepl("std\\(\\)", features$feature_label), ]

sensorData_mean_std <- sensorData[, c(c(1, 2, 3), features_mean_std$feature_id + 3)]


# 3. Using descriptive activity names to name the activities in the data set.

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity_label"))

activityData <- merge(sensorData_mean_std, activityLabels)


# 4. Appropriately labeling the data set with descriptive variable names.

features_mean_std$feature_label <- gsub("\\(\\)", "", features_mean_std$feature_label)
features_mean_std$feature_label <- gsub("-", ".", features_mean_std$feature_label)
for (i in 1:length(features_mean_std$feature_label)) {
    colnames(activityData)[i + 3] <- features_mean_std$feature_label[i]
}

labelData <- activityData


# 5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

drops <- c("ID","activity_label")
tidyData <- labelData[,!(names(labelData) %in% drops)]
tidyData <-aggregate(tidyData, by=list(subject = tidyData$subjectId, activity = tidyData$activity_id), FUN=mean, na.rm=TRUE)
drops <- c("subject","activity")
tidyData <- tidyData[,!(names(tidyData) %in% drops)]
tidyData = merge(tidyData, activityLabels)
write.csv(file="Tidydata.txt", x=tidyData)
