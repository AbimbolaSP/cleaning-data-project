
#Getting and cleaning data project

#This script performs the following tasks:
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the 
#   average of each variable for each activity and each subject.

#Task1. Merging the training and the test sets to create one data set - merged_data.

#Downloading data into local computer & working directory
setwd("D:/Courses/Data_Science_Coursera_Course")
if (!dir.exists("./UCI_datasets")) {dir.create("./UCI_datasets")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./UCI_datasets/datasets.zip")
unzip("./UCI_datasets/datasets.zip", exdir = "./UCI_datasets")
setwd("./UCI_datasets/UCI HAR Dataset")

ls()               #cleaning up workspace
rm(list = ls())

#Reading the train related datasets into R
subject_train <- read.table("train/subject_train.txt", col.names = "subject_id")                          #Subject identifiers
activity_train <- read.table("train/y_train.txt", col.names = "activity")                               #activity class
#To rename the variables in the X-train set while being read into R
features <- readLines("features.txt")
features2 <- gsub("^[0-9]*" ,"", features)
train_set <- read.table("train/X_train.txt", col.names = features2)

#Combining the above datasets into one dataset -"train_data"
train_data <- cbind(subject_train, train_set)
train_data <- cbind(activity_train, train_data)

#Reading the test related datasets into R
subject_test <- read.table("test/subject_test.txt", col.names = "subject_id")                          #Subject identifiers
activity_test <- read.table("test/y_test.txt", col.names = "activity")                               #activity class
test_set <- read.table("test/X_test.txt", col.names = features2)

#Combining the above datasets into one dataset -"test_data"
test_data <- cbind(subject_test, test_set)
test_data <- cbind(activity_test, test_data)

#Merging the train and test final datasets
merged_data <- rbind(train_data, test_data)
merged_data <- tbl_df(merged_data)    #Storing data as a tibble format


#Task 2. Extracts only the measurements on the mean and standard deviation for each measurement.

library(dplyr)
selected_meanvars <- grep("[Mm]ean", names(merged_data), value = TRUE) 
selected_stdvars <- grep("[Ss]td", names(merged_data), value = TRUE) 
merged_data_means_std <- merged_data %>% select(subject_id, activity, selected_meanvars,selected_stdvars)


#Task 3. Uses descriptive activity names to name the activities in the data set

merged_data_means_std$activity <- factor(merged_data_means_std$activity, labels = c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying"))

#4. Appropriately labels the data set with descriptive variable names

varnames <- names(merged_data_means_std)
varnames2 <- sub("^X(.)t","time", varnames)
varnames2 <- sub("^X(.)f", "frequency", varnames2)
varnames2<- sub("Acc", "acceleration", varnames2)
varnames2<- sub("Gyro", "angularvelocity", varnames2)
varnames2<- sub("[Mm]ag", "magnitude", varnames2)
varnames2 <- sub("angle.t", "angletime", varnames2)
varnames2 <- gsub("\\.|_", "", varnames2)
varnames2 <- sub("BodyBody", "Body", varnames2)
varnames2 <- tolower(varnames2)
names(merged_data_means_std) <- varnames2

#Task 5. From the data set in step 4, creates a second, independent tidy data set with the 
#   average of each variable for each activity and each subject.

mean_activity_data <- merged_data_means_std %>% group_by(subjectid, activity) %>%
  summarise_at(.vars = names(.) [3:88],
               .funs = c(mean = "mean"))

