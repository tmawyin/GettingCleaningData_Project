## Getting & Cleaning Data Final Project

The goal of the project is to tidy up a large data file that was obtained by collection accelerometer data from a smartphone.

This repository contains the two main files: data_analysis.R and CodeBook.md

The data_analysis.R code does the following: 
* Merges the training and the test sets to create one data set.
* Extracts only those measurements that contain the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Generates a second, independent tidy data set with the average of each variable for each activity and each subject.

The tidy data is written into a file called tidyData.txt that can be read back to R using the command read.table("tidyData.txt",header=TRUE).

The data_analysis.R code is heavily commented and is divided into clear sections for readibilty purposes. Similarly, the code uses "Checkpoints" to ensure that process goes smoothly and to catch any possible errors. 

To execute the code make sure you have the data folder (UCI HAR Dataset) in the same working directory as the .R file

The CodeBook.md contains the following:
* A description of the raw data
* Description of the variables
* Explanations on any transformations applied to the data
* Any other work that was performed to clean up the data 
