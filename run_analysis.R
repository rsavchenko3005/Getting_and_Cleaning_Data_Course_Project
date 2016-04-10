#########################################################################################
# Here are the data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#########################################################################################
# Should create one R script called run_analysis.R that does the following:
#
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation
#    for each measurement.
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names.
# 5. From the data set in step 4, create a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
#########################################################################################

# Step 01: Download the data
zipUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipUrl, destfile = "ForProject.zip")


# Step 02: Unzip data
unzip("ForProject.zip", exdir = "./ForProject")


# Step 03: Change working directory
oldDir = getwd()
oldDir

setwd("./ForProject/UCI HAR Dataset")
newDir = getwd()
newDir


# Step 04: Merge the training and the test sets to create one data set
   # read training data
   train_subj <- read.table("./train/subject_train.txt")
   train_x <- read.table("./train/X_train.txt")
   train_y <- read.table("./train/y_train.txt")
   
   # combine all training data into one set
   train_all <- cbind(train_subj, train_y, train_x)
   
   # read test data
   test_subj <- read.table("./test/subject_test.txt")
   test_x <- read.table("./test/X_test.txt")
   test_y <- read.table("./test/y_test.txt")
   
   # combine all test data into one set
   test_all <- cbind(test_subj, test_y, test_x)
   
   # combine all training and all test data together
   data_all <- rbind(train_all, test_all)
   

# Step 05: Extract only the measurements on the mean and standard deviation
#         for each measurement
   # read data from the features.txt file
   features <- as.character(read.table("./features.txt")[, 2])
   
   # add names to the each column of the data_all set
   names(data_all) <- c("subjectID", "label", features)
   
   # create character vector of the names of data_all set columns
   names_list <- names(data_all)
   
   # create logical vector for columns that should be extracted
   right_names <- grepl("subjectID|label|-mean\\(\\)|-std\\(\\)", names_list)
   
   # extract columns
   extracted_data <- data_all[, right_names]
   
   
# Step 06: Use descriptive activity names to name the activities in the data set
   # read activity names from the activity_labels.txt file
   activity_names <- read.table("activity_labels.txt")
   
   # add names to each columns of activity_names set
   names(activity_names) <- c("label", "activity")
   
   # add descriptive activity names
   merged_data <- merge(extracted_data, activity_names, by = c("label"))
   
   # reorder columns
   final_data <- merged_data[, c(2, 1, ncol(merged_data), 3:(ncol(merged_data) - 1))]
   
# Step 07: Appropriately label the data set with descriptive variable names
   # was done at Step 05
   
# Step 08: From the data set in step 4, create a second, independent tidy data set
#          with the average of each variable for each activity and each subject
   # load plyr package
   library(plyr)
   
   # create data set with the average of each variable for each activity and subject
   average_data <- ddply(final_data, .(subjectID, activity), function(x) colMeans(x[, 4:69]))
   
   
# Step 09: Return to the previous working derictory
   setwd(oldDir)
   newDir <- getwd()
   newDir
   
   
# Step 10: Save tidy data set in the txt file
   write.table(average_data, "average_data.txt", row.name = FALSE)

