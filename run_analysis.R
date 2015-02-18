# Farrokh GHAMSARY
# fghamsary@gmail.com
# This program is part of a project for "Getting and Cleaning Data" course in
# coursera https://class.coursera.org/getdata-011/
#
#
# Here we set the directory to the root of the dataset, as in the compressed
# file if we just decompress it and put this file outside of any directory,
# the directory should be "UCI HAR Dataset"
setwd("./UCI HAR Dataset")
# now check to see if the directory is set correctly.
getwd()
# the result of the following line should be the list if files and directories
# as were in the compressed file:
# [1] "activity_labels.txt" "features.txt"        "features_info.txt"
# [4] "README-New.txt"      "README.txt"          "test"
# [7] "train"
dir()
if (!all(c("activity_labels.txt", "features.txt", "train", "test") %in%
      dir())) {
  stop("The directory structure is not the same as the main archive!")
}

# if th result is the same 7 element string array then we are good to go.

# loading the libraries need for this project
checkLibs <- function(name) {
  notInstalled <- name[!(name %in% rownames(installed.packages()))]
  if (length(notInstalled) > 0)
    install.packages(notInstalled)
}
checkLibs(c("plyr"))#, "dplyr", "tidyr"))
library(plyr)


#########################################################################
# train file should be in directory "train/X_train.txt" and "train/Y_train.txt"
# so we read the train data
# first we are going to read the name of features
feature_names <- read.table("features.txt")
# now we check which indexes are for the features we want as stated in the task:
# 2.  Extracts only the measurements on the mean and standard deviation
#     for each measurement. 
feature_needed_indexes <- grep(".*(mean)|(std).*", feature_names$V2)
feature_classes <- as.list(rep("NULL", length(feature_names$V2)))
names(feature_classes) <- paste0("V", 1:length(feature_names$V2))
feature_classes[feature_needed_indexes] <- "double"

# read activity lables as they are needed in the next part
activity_labels <- read.table("activity_labels.txt")
# can use activity_labels as a dictionary to change the Y values, even if 

# in feature_classes we have the classes of all the variables that are
# needed to be read and if they are not important for us we don't read them
# "NULL" as the class
#
# read all data of train to the data.frame
train_data_x <- read.table("train/X_train.txt",
                           colClasses = feature_classes)
# set the column names as they should be
# this part is done because of project requirements:
#   4.Appropriately labels the data set with descriptive variable names. 
colnames(train_data_x) <- feature_names$V2[feature_needed_indexes]

# read all y (target variable) type of activity as well.
train_data_y <- read.table("train/y_train.txt")
# chaning train_data_y (the target variable) activity as a factor vector
# as needed for the point of project:
#   3.Uses descriptive activity names to name the activities in the data set
train_data_y <- activity_labels[train_data_y$V1, 2]

# read the subject of the data as needed in the point 5 of the task
train_data_subject <- scan("train/subject_train.txt")

# combine X an Y variables with the activity labels as activity attribute
# in the new dataset, activity is a factor variable
# also as it is needed in task 5 the subject is also added to this dataset
train_data <- cbind("subject" = train_data_subject,
                    "activity" = train_data_y,
                    train_data_x)



# now read the test data to another data.frame
test_data_x <- read.table("test/X_test.txt",
                          colClasses = feature_classes)
# seting the column names by the attributes selected (mean and std s...)
# this part is done because of project requirements:
#   4.Appropriately labels the data set with descriptive variable names. 
colnames(test_data_x) <- feature_names$V2[feature_needed_indexes]

# read all y (target variable) type of activity as well.
test_data_y <- read.table("test/y_test.txt")
# the same way as above changing test_data_y to descriptions with factor
test_data_y <- activity_labels[test_data_y[1,], 2]

# read the sobject of test data as it is needed in point 5 of the task
test_data_subject <- scan("test/subject_test.txt")

# I did the same for the test set, adding the activity column to it as a factor
# also as it is needed in task 5 the subject is also added to this dataset
test_data <- cbind("subject" = test_data_subject,
                   "activity" = test_data_y,
                   test_data_x)


##### Now joining the two datasets together in a new data.frame
# this part is done because of task detail:
#   1.Merges the training and the test sets to create one data set.
all_data <- rbind(train_data, test_data)

write.table(all_data, "allData.txt", row.names = FALSE)

# exporting the CodeBook.md file the column index and name
write.table(cbind(Index = 1:length(all_data), VariableName = colnames(all_data)),
            "CodeBook.md", row.names = FALSE)

# changing subject to factor as we need to do a group by on it later
all_data$subject <- as.factor(all_data$subject)
# Note: as it was not mentioned in the task I didn't add another extra column,
# which will show each row is for training set or test set, but it could have
# been done if it was important for us.

# Note2: the activity type could have been changed to a factor as well, but
# it was not mentioned in the task detail

# now that we have our all_data data.frame with all the desired attirbutes and
# data and training set together, I'm going to remove all unnecessary variables
# for memory saving
rm(list = ls()[ls() != "all_data"])



#######################################################################
# here we have only one variable in the environment list which is called
# all_data including all the fatures of means and standard deviations plus the
# activity label as the last column-1 "activitiy" which is a factor and the 
# last column as subject of the test
#######################################################################


tidyData <- ddply(all_data, .(subject, activity), function(x) {
    colMeans(subset(x, select = -c(subject,activity)))
  })

write.table(tidyData, "tidyData.txt", row.names = FALSE)
# now write the table in the file for uploading

# in my opinion having each variable in the column is a tidy data.
# but there is another way to interpret this situation
# we can have the variable name in a column and the value of that variable
# in another column (this is another approach) but not sure which one is the
# result that I should give, but I'll go with my gut and let the above code
# be the tidyData as each variable is on a column although.

#library(dplyr)
#library(tidyr)
#td <- tbl_df(tidyData)
#tidyData2 <- td %>%
#  gather(variableName, MeanOfVariable, -c(subject, activity)) %>%
#  arrange(subject, activity)

#write.table(tidyData2, "tidyData2.txt")

#tidyData2[tidyData2$variableName == "tBodyAcc-mean()-X" &
#            tidyData2$activity == "LAYING",]