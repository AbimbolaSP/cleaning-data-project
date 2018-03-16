CODEBOOK for Cleaning and Getting Data Project 
Description of Project Datasets and Data Processing
Datasets	Description of datasets	Code 	Remarks 
Train datasets	Original datasets from raw text files for subjects in the train group		
1.	Subject_train	Contains subject identifiers for  subjects in the train-group	Its range is from 1 to 30	Read into R as an object called subject_train
2.	X_train	Contain a 561- feature vector measured as time and frequency from the accelerometer and gyroscope 3-axial raw signals for subjects in the train-group		 Read into R as an object called train_set and given  column names from the features.txt file
3.	y_train	Activity_class for train-group	1=Walking
2=Walking_upstairs
3=Walking downstairs
4=Sitting
5=Standing
6=Laying
	Read into R as an object called activity_train and linked with activity labels (as described under code)
Test datasets	Original datasets from raw text files for test group		
1.	Subject_test	Contain subject identifiers for test group	Its range is from 1 to 30	Read into R as an object called subject_test
2.	X_test	Contain a 561- feature vector measured as time and frequency from the accelerometer and gyroscope 3-axial raw signals for the subjects in the test group		 Read into R as an object called test_set and given  column names from the features.txt file
3.	y_test	Contain activity_class for test group	1=Walking
2=Walking_upstairs
3=Walking downstairs
4=Sitting
5=Standing
6=Laying
	Read into R as an object called activity_test and linked with activity labels (as described under code)
Derived datasets	Datasets derived from original raw datasets above		
train_data	Derived as a single dataset for the train group by combining subject_train, train_set and activity_train datasets		
test_data	Derived as a single dataset for the test group by combining subject_test, test_set and activity_test datasets		
merged_data	Dataset combining both the test_data and train_data so that information from both test and train groups are now together in one dataset.		
merged_data_means_std	Dataset containing only the mean and standard deviation measurements 		Extracted from merged_data
mean_activity_data	Second independent tidy data obtained by averaging each variable in merged_data_means_std for each activity and subject. 		


