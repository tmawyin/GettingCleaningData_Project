## Getting and Cleaning Data
## by Tomas Mawyin
## Course Project

## This script will help you clean the data obtained from:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## If you need more information on this script, please refer to the Cookbook

setwd("~/Documents/Coursera/Getting and Cleaning Data")
# Uncomment below if you don't have the data.table package installed
# install.packages("data.table")
library(data.table)

##----- ACTIVITY LABELS
# Loading the activity labels
activity.labels <- fread("UCI HAR Dataset/activity_labels.txt")
# Changing column names
setnames(activity.labels,c("id","activity"))
# Changing all activities to lower case
activity.labels$activity <- tolower(activity.labels$activity)
activity.labels$activity[2] <- "walkingUp"
activity.labels$activity[3] <- "walkingDown"

##----- FEATURES
# Loading the list of features
features <- fread("UCI HAR Dataset/features.txt")
# Changing column names
setnames(features,c("id","feature"))

#----- TRAINING DATA SET
# Loading the TRAIN LABLES and changint the column name as "id"
train.labels <- fread("UCI HAR Dataset/train/y_train.txt")
setnames(train.labels,"id")
# Matching each id of the training_labels data with the activity list
train.labels[,activity:=factor(train.labels$i, labels=activity.labels$activity)]
# Adding a new column showing the condition (training)
train.labels[,condition:="training"]

# Loading the participant vector
train.part <- fread("UCI HAR Dataset/train/subject_train.txt")
setnames(train.part, "partID")

# Now, we can load the complete training data set
train.data <- read.table("UCI HAR Dataset/train/X_train.txt")
# Setting the column names for all the training data set based on the features
setnames(train.data,features$feature)

# We want to remove everything except the mean and standard deviation columns
# we can do this by matching the mean and std values from features
feat.keep <- features[grep("mean()|std()",features$feature)]
# removing unnecessary columns matching "meanFreq"
feat.keep <- feat.keep[!grepl("meanFreq()",feat.keep$feature, fixed = TRUE)]

# Now, we can keep the mean and std values from the train data set
# note that the feat.keep$id should match column index from train.data
train.data <- train.data[,feat.keep$id]

## ----- CHECK POINT :)
## CHECK: This check will ensure that the dimensions of our data frame is valid
stopifnot(ncol(train.data) == nrow(feat.keep))
## CHECK: Let's check that all column names matches
stopifnot(sum(names(train.data) == feat.keep$feature)==nrow(feat.keep))

# Finally, the data can be binded into a single data frame
training <- cbind(train.part,train.labels,train.data)

#----- TESTING DATA SET
# Let's load TEST labels, add the column names, 
# and add a column showing the condition (testing)
test_labels <- fread("UCI HAR Dataset/test/y_test.txt")
setnames(test_labels,"id")
test_labels[,condition:="testing"]
# We can match each label of the testing data with the activity list
test_labels$activity <- sapply(test_labels$id, 
                    function(x) activityLabels$activity[activityLabels$id==x])

# Merging all the label data
# labels <- rbind(train_labels,test_labels)


# get mean(): meanFeat <- feat[grep("mean()",feat$V2,fixed= TRUE)]
# train_data[grep("mean()",features$feature,fixed= TRUE)]