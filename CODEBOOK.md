# Code Book for HAR Analysis Tidy Data

## Overview
The HAR Analysis Tidy Data file (`HAR_analysis_tidy_data.txt`) contains data that is aggregated first by SubjectID and then by Activity.

The data available for each combination of SubjectID and Activity are the means of each of the mean and standard deviation aggregates from the original HAR data, including both the "test" data set and the "train" data set.

To be clear, each row in the original data contained aggregates of "fixed-width sliding windows of 2.56 sec and 50% overlap", where there were 128 readings per window.

Thus, in any given row, the value for `tBodyAcc-mean()-X` represents the **mean** of the measurement (_presumed to be `tBodyAcc-X` or similar_) from the 128 readings for the window on which the row is reporting, and the value for `tBodyAccJerkMag-std()` represents the **standard deviation** of the measurement (_presumed to be `tBodyAccJerkMag` or similar_), and so on.

So, if SubjectID 1 has 100 rows in the source ("test" and/or "train") data that represent the activity "WALKING", then the value in the row with SubjectID = 1 and Activity = "WALKING" under the column named `mean_tBodyAcc-mean()-X` will be the **mean** of those 100 source data rows.

## Data Dictionary
**SubjectID** Its range is from 1 to 30, and it identifies the subject who performed the activity for each window sample.

**Activity** one of the following values: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS

###Means of Measurement Aggregates
Each of the "Means of Measurement Aggregates" column names is prefixed with `mean_`.

What follows that prefix is the _unaltered_ name of the original aggregated measurement.

Here is a summary of the naming of those aggregated measurement column names:

|**Domain Prefix**                                                                                | `t` for time domain signals      |
|                                                                                                 | `f` for frequency domain signals |
|**Acceleration Signal Type**                                                                     | `Body`                           |
|                                                                                                 | `Gravity`                        |
|**Signal Source**                                                                                | `Acc` for accelerometer          |
|                                                                                                 | `Gyro` for gyroscope             |
|**Linear Acceleration and Angular Velocity (Body only) [_when present_]**                        | `Jerk`                           |
|**Magnitude of three-dimensional signals (calculated using the Euclidean norm) [_when present_]**| `Mag`                            |
|**Aggregated Measurement**                                                                       | `-mean()` for mean value         |
|                                                                                                 | `-std()` for standard deviation  |
|**Axial Direction (3-axial signal in the X, Y, or Z direction) [_when present_]**                | `-X`                             |
|                                                                                                 | `-Y`                             |
|                                                                                                 | `-Z`                             |

What follows is a list of all the "Means of Measurement Aggregates" column names, based on the naming rules above:

    mean_tBodyAcc-mean()-X
    mean_tBodyAcc-mean()-Y
    mean_tBodyAcc-mean()-Z
    mean_tBodyAcc-std()-X
    mean_tBodyAcc-std()-Y
    mean_tBodyAcc-std()-Z
    mean_tGravityAcc-mean()-X
    mean_tGravityAcc-mean()-Y
    mean_tGravityAcc-mean()-Z
    mean_tGravityAcc-std()-X
    mean_tGravityAcc-std()-Y
    mean_tGravityAcc-std()-Z
    mean_tBodyAccJerk-mean()-X
    mean_tBodyAccJerk-mean()-Y
    mean_tBodyAccJerk-mean()-Z
    mean_tBodyAccJerk-std()-X
    mean_tBodyAccJerk-std()-Y
    mean_tBodyAccJerk-std()-Z
    mean_tBodyGyro-mean()-X
    mean_tBodyGyro-mean()-Y
    mean_tBodyGyro-mean()-Z
    mean_tBodyGyro-std()-X
    mean_tBodyGyro-std()-Y
    mean_tBodyGyro-std()-Z
    mean_tBodyGyroJerk-mean()-X
    mean_tBodyGyroJerk-mean()-Y
    mean_tBodyGyroJerk-mean()-Z
    mean_tBodyGyroJerk-std()-X
    mean_tBodyGyroJerk-std()-Y
    mean_tBodyGyroJerk-std()-Z
    mean_tBodyAccMag-mean()
    mean_tBodyAccMag-std()
    mean_tGravityAccMag-mean()
    mean_tGravityAccMag-std()
    mean_tBodyAccJerkMag-mean()
    mean_tBodyAccJerkMag-std()
    mean_tBodyGyroMag-mean()
    mean_tBodyGyroMag-std()
    mean_tBodyGyroJerkMag-mean()
    mean_tBodyGyroJerkMag-std()
    mean_fBodyAcc-mean()-X
    mean_fBodyAcc-mean()-Y
    mean_fBodyAcc-mean()-Z
    mean_fBodyAcc-std()-X
    mean_fBodyAcc-std()-Y
    mean_fBodyAcc-std()-Z
    mean_fBodyAccJerk-mean()-X
    mean_fBodyAccJerk-mean()-Y
    mean_fBodyAccJerk-mean()-Z
    mean_fBodyAccJerk-std()-X
    mean_fBodyAccJerk-std()-Y
    mean_fBodyAccJerk-std()-Z
    mean_fBodyGyro-mean()-X
    mean_fBodyGyro-mean()-Y
    mean_fBodyGyro-mean()-Z
    mean_fBodyGyro-std()-X
    mean_fBodyGyro-std()-Y
    mean_fBodyGyro-std()-Z
    mean_fBodyAccMag-mean()
    mean_fBodyAccMag-std()
    mean_fBodyBodyAccJerkMag-mean()
    mean_fBodyBodyAccJerkMag-std()
    mean_fBodyBodyGyroMag-mean()
    mean_fBodyBodyGyroMag-std()
    mean_fBodyBodyGyroJerkMag-mean()
    mean_fBodyBodyGyroJerkMag-std()
