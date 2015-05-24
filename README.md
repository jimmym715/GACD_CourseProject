# GACD_CourseProject
This repo contains my submission for the Coursera "Getting and Cleaning Data" course project, which consists of the following files:

*CODEBOOK.md
*README.md (this file)
*run_analysis.R

## Source Data
UC Irvine's "Human Activity Recognition Using Smartphones Data Set"

[Project Page](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[Data Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Assignment
Create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Using run_analysis.R
To use run_analysis.R, i.e. to run the requested analysis on the source data, proceed as follows:

1. Download the run_analysis.R file to one's working directory in RStudio, and then proceed using the RStudio console.

2. Call `source("run_analysis.R")`

3. Call `run_analysis()`

The resulting tidy data file will be written to one's RStudio working directory and named "HAR_analysis_tidy_data.txt"

Note that there is no need to download the source data zip file before running the analysis, as the function will check whether or not a file with the name "getdata-projectfiles-UCI HAR Dataset.zip" exists in the working directory and download that file if it is not found.

However, if a file named "getdata-projectfiles-UCI HAR Dataset.zip" is already present in one's RStudio working directory, then time it takes for `run_analysis()` to finish will be much less than if the data needs to be downloaded.

Note, too, that the zip file need not be decompressed, as the functions in "run_analysis.R" will read the files needed directly from the zip file.
