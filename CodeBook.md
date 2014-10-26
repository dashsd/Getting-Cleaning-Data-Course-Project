Describes the variables, the data, and any transformations or work that has been performed to clean up the data.


STEP1: Merges the training and the test sets to create one data set.
  Read in data from the Training & Test sets using read.table().
  
STEP2: Extracts only the measurements on the mean and standard deviation for each measurement.
  Using grepl() to filter out patterns containing mean & std in the dataset.
  Store the extracted mean and standard deviation values in the variable sensorData_mean_std.
  
STEP3: Uses descriptive activity names to name the activities in the data set.
  Merge data subset using merge() with the activityType table using the descriptive activity names.
  
STEP4: Appropriately labels the data set with descriptive variable names.
  gsub() has been used for pattern replacement for appropriately labeling the data set.
  
STEP5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  "Tidydata.txt" has been created containing the final tidy data set using write.csv().
