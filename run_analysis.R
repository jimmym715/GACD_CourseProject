# set the filename for the source data zip file, 
# so it's available to both functions in this file
zipFilename <- "getdata-projectfiles-UCI HAR Dataset.zip"

run_analysis <- function() {
  
  # console message
  cat("Check for zip file named '", zipFilename, "'\n\n", sep = "")

  # set zip file download URL
  zipFileDownloadUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  # check to see if the source data zip file 
  # exists in the working directory
  # and download the file if it does not exist
  
  if (!file.exists(zipFilename)) {
    
    # console message
    cat("Zip file is not present so download file from ", zipFileDownloadUrl, "'\n\n")
    
    # download the zip file since it's 
    # not present in the working directory
    download.file(zipFileDownloadUrl, zipFilename)
  }
  
  # check again to see if the source data zip file 
  # exists in the working directory
  # if it still doesn't exist, stop execution
  
  if (!file.exists(zipFilename)) {
    stop("unable to download 'getdata-projectfiles-UCI HAR Dataset.zip' from 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'")
  }
  
  # read in features
  # The second column in the features table will be used as the column names
  # for the data in the X_test.txt and X.train.txt files

  # set features filename
  featuresFilename <- "UCI HAR Dataset/features.txt"
  
  # get features file from zip file
  featuresFile <- unz(zipFilename, featuresFilename)
  
  # read features data into table
  features <- read.table(featuresFile)
  
  # read in activity labels
  # Apply column names of "ActivityID" and "ActivityType" 
  # to the two columns in this data.
  #
  # The data in activity_labels.txt consists of "key, value" data
  # that translates an activity ID, used in the y_test.txt and y.train.txt files
  # into an activity type, e.g. ActivityID 1 means the ActivityType is "WALKING"

  activityLabelsFilename <- "UCI HAR Dataset/activity_labels.txt"
  
  # get activity_labels.txt from zip file
  activityLabelsFile <- unz(zipFilename, activityLabelsFilename)
  
  # read activity labels data into table
  activityLabels <- read.table(activityLabelsFile, stringsAsFactors=FALSE, col.names = c("ActivityCode", "ActivityType"))
  
  #NOTE: because the procedure for processing the test data
  #      is the same as the procedure for processing the train data
  #      I encapsulated this procedure in a function, 
  #      called readHumanActivityRecognitionData, 
  #      which is defined at the end of this script

  # console message
  cat("Call readHumanActivityRecognitionData to process test data\n\n")
  
  # process the test data
  testData <- readHumanActivityRecognitionData("test", features, activityLabels)
  
  # console message
  cat("Call readHumanActivityRecognitionData to process train data\n\n")
  
  # process the train data
  trainData <- readHumanActivityRecognitionData("train", features, activityLabels)
  
  # console message
  cat("Bind the testData and trainData\n\n")
  
  # combine the test data and the train data into a single table
  allData <- rbind(testData, trainData)
  
  # get the column names from the allData table
  dataColNames <- colnames(allData)
  
  # restrict column names to only the following:
  #  - Activity
  #  - SubjectID
  #  - any column name containing "-mean()"
  #  - any column name containing "-std()"
  # note that grep will return the column *numbers*
  # for the matching column names (which actually makes life easier below)
  subjectIdAndActivityPlusMeanAndStdColNumbers <- grep("(-mean[(][)]|std[(][)])|^Activity$|^SubjectID$", dataColNames)
  
  # restrict the data from the allData table
  # by only retrieving the column numbers identified
  # in subjectIdAndActivityPlusMeanAndStdColNumbers
  dataMeanAndStdOnly <- allData[, subjectIdAndActivityPlusMeanAndStdColNumbers]
  
  # convert the table of desired data to a data frame
  meanAndStdDF <- as.data.frame(dataMeanAndStdOnly)
  
  # In aggregating this data, my preference is to group the data
  # first by SubjectID, and second by Activity.
  #
  # I know these two columns to be the first and second columns
  # in the data frame, respectively.
  #
  # I'll be using the aggregate function in the form 
  # where I'll pass the following parameters
  #   - data frame of all columns 
  #     *other than* grouping columns (SubjectID & Activity)
  #   - data frame of grouping columns
  #   - the function name to apply (mean, in this case)
  #
  # When using this combination of parameters, 
  # the data frame of grouping columns must be created
  # such that the first column to group by 
  # is the right-most column (which seems odd to me).
  #
  # Because I ensured, in the readHumanActivityRecognitionData function,
  # that SubjectID is column 1
  # and Activity is column 2
  # I must select these columns in the opposite order
  # to create the data frame of grouping columns correctly.
  # (Thus the descending sequence of 2:1)
  activitySubjectId <- meanAndStdDF[,2:1]
  
  # And because I know that all columns other than the first two
  # contain the data to be examined,
  # I can pull that data by passing a sequence to the column filter
  # that runs from 3 to the number of columns in the data frame
  meanAndStdData <- meanAndStdDF[,3:ncol(meanAndStdDF)]
  
  # console message
  cat("Aggregate the measurement data by SubjectID and then by Activity, and apply the mean function\n\n")
  
  # Aggregating the data is now simple, as, again, 
  # I'll pass the following parameters:
  #   - meanAndStdData:    data frame of all columns 
  #                        *other than* grouping columns (SubjectID & Activity)
  #   - activitySubjectId: data frame of grouping columns
  #   - mean:              the function name to apply
  meanAndStdAggregate <- aggregate(meanAndStdData, activitySubjectId, mean)
  
  # Before writing this tidy data to a text file, 
  # I'd like to add the prefix "mean_" to each of the data column names

  # get only the measurement data to make it easier
  # to prefix the column names 
  # without worrying about the SubjectID and Activity column names
  tidyMeasurementData <- meanAndStdAggregate[,3:ncol(meanAndStdAggregate)]
  
  colnames(tidyMeasurementData) <- paste("mean", colnames(tidyMeasurementData), sep = "_")
  
  # In addition, while I could leave the meanAndStdAggregate data frame as is,
  # my preference is to have the column that I grouped by first
  # be shown as the first column in the aggregated data,
  # followed by the column I grouped by second in the second column.
  #
  # Because of the way the data frame of grouping columns had to be defined
  # the first and second columns currently contain 
  # the second column I grouped by 
  # and the first column I grouped by, respectively.
  #
  # Thus, I'll now switch those two columns,
  # and bind the tidyMeasurementData with its new column names
  # for the final aggregated tidy data
  finalAggregate <- cbind(SubjectID = meanAndStdAggregate[,2], Activity = meanAndStdAggregate[,1], tidyMeasurementData)
  
  # set tidy data filename
  tidyDataFileName <- "HAR_analysis_tidy_data.txt"

  # console message
  cat("Write the final aggregated tidy data to ", tidyDataFileName, " in the working directory.\n\n", sep = "'")
  
  # write the final aggregated tidy data to a file as a table
  write.table(finalAggregate, file = tidyDataFileName, row.names = FALSE)
  
  # console message
  cat("Done (Success!)")
}

# This function reads in all data related to the data set, 
# requested by dataSetName, and puts the pieces together
# 
# The parameters for this function are as follows:
#   - dataSetName ("test" or "train")
# 
#   - features (The data in the second column of the features table 
#               will be used as the column names of the X data)
# 
#   - activityLabels (The data in activityLabels will be used
#                     to translate the computer-friendly ActivityID values
#                     into human-friendly ActivityType values,
#                     e.g. the ActivityID of 1 will be changed 
#                          to the ActivityType of "WALKING" )
readHumanActivityRecognitionData <- function(dataSetName, features, activityLabels) {
  # stop processing if the dataSetName is not "test" or "train"
  if(dataSetName != "test" && dataSetName != "train")
  {
    stop("invalid data set name")
  }
  
  # The subject, X, and y data files in the data set 
  # each contain the same number of rows.
  #
  # Thus, I'll read in these data files and cbind them together

  # create the filename for the subjects data in the requested data set
  subjectsFileName <- paste0("UCI HAR Dataset/", dataSetName, "/subject_", dataSetName, ".txt")
  
  # read in subjects
  # apply a column name of "SubjectID" to the only column in this data
  
  # get subjects file from zip file
  subjectsFile <- unz(zipFilename, subjectsFileName)
  
  # read subjects data into table
  subjects <- read.table(subjectsFile, col.names = c("SubjectID"))
  
  # create the filename for the y data in the requested data set
  yDataFileName <- paste0("UCI HAR Dataset/", dataSetName, "/y_", dataSetName, ".txt")
  
  # read in y data
  # apply a column name of "Activity" to the only column in this data

  # get y data file from zip file
  yDataFile <- unz(zipFilename, yDataFileName)
  
  # read y data into table
  ydata <- read.table(yDataFile, col.names = c("Activity"))
  
  # get the number of activity labels (to use in the for loop below)
  numActivityLabels <- nrow(activityLabels)
  
  # Loop thru the rows in the activityLabels table
  # and change the ActivityID values in the ydata table
  # to the matching ActivityType value
  for(rowNumber in 1:numActivityLabels){ 
    rowsMatchingActivityID <- ydata$Activity == activityLabels[rowNumber, 1] 
    
    ydata$Activity[rowsMatchingActivityID] <- activityLabels[rowNumber, 2] 
  }
  
  # create the filename for the X data in the requested data set
  xDataFileName <- paste0("UCI HAR Dataset/", dataSetName, "/X_", dataSetName, ".txt")
  
  # read in X data
  
  # get X data file from zip file
  xDataFile <- unz(zipFilename, xDataFileName)
  
  # console message
  cat("Read ", xDataFileName, " into a table\n\n", sep = "'")
  
  # read X data into table
  xdata <- read.table(xDataFile)
  
  # apply the second column of the features table
  # as the column names for the X data
  colnames(xdata) <- features[,2]
  
  # console message
  cat("Bind the columns in the ", dataSetName, " subjects, ydata, and xdata tables, in that order\n\n", sep = "'")
  
  # bind together the following:
  #   - subjects (SubjectID column)
  #   - ydata (Activity column)
  #   - xdata (observation data)
  fullData <- cbind(subjects, ydata, xdata)
}