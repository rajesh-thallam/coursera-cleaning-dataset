#==============================================================================
#TITLE           : run_analysis.R
#DESCRIPTION     : Getting and Cleaning Data Course Project
#         1. Merges the training and the test sets to create one data set.
#         2. Extracts only the measurements on the mean and standard deviation 
#            for each measurement. 
#         3. Uses descriptive activity names to name the activities in the data 
#            set
#         4. Appropriately labels the data set with descriptive variable names. 
#         5. From the data set in step 4, creates a second, independent tidy 
#            data set with the average of each variable for each activity and 
#            each subject.
#AUTHOR          : Rajesh Thallam
#DATE            : 11/22/2014
#VERSION         : 0.1
#USAGE           : run.analysis()
#NOTES           : Script can be executed in R console
#R_VERSION       : R version 3.1.1 (2014-07-10)
#==============================================================================

# load required packages
library(reshape2)

# helper method: logging to the console
p <- function(...) {
  cat("[run_analysis.R]", format(Sys.time(), "[%Y-%m-%d %H:%M:%S]"),..., "\n")
}

# sets file path
file.path <- function(...) { paste(..., sep = "/") }

# helper method: downloading data if not available
download.data <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.dir <- "data"
  data.dir <- "data"
  zip.file <- file.path(download.dir, "dataset.zip")

  # download data
  if(!file.exists(download.dir)) { dir.create(download.dir) }
  if(!file.exists(zip.file)) { download.file(url, zip.file) }
  
  # extract data
  if(file.exists(zip.file)) { unzip(zip.file, exdir = ".", overwrite = TRUE) }
  data.dir
}

# prepare variables
activity.names <-
  c("WALKING", "WALKING UPSTAIRS", "WALKING DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

tidy.file <- "tidy_means.txt"
x.train.features <- NULL
x.test.features <- NULL
y.train.activities <- NULL
y.test.activities <- NULL

# main function
# run analysis function
run.analysis <- function() {
  p("Getting and Cleaning Data Project")
  p("Starting up...")
  p("Preparing to run analysis")
  
  # download and extract data
  p("Downloading and extracting data files")
  download.data()

  # merge the training and the test sets to create one data set.
  data.dir <- "UCI HAR Dataset"
  get.data <- function(path) {
    read.table(file.path(data.dir, path))
  }

  # read feature names to label data and variables
  p("Reading feature names")
  feature.names <- get.data("features.txt")[, 2]
  
  # read and merge features data
  p("Reading training features")
  x.train.features <- get.data("train/X_train.txt") 
  
  p("Reading test features")
  x.test.features <- get.data("test/X_test.txt") 

  p("Combining training and test features")
  merged.features <- rbind(x.train.features, x.test.features)
  names(merged.features) <- feature.names

  # extract only the measurements on the mean and standard deviation for each measurement.
  # limit merged data set to columns with feature names having mean() or std():
  p("Extracting required features")
  matched.features <- grep("(mean|std)\\(\\)", names(merged.features))
  extracted.features <- merged.features[, matched.features]

  # Use descriptive activity names to name the activities in the data set.
  # Get the activity data and map to nicer names:

  # read and merge activities data
  p("Reading training activities")
  y.train.activities <- get.data("train/y_train.txt")
  
  p("Reading test activities")
  y.test.activities <- get.data("test/y_test.txt")
  
  p("Combining training and test activities")
  merged.activities <- rbind(y.train.activities, y.test.activities)[, 1]

  # label actvities with respective names
  activities <- activity.names[merged.activities]
  
  # appropriately label the data set with descriptive variable names.
  p("Tidying up column names")
  # change t to Time
  names(extracted.features) <- gsub("^t", "Time", names(extracted.features))
  # change f to Frequency
  names(extracted.features) <- gsub("^f", "Frequency", names(extracted.features))
  # change mean() to Mean 
  names(extracted.features) <- gsub("-mean\\(\\)", "Mean", names(extracted.features))
  # change std() to StdDev
  names(extracted.features) <- gsub("-std\\(\\)", "StdDev", names(extracted.features))
  # trim extra dashes
  names(extracted.features) <- gsub("-", "", names(extracted.features))
  # trim BodyBody
  names(extracted.features) <- gsub("BodyBody", "Body", names(extracted.features))

  # Set activities and subject with better names
  p("Reading subjects")
  subject.train <- get.data("train/subject_train.txt")
  subject.test <- get.data("test/subject_test.txt")
  subjects <- rbind(subject.train, subject.test)[, 1]

  # combine features, activities and subjects data set
  p("Reading and combining data - subjects, activities and features")
  clean.data <- cbind(extracted.features, Subject = subjects, Activity = activities)

  # reshaping data
  p("Melting data")
  clean.data.long <- melt(clean.data, id = c("Subject", "Activity"))

  p("Dcasting data")
  clean.data.wide <- dcast(clean.data.long, Subject + Activity ~ variable, mean)
  
  tidy.data <- clean.data.wide
  
  # rename column names
  names(tidy.data)[-c(1,2)] <- paste0("Mean", names(tidy.data)[-c(1,2)])
  
  # save the clean data.
  tidy.file.name <- file.path(data.dir, tidy.file)
  p("Saving tidy data to:", tidy.file.name)
  write.table(tidy.data, tidy.file.name, row.names = FALSE)
  
  # return data
  # tidy.data
}

# Run analysis
run.analysis()