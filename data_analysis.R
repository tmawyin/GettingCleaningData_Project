## Getting and Cleaning Data
## by Tomas Mawyin
## Course Project

## This script will help you clean the data obtained from:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## If you need more information on this script, please refer to the Cookbook

# Uncomment below if you don't have the data.table package installed
# install.packages("data.table")
library(data.table)

##----- ACTIVITY LABELS
# Loading the activity labels
activity.labels <- fread("UCI HAR Dataset/activity_labels.txt")
# Changing column names
setnames(activity.labels,c("activityID","activity"))
# Changing all activities to lower case
activity.labels$activity <- tolower(activity.labels$activity)
activity.labels$activity[2] <- "walkingUp"
activity.labels$activity[3] <- "walkingDown"

##----- FEATURES
# Loading the list of features
features <- fread("UCI HAR Dataset/features.txt")
# Changing column names
setnames(features,c("featID","feature"))

#----- TRAINING DATA SET
# Loading the TRAIN LABLES and changing the column name as "activityID"
train.labels <- fread("UCI HAR Dataset/train/y_train.txt")
setnames(train.labels,"activityID")
# Matching each id of the training_labels data with the activity list
train.labels[,activity:=factor(train.labels$activityID, labels=activity.labels$activity)]
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
train.data <- train.data[,feat.keep$featID]

##----- CHECK POINT :)
## CHECK: This check will ensure that the dimensions of our data frame is valid
stopifnot(ncol(train.data) == nrow(feat.keep))
## CHECK: Let's check that all column names matches
stopifnot(sum(names(train.data) == feat.keep$feature)==nrow(feat.keep))

# Finally, the data can be binded into a single data frame
training <- cbind(train.part,train.labels,train.data)

#----- TESTING DATA SET
# Loading the TEST LABLES and changing the column name as "activityID"
test.labels <- fread("UCI HAR Dataset/test/y_test.txt")
setnames(test.labels,"activityID")
# Matching each id of the test.labels data with the activity list
test.labels[,activity:=factor(test.labels$activityID, labels=activity.labels$activity)]
# Adding a new column showing the condition (testing)
test.labels[,condition:="testing"]

# Loading the participant vector from the test data
test.part <- fread("UCI HAR Dataset/test/subject_test.txt")
setnames(test.part, "partID")

# Now, we can load the complete test data set
test.data <- read.table("UCI HAR Dataset/test/X_test.txt")
# Setting the column names for all the testing data set based on the features
setnames(test.data,features$feature)

# Since we already know which features to keep, we can apply
test.data <- test.data[,feat.keep$featID]

##----- CHECK POINT :)
## CHECK: This check will ensure that the dimensions of the data frame is valid
stopifnot(ncol(test.data) == nrow(feat.keep))
## CHECK: Let's check that all column names matches
stopifnot(sum(names(test.data) == feat.keep$feature)==nrow(feat.keep))

# Finally, the data can be binded into a single data frame
testing <- cbind(test.part,test.labels,test.data)

##----- BINDING ALL DATA
# Combining training and testing into one full data set
full.data <- rbind(training,testing)

# Fixing the names of the columns by getting a handle on the column names
handle.names <- names(full.data)
# First, let's remove the ()
handle.names <- gsub("()","",handle.names,fixed = TRUE)
# Replacing mean and std with more appropiate names
handle.names <- gsub("-mean","_Mean",handle.names,fixed = TRUE)
handle.names <- gsub("-stf","_StDev",handle.names,fixed = TRUE)
handle.names <- gsub("-","_",handle.names,fixed = TRUE)

# Finally, changing the column names
setnames(full.data, handle.names)

##---- CREATING TIDY DATA
# Splitting the data based on subject and activity, and removing unnecessary columns 
data.split <- split( full.data[,!c("partID","activityID","activity","condition"),with=FALSE], 
                    list(full.data$partID, full.data$activity))
# Generating the final tidy data set
tidy.data <- sapply(data.split, function(x) colMeans(x))
# Organizing the tidy data set
tidy.data <- t( tidy.data[order(rownames(tidy.data)),] )
tidy.data<- as.data.table(tidy.data)

# Writing the tidy dataset to file
write.table(tidy.data, "tidyData.txt", row.names = FALSE)

##----- CLEANING UP
# This will remove all variables, except the full.data set
rm(list=setdiff(ls(), c("full.data","tidy.data")))
