# GetDataProject
This is just a repository for the final project of the Getting and Cleaning Data course in coursera: https://class.coursera.org/getdata-011/
Project done by Farrokh Ghamsary (fghamsary@gmail.com)
The original data for this project can be downloaded from here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
or the coursera link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Just note that the data in the cloudfront is older than the UCI folder. But the same data, just the references are different.
Some new articles have been added to the README file of the UCI compressed file.

Files in this repository:
	1. run_analysis.R			(MD5: 0268e8856187bc7955ef35dae9e27983)
	2. README.md				
	3. CodeBook.md				(MD5: 15875b24f08f8de6ba14b969251bd4c5)
	4. features.txt				(MD5: fa3902d5c37dade96c27045a7151d13b)
	5. activity_labels.txt		(MD5: 1f4903cd48dfb2a1e40bc479333e73e9)
	6. allData.txt				(MD5: 247e229843838d5adfea138f3f080af4)
	7. tidyData.txt				(MD5: a2ffe74a13620498ad16c0e62c5e0280)

1. run_analysis.R
	Contains all the code that tidy the data, and created the tidyData.txt file.
	
	The transformations include reading the features which have "mean" or "std" in them. Which I've checked from the features.txt file, which indexes they have.
	Then by the read.table commands I've read only the attributes selected and then added the subject and activity names from two other files in the train and test
	set.
	All the codes have been commented in the R file as well.
	At last by using "plyr" package I've created the mean of attributes.
	
2. README.md
	Current file which contains some general data of this repository.

3. CodeBook.md
	The list of variables in the dataset created all_data.txt and also tidyData.txt
	
4. features.txt
	The original data features list which was on the compressed file.
	
5. activity_labels.txt
	The original data of activity labels in the compressed file.
	
6. allData.txt
	The result of the task 4 of the project.
	
7. tidyData.txt
	The result of the tidy data of task number 5.
	

The original task details:
	You should create one R script called run_analysis.R that does the following. 
		1.Merges the training and the test sets to create one data set.
		2.Extracts only the measurements on the mean and standard deviation for each measurement. 
		3.Uses descriptive activity names to name the activities in the data set
		4.Appropriately labels the data set with descriptive variable names. 
		5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Peace (Farrokh Ghamsary - fghamsary@gmail.com)