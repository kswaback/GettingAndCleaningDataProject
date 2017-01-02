## Keith Swaback
## 12-29-2016
## Getting and Cleaning Data Week 4 Assignment

## VERY IMPORTANT:
## Since file path is hardcoded, in order to run the script one
## must move required data files to a "data" folder in the working directory.
## Required files are as follows:
## 1. X_train.txt
## 2. y_train.txt
## 3. subject_train.txt
## 4. X_test.txt
## 5. y_test.txt
## 6. features.txt
## 7. subjects_test.txt

## The script "run_analysis.R" performs several operations on the training and test datasets:
## 1. Merge the test and the training data into a single dataset. This dataset is called "masterData".
## 2. Extract only the measurements related to "mean" and "standard deviation" calculations.
## This dataset is called "masterMeanSD".
## 3. Change the activity numbers to descriptive activity names
## 4. Label all the dataset variables with descriptive names
## 5. Create an independent, tidy dataset that shows averages of all variables,
## for all combinations of subject number and activity number. This dataset is called "averageMeanSD".

## Further comments on the code:
##
## 1. In order to determine which variables contained mean or standard deviation information,
## I used the grep() function while searching for "mean" and "std" without case sensitivity.
## I therefore assume that any variable containing either of these expressions is mean or 
## standard deviation information.
##
## 2. I did not attempt to change the variable labels beyond how they were listed in "factors.txt."
## Using string manipulation it could be be possible to make the variable names longer or more
## descriptive, but this did not seem necessary.
##
## 3. See comments in the code for more details on the how the datasets were manipulated.