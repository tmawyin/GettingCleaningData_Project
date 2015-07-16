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
    