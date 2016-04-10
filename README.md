# Getting and Cleaning Data: Course Project

This file descipe the script in the run_analysis.R file

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script from the run_analysis.R file dose the following:

1. Downloads the data
2. Unzips data
3. Changes working directory to work wit downloaded data
4. Merges the training and the test sets to create one data set
5. Extracts only the measurements on the mean and standard deviation for each measurement
6. Uses descriptive activity names to name the activities in the data set
7. Appropriately labels the data set with descriptive variable names
8. Creates tidy data set with the average of each variable for each activity and each subject
9. Returns to the previous working derictory
10. Saves tidy data set in the txt file
