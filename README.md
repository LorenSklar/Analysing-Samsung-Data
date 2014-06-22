The run_analysis.R script modifies Samsung accelerometer and gyroscope data downloaded from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Each observation in the original dataset includes the following variables:
tBodyAcc-XYZ, 
tGravityAcc-XYZ, 
tBodyAccJerk-XYZ, 
tBodyGyro-XYZ, 
tBodyGyroJerk-XYZ, 
tBodyAccMag, 
tGravityAccMag, 
tBodyAccJerkMag, 
tBodyGyroMag, 
tBodyGyroJerkMag, 
fBodyAcc-XYZ, 
fBodyAccJerk-XYZ, 
fBodyGyro-XYZ, 
fBodyAccMag, 
fBodyAccJerkMag, 
fBodyGyroMag ,
fBodyGyroJerkMag 
where X, Y and Z denote three axial signals in the X, Y and Z directions.

Also included in the output data variable for
Subject, 
Activity_Code, 
Activity_Description.

The script does the following:
1) Merges training and test datasets from the original Samsung data.
2) Extracts the mean and standard deviation for each of the variables listed.
3) Converts activity codes to activity desciptions.
4) Calculates the mean of each variable grouping observations by subject then by activity.
