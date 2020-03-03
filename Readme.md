The R script "run_analysis.R" expect the "UCI HAR Dataset" directory to be in the working directory.

All necessary files are loaded. 
That is:
X_test.txt
y_test.txt
subject_test.txt
X_train.txt
y_train.txt
subject_train.txt
features.txt
activity_labels.txt

Training and test sets are merged by rbinding X_test and X_train, y_test and y_train, and subject_test and subject_train respectively.

Information about the X features from features.txt is used to extract only those features from X, that are the mean or std of a measurement.
Any feature that includes "mean" or "std" is retained.

The same information features.txt is used to assign names to the variables of X.
special characters like colons, dots and parantheses are removed.

The variable in y is called "activity". 
The variable in subject "subject".

The information from activity_labels.txt is used to replace the values in the activity dataset, which have values 1 to 6, with appropriate activity labels.

A single data set is created by cbinding the x, y and subject data set.

To extract the average value for each measurement for each subject and each activity, we used the dplyr package to group the data set by subject and activity and then apply the mean function to all measurements, split by that grouping.

The result is saved as "tidy_data_set.txt"
