# cleaning-data-project
Repo for project on cleaning and getting data course
This repo describes the processes undertaken for preparing two tidy independent datatsets from the UCI HAR Dataset using R as part of the cleaning and getting data course. The UCI HAR datasets, which was downloaded from the web, included various text files containining data for two groups of subjects: a) those who participated in a training excercise and b) those involved in the test exercise.

The following task were undertaken as discussed below:

#1. Merging the training and the test sets to create one data set:
The subject_train.txt, y_train.txt and X_train.txt files were read into R using the read.table function. The features.txt file was also read into R using the readLines function to utilize the variables names in the feature file as column headers for the the 561 variables in the X_train dataset.These datasets were then combined together to form a single train dataset using the cbind() function. The same process was repeated for the subject_test.txt, y_test.txt and X_test.txt files, thereby obtaining a single test dataset. Thereafter, the two single datasets (train_data and test_data) were combined into a single dataset (merged_data) using the rbind() function.

#2. Extractung only the measurements on the mean and standard deviation for each measurement: 
Using the grep function, names of variables having the regular pattern for "mean" and "std"  were identified and saved as new variables. These new variables were now selected along with subjectid and activity variables to obtain a new dataset using the select() function in the dplyr package. 

#3. Uses descriptive activity names to name the activities in the data set:
The categories in the variable activity were appropriately labelled using the factor function with reference to the description in the activity_label text file.

#4. Appropriately labels the data set with descriptive variable names:
Characters (e.g. "t", "f") were searched for in the names of variables using literals and metacharacters and substituted with more descriptive terms (e.g. "time", "frequency") using the sub() function.

#5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
This was achieved by first using the group_by() function in the dplyr package to group the data by the subjectid and activity variables. Then the summarise_at() function in the syntax helped to calculate the means according to the grouping.
