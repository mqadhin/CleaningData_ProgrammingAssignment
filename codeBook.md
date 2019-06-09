The run_analysis.R script retrieves and cleans data from the Human Activity Recognition Using Smartphones Data Set prepared by UCI. This script performs the following operations:<br/>
1. Merge the training and the test sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation for each measurement.
1. Uses descriptive activity names to name the activities in the data set
1. Appropriately labels the data set with descriptive variable names.
1. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
<br/>
**Data and variables**<br/>
1. **features** <- features.txt: 561 observations, 2 variables 
   - Set of features calculated from accelerometer and gyroscope 3-axial raw signal measurements.
1. **activities** <- activity_labels.txt : 6 observations, 2 variables
   - Links class labels with their activity name.
1. **subjectTest** <- test/subject_test.txt: 2947 observations, 1 variable
   - Each row identifies the subject who performed the activity for each test sample. 9 of 30 subjects tested.
1. xTest <- test/X_test.txt : 2947 observations, 561 variables 
   - Contains test data on the 561 measurements for accelerometer and gyroscope.
1. **yTest** <- test/y_test.txt : 2947 observations, 1 variable
   - Contains class labels for test data.
1. **subjectTrain** <- test/subject_train.txt : 7352 observations, 1 variable
   - Each row identifies the subject who performed the activity for each training sample. 21 of 30 subjects tested.
1. **xTrain** <- test/X_train.txt : 7352 observations, 561 variables 
   - Contains training data on the 561 measurements for accelerometer and gyroscope.
1. **yTrain** <- test/y_train.txt : 7352 observations, 1 variable
   - Contains class labels for training data.
<br/>
**Merge training and test sets to create one data set**<br/>
1. x uses rbind() to merge xTrain and xTest. Data frame of 10299 observations and 561 variables created.
1. y uses rbind() to merge yTrain and yTest. Data frame of 10299 observations and 1 variable created.
subjects uses rbind() to merge subjectTrain and subjectTest. Data frame of 10299 observations and 1 variable created.
1. data uses cbind() to merge x, y and subjects. Data frame of 10299 observations and 563 variables created.
<br/>
**Extract measurements on the mean and standard deviation**<br/>
1. dataLean uses as_tibble() and select() to convert data to tibble class and to extract measurements of mean and standard deviation, respectively. Tibble of 10299 observations and 68 variables created.
1. Only arithmetic mean variables are extracted, hence this dataset excludes meanFreq as it calculates weighted average and angle variables.
<br/>
**Use descriptive activity names for activities**<br/>
1. activity column in dataLean is given descriptive names adopted from activities table through sub setting.
<br/>
**Use descriptive variable names**<br/>
1. t in column names substituted with time.
1. f in column names substituted with frequency.
1. Acc in column names substituted with Accelerometer.
1. Gyro in column names substituted with Gyroscope.
1. Mag in column names substituted with Magnitude.
1. BodyBody in column names substituted with Body.
1. mean in column names substituted with Mean.
1. std in column names substituted with Std.
<br/>
**Create independent data set which averages each variable for each activity and subject**<br/>
1. dataTidy uses group_by() to group data by activity and subject.
1. dataTidy uses summarise_all() to calculate the mean of each variable by activity and subject. Tibble of 180 observations and 68 variables created.
1. Text file dataTidy.txt written using dataTidy
