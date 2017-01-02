## Keith Swaback
## 12-29-2016
## Getting and Cleaning Data Week 4 Assignment

## Please reference README.md for more details on the function of this script.

## load dplyr package
library(dplyr)

## Read in train and tests datasets, activity labels, subject labels and factor data.
## Important note: this script assumes that required datasets have been moved
## to a /data folder located in the working directly. See README.md for more details.

X_train <- read.table("./data/X_train.txt")
y_train <- read.table("./data/y_train.txt")
subject_train <- read.table("./data/subject_train.txt")

X_test <- read.table("./data/X_test.txt")
y_test <- read.table("./data/y_test.txt")
subject_test <- read.table("./data/subject_test.txt")

factors <- read.table("./data/features.txt", stringsAsFactors = FALSE)

#####################
## Our first requirement is to create a single "master dataset" by merging the training
## and test datasets, and by binding the activity codes and subject numbers to the dataset.

## Column-bind the test data with the activity label and the subject labels, then combine
## the datasets into a master dataset. Since each record is unique, we want to use rbind here.
masterData <- rbind(cbind(X_test, y_test, subject_test), cbind(X_train, y_train, subject_train))

#####################
## Our second requirement is to extract all of the items in the "factors" vector that represent
## some measurement of mean or standard deviation. Note that in the masterData set, the factor
## values are columns 1 through 561, while col 562 contains activity numbers + col 563 contains
## subject number.

## identify the factors that contain the string "std" or "mean." (Not case-sensitive),
## save as extractItems. Use extractItems later.
extractItems <- c(grep("std", factors[,2], ignore.case = TRUE), 
          grep("mean", factors[,2], ignore.case = TRUE))
extractItems <- sort(extractItems)

## extractItems2 includes activity number and subject number columns.
extractItems2 <- c(extractItems, nrow(factors) + 1 , nrow(factors) + 2)

## extract data containing only mean/std deviation from master data. Keep activity number and
## subject number columns.
masterMeanSD <- masterData[,extractItems2]

#####################
## Our third requirement is to change the activites from numbers to descriptive names. We
## can convert the activity numbers into factors that use activity labels shown in 
## "activity_labels.txt" file.

## Use factor() function and assign character labels to the activity numbers. First sort the
## dataframe so that the activity numbers appear in order. Then apply labels.

colnames(masterMeanSD)[(ncol(masterMeanSD)-1)] <- "activityname"
masterMeanSD <- arrange(masterMeanSD, activityname)

activityNames <- factor(masterMeanSD$activityname, labels = c("WALKING", "WALKING_UPSTAIRS",
                                                          "WALKING_DOWNSTAIRS", "SITTING",
                                                          "STANDING", "LAYING"))
masterMeanSD$activityname <- activityNames


######################
## Our fourth requirement is to finish labeling the dataset varibles with descriptive names.
## We have already named the activity name column. Use information in "features.txt" and
## "features_info.txt" to name the variables. See codebook and README.md for more details.

## Assign the factor names to the data frame columsn; use the factors that contain mean(), std()
## functionality only
colnames(masterMeanSD)[1:(ncol(masterMeanSD)-2)] <- factors[extractItems,2]

## Label the subject number column
colnames(masterMeanSD)[ncol(masterMeanSD)] <- "subjectnumber"


######################
## Our fifth and final requirement is to create a new tidy dataset ("averageMeanSD") from the data in the previous step.
## This data should give averages (means) for all the variables from step 4, for each combination of subject and
## activity.

averageMeanSD <- aggregate(masterMeanSD, list(masterMeanSD$activityname, masterMeanSD$subjectnumber), 
                                                                        FUN="mean", na.rm=TRUE)

## This new dataset will have activity name and subject number as its first two columns. Label these column.

colnames(averageMeanSD)[1:2] <- c("activityname", "subjectnumber")
averageMeanSD <- averageMeanSD[,1:(ncol(averageMeanSD)-2)]


