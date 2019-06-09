##Download data file to desktop
if (!exists("./data")) {
    dir.create("./data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/UCI-HAR-dataset.zip", method = "curl")
unzip("./data/UCI-HAR-dataset.zip")


##Merge training and test sets to create one data set
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("index", "feature"))

#Read and bind training and test sets; variable names are adopted from features table
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
x <- rbind(xTrain, xTest)

#Read and bind training and test activities
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity")
y <- rbind(yTrain, yTest)

#Read and bind training and test subjects
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subjects <- rbind(subjectTrain, subjectTest)

#Bind x, y and subjects
data <- cbind(y, subjects, x)


##Extract measurements on the mean and standard deviation
#Only arithmetic mean variables are extracted
library(dplyr)
dataLean <- data %>%
  as_tibble() %>%
  select(activity, subject, contains(".mean."), contains(".std."))
rm(list = ls()[!(ls() %in% "dataLean")])


##Use descriptive activity names for activities
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("index", "activity"))
dataLean$activity <- activities[dataLean$activity, 2]


##Use descriptive variable names
colNamed <- names(dataLean) %>%
  gsub("^t", "time", .) %>%
  gsub("^f", "frequency", .) %>%
  gsub("Acc", "Acceleration", .) %>%
  gsub("Gyro", "Gyroscope", .) %>%
  gsub("Mag", "Magnitude", .) %>%
  gsub("BodyBody", "Body", .) %>%
  gsub("mean", "Mean", .) %>%
  gsub("std", "Std", .)
colnames(dataLean) <- colNamed


##Create independent data set which averages each variable for each activity and subject
dataTidy <- dataLean %>%
  group_by(activity, subject) %>%
  summarise_all(mean, na.rm = TRUE)
write.table(dataTidy, file = "./data/dataTidy.txt", row.names = FALSE)