## Getting and Cleaning Data
## by Tomas Mawyin
## Course Project

## This script will help you clean the data obtained from:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## If you need more information on this script, please refer to:

setwd("~/Documents/Coursera/Getting and Cleaning Data")
# Uncomment below if you don't have the data.table package installed
# install.packages("data.table")
library(data.table)

##----------
# Let's start by getting the activity labels
activityLabels <- fread("UCI HAR Dataset/activity_labels.txt")
setnames(activityLabels,c("id","activity"))
# Chaning all activities to lower case
activityLabels$activity <- tolower(activityLabels$activity)

#----- TRAINING DATA SET
# Let's load TRAIN labels, add the column names, and add a column showing the condition (training)
train_labels <- fread("UCI HAR Dataset/train/y_train.txt")
setnames(train_labels,"id")
train_labels[,condition:="training"]
# We can match each label of the training data with the activity list:
# Using sapply we go over each element on the set, based on its value we create a new column that contains the corresponding activity
train_labels$activity <- sapply(train_labels$id, function(x) activityLabels$activity[activityLabels$id==x])

#----- TESTING DATA SET
# Let's load TEST labels, add the column names, and add a column showing the condition (testing)
test_labels <- fread("UCI HAR Dataset/test/y_test.txt")
setnames(test_labels,"id")
test_labels[,condition:="testing"]
# We can match each label of the testing data with the activity list
test_labels$activity <- sapply(test_labels$id, function(x) activityLabels$activity[activityLabels$id==x])

# Merging all the label data
# labels <- rbind(train_labels,test_labels)

