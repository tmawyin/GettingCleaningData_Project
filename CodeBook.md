##Getting and Cleaning Data
####by Tomas Mawyin

####1. Raw data - A map to understanding the data

The raw data contains some generic files and two folders (train/ and test/).
The following is a description of the generic files:

* **activity_labels.txt:** 
    This file matches a numeric value with a label, e.g., 1 - Walking, 2 - Walking_Upstairs, and so on. 
    There are 6 labels in total each with a unique numeric identifier
* **features.txt:**
    A list containing the labels of the 561 features included in the data.
    This list refers to all the variables measured in the training and testing data sets

The following is a description of the folders and the files used in the data cleaning:

* **test/X_text.txt:**
    This files contains all the information for the participants under the testing condition. 
    The file has 2947 observations and 561 variables
* **test/y_text.txt:**
    This file contains all the activity labels matching the X_test.txt file.
    It contains 2947 observations and 1 variable (activity labels)
* **test/subject_test.txt:**
    The file contains tha participant ID that matches each of the observations in the X_test.txt file
    It contains 2947 observations and 1 variable (participant ID)
    
*Similar information is presented for the training folder.* Each file in the "train" folder contains 7352 observations and the same number of variables as reported above.

####2. Script file - From raw data to tidy data

This section explores the steps taken to transform the raw data into a tidy data set

* **Loading activity_labels.txt:**
    The activity labels is the first file loaded using fread(); the names of each of the columns is changed to "activityID" and "activity" to make it easy for handling the variables and readibility puposes. A final touchup on the activity lables was done to avoid any undesired characters.

* **Loading features.txt:**
    The next file that is loaded is the features file. The column names are changed to "featID" and "feature".

* **Loading the TRAIN data:**
    This is done in three steps. First, the training labels file is loaded and two columns are added to this file. The first column matches the activity to each of the levels, i.e., for a label "1", the activity is "walking", "2"-"walkingUp", and so on. The second column specifies that these data comes from the training condition.

    The second step loads the subjects vector. The final step loads the complete training data set (observations and variables). Now, the columns' names of this data is changed to match the "features$feature" vector. Furthermore, the grep() function is used to remove all variables that do not match the mean and standard deviation measurements.

    Finally, the *training* variable is created by binding the subjects, labels, and train data frames.

* **Loading the TEST data:**
    *A similar procedure as the already described to load the TRAIN data set is used for the TEST data.* The labels, subject, and modified test data set (removed unecessary measurements) is binded into a *testing* variable

* **Binding all the data:**
    The two data frames *training* and *testing* are then binding into a complete data set. A few modifications to the variable names are made to make them readible. The data is then split based on the subject and activity by using the *melt* function, and a new *tidy.data* frame is created by casting the data while calculating the mean values. The resulting data frame is saved to file.

    As an alternative the data can be split and the column means of each of the measurements is calculated using *sapply*. This alternative approach is at the end of the script.  

* **Cleaning up:**
    All non necessary variables are removed - the users can comment out this line to keep all the variables if desired.

####3. Variables - What was measured

The following are the final variables included in the tidy data set. The data file contains 180 observations and 68 variables in total. The "f" at the begining of the variable name represents the frequency domain, while the "t" represents the time domain. Finally, the X,Y,Z represents the cartesian components of each of the variables.

* partID
* activity
* fBodyAccJerk_Mean_X, Y, Z
* fBodyAccJerk_StDev_X, Y, Z
* fBodyAccMag_Mean
* fBodyAccMag_StDev
* fBodyAcc_Mean_X, Y, Z
* fBodyAcc_StDev_X, Y, Z
* fBodyBodyAccJerkMag_Mean
* fBodyBodyAccJerkMag_StDev
* fBodyBodyGyroJerkMag_Mean
* fBodyBodyGyroJerkMag_StDev
* fBodyBodyGyroMag_Mean
* fBodyBodyGyroMag_StDev
* fBodyGyro_Mean_X, Y, Z
* fBodyGyro_StDev_X, Y, Z

* tBodyAccJerkMag_Mean
* tBodyAccJerkMag_StDev
* tBodyAccJerk_Mean_X, Y, Z
* tBodyAccJerk_StDev_X, Y, Z
* tBodyAccMag_Mean
* tBodyAccMag_StDev
* tBodyAcc_Mean_X, Y, Z
* tBodyAcc_StDev_X, Y, Z
* tBodyGyroJerkMag_Mean
* tBodyGyroJerkMag_StDev
* tBodyGyroJerk_Mean_X, Y, Z
* tBodyGyroJerk_StDev_X, Y, Z
* tBodyGyroMag_Mean
* tBodyGyroMag_StDev
* tBodyGyro_Mean_X, Y, Z
* tBodyGyro_StDev_X, Y, Z
* tGravityAccMag_Mean
* tGravityAccMag_StDev
* tGravityAcc_Mean_X, Y, Z
* tGravityAcc_StDev_X, Y, Z

*Please refer to the raw data set for a complete description of each of the variables.*
