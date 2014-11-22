# Getting and Cleaning Data Project CodeBook

## Source Data

The source data used in the project represenst data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Script downloads source data if it's not laready downloaded to the disk
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Variables

Following variables identify the unique subject and activity pair the observations relate to in the data set

 - Subject: the integer subject ID.
 - Activity: the string activity name:
  - WALKING
  - WALKING UPSTAIRS
  - WALKING DOWNSTAIRS
  - SITTING
  - STANDING
  - LAYING

## Data - Extracted Features

Variables in the final data set are the mean of a measurement for each subject and activity. This is indicated by the prefix Mean in the variable name. Means are calculated from source data and represented as floating point numbers.

 - MeanTimeBodyAccMean[X | Y | Z]: Time domain body acceleration mean along X, Y, and Z
 - MeanTimeBodyAccStdDev[X | Y | Z]: Time domain body acceleration standard deviation along X, Y, and Z
 - MeanTimeGravityAccMean[X | Y | Z]: Time domain gravity acceleration mean along X, Y, and Z
 - MeanTimeGravityAccStdDev[X | Y | Z]: Time domain gravity acceleration standard deviation along X, Y, and Z:
 - MeanTimeBodyAccJerkMean[X | Y | Z]: Time domain body jerk mean along X, Y, and Z:
 - MeanTimeBodyAccJerkStdDev[X | Y | Z]: Time domain body jerk standard deviation along X, Y, and Z:
 - MeanTimeBodyAccJerkStdDev[X | Y | Z]: Time domain gyroscope mean along X, Y, and Z:
 - MeanTimeBodyGyroStdDev[X | Y | Z]: Time domain gyroscope standard deviation along X, Y, and Z:
 - MeanTimeBodyGyroJerkMean[X | Y | Z]: Time domain gyroscope jerk mean along X, Y, and Z:
 - MeanTimeBodyGyroJerkStdDev[X | Y | Z]: Time domain gyroscope jerk standard deviation along X, Y, and Z:
 - MeanTimeBodyAccMagMean: Time domain body acceleration magnitude mean:
 - MeanTimeBodyAccMagStdDev: Time domain body acceleration magnitude standard deviation:
 - MeanTimeGravityAccMagMean: Time domain gravity acceleration magnitude mean:
 - MeanTimeGravityAccMagStdDev: Time domain gravity acceleration magnitude standard deviation:
 - MeanTimeBodyAccJerkMagMean: Time domain body jerk magnitude mean:
 - MeanTimeBodyAccJerkMagStdDev: Time domain body jerk magnitude standard deviation:
 - MeanTimeBodyGyroMagMean: Time domain gyroscope magnitude mean:
 - MeanTimeBodyGyroMagStdDev: Time domain gyroscope magnitude standard deviation:
 - MeanTimeBodyGyroJerkMagMean: Time domain gyroscope jerk magnitude mean
 - MeanTimeBodyGyroJerkMagStdDev: Time domain gyroscope jerk magnitude standard deviation
 - MeanFrequencyBodyAccMean[X | Y | Z]: Frequency domain body acceleration mean along X, Y, and Z
 - MeanFrequencyBodyAccStdDev[X | Y | Z]: Frequency domain body acceleration standard deviation along X, Y, and Z
 - MeanFrequencyBodyAccJerkMean[X | Y | Z]: Frequency domain body jerk mean along X, Y, and Z
 - MeanFrequencyBodyAccJerkStdDev[X | Y | Z]: Frequency domain body jerk standard deviation along X, Y, and Z
 - MeanFrequencyBodyGyroMean[X | Y | Z]: Frequency domain gyroscope mean along X, Y, and Z
 - MeanFrequencyBodyGyroStdDev[X | Y | Z]: Frequency domain gyroscope standard deviation along X, Y, and Z
 - MeanFrequencyBodyAccMagMean: Frequency domain body acceleration magnitude mean
 - MeanFrequencyBodyAccMagStdDev: Frequency domain body acceleration magnitude standard deviation
 - MeanFrequencyBodyAccJerkMagMean: Frequency domain body jerk magnitude mean
 - MeanFrequencyBodyAccJerkMagStdDev: Frequency domain body jerk magnitude standard deviation
 - MeanFrequencyBodyGyroMagMean: Frequency domain gyroscope magnitude mean
 - MeanFrequencyBodyGyroMagStdDev: Frequency domain gyroscope magnitude standard deviation
 - MeanFrequencyBodyGyroJerkMagMean: Frequency domain gyroscope jerk magnitude mean
 - MeanFrequencyBodyGyroJerkMagStdDev: Frequency domain gyroscope jerk magnitude standard deviation

## Data Transformation

1. Observations from training and test data sets are combined and stored as *merged.features*
2. From the combined data set only meaningful measurements were extracted i.e. with feature name as mean or standard deviation. The extracted features are stored in *extracted.features*
3. Feature or measurement label names from "features_info.txt are transformed based on following rules
 - Change t to Time
 - Change f to Frequency
 - Change mean() to Mean 
 - Change std() to StdDev
 - Trim extra dashes
 - Trim BodyBody as Body
4. Activities from training and test data sets are combined and stored as *merged.activities*
5. Activities which are numeric in source have been transformed to respective labels
    WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING
   Transformed activities are stored as *activities*
6. Subject data set from training and test arecombined along with activity names/labels and stored as *clean.data*
7. Reshape the clean data using *melt* function based on subject and activity pair
8. Calculate mean/average of all measurements based on subject and activity pair using *dcast* function
9. Finally this tidy data set with means is written to disk as "tidy_means.txt"