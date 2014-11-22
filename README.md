# Getting and Cleaning Data Project

==================================================================
Tidied Data from Human Activity Recognition Using Smartphones Dataset
==================================================================
Rajesh Thallam
Date: 11/22/2014
Version: 0.1
==================================================================

## Repository Contents

 - **README.md:** Defines how to get started with the repository contents
 - **CodeBook.md:** Guide to the data sets, variable names and descriptions, transformations applied
 - **run_analysis.R:** Script to clean up the source data set and generate tidied data set
 - **tidy_means.txt:** Final tidied data file generated by the script

## run_analysis.R

The cleanup script **run_analysis.R** tidies up the source data set

1. Downloads and extracts the source data set if not available on disk.
2. Merges the training and the test data sets to create one data set.
3. Combines subject identifiers and activity labels with features or measurements data set.
4. Extracts only the measurements on the mean and standard deviation for each measurement. 
5. Uses descriptive activity names to name the activities in the data set
6. Appropriately labels the data set with descriptive activity names. 
7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
8. Finally the transformed data is in "wide" format ; 
 - There is a single row(observation) for each subject/activity pair and
 - single column for each measurement (variable)
9. The final data set is written to *tidy_means.txt* file. A detailed description of the variables can be found in CodeBook.md 

## Running the script

To run the script, source `run_analysis.R`
```
source("run_analysis.R")
```

After running, script will log the output while running to the console as below

```
[run_analysis.R] [2014-11-22 09:43:52] Getting and Cleaning Data Project 
[run_analysis.R] [2014-11-22 09:43:52] Starting up... 
[run_analysis.R] [2014-11-22 09:43:52] Preparing to run analysis 
[run_analysis.R] [2014-11-22 09:43:52] Downloading and extracting data files 
[run_analysis.R] [2014-11-22 09:44:12] Reading feature names 
[run_analysis.R] [2014-11-22 09:44:12] Reading training features 
[run_analysis.R] [2014-11-22 09:44:33] Reading test features 
[run_analysis.R] [2014-11-22 09:44:37] Combining training and test features 
[run_analysis.R] [2014-11-22 09:44:38] Extracting required features 
[run_analysis.R] [2014-11-22 09:44:38] Reading training activities 
[run_analysis.R] [2014-11-22 09:44:38] Reading test activities 
[run_analysis.R] [2014-11-22 09:44:38] Combining training and test activities 
[run_analysis.R] [2014-11-22 09:44:38] Tidying up column names 
[run_analysis.R] [2014-11-22 09:44:38] Reading subjects 
[run_analysis.R] [2014-11-22 09:44:38] Reading and combining data - subjects, activities and features 
[run_analysis.R] [2014-11-22 09:44:38] Melting data 
[run_analysis.R] [2014-11-22 09:44:38] Dcasting data 
[run_analysis.R] [2014-11-22 09:44:40] Saving tidy data to: UCI HAR Dataset/tidy_means.txt 
```

## Process

1. Download adn extract the source data files if not available on the disk
2. For both the test and train datasets, 
    1. Read and combine the training and test measurements into single data set
    2. Extract the mean and standard deviation features (listed in CodeBook.md, section 'Data - Extracted Features'). 
    3. Read and combine the training and test activities into single data set
    3. Map the activity *labels* (activity names) into the combined data set of activites
    4. Read the list of subjects
    5. Combine extracted measurements, subject identifiers and activity labels with transformed column names
3. Reshape the combined data set by indexing on subject and activity pairs
4. Apply the mean function on each vector of measurements for each subject and activity pair. 
6. The resultant data is the tidied data set
5. Final tidy data set is written to the disk.

Please refer CodeBook.md for variable names and detailed description.

## Cleaned Data

The tidied up dataset is in this repository as: `tidy_means.txt`. It contains one row for each subject and activity pair (observation) and mean of each measurement that was a mean/standard deviation from the original dataset.

## Reading Tidy Data Set in R

You can use below R command to read the final data set generated by the script
read.table("tidy_means.txt", header = TRUE)
