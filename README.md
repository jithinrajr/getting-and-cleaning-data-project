# getting-and-cleaning-data-project

#step1 : Merges the training and the test sets to create one data set.

  All the values read into the variables described in code book. read.table() function is used to read .txt files
  variable x is created by applying cbind to xtrain and xtest. similarly variable y is also created.

#step 2 :Extracts only the measurements on the mean and standard deviation for each measurement.

  function grepl("(.*)mean[^Freq](.*)|(.*)std(.*)", features$V2) is used extract only mean and standerd deviation values

#step:3 Uses descriptive activity names to name the activities in the data set
  function gsub("_","",activity.labels$V2) 

#step: 4 Appropriately labels the data set with descriptive variable names
  gsub("\\(|\\)", "", features[features.mean.sd,2]) and make.name() functions are used 

#step :5 From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity and each subject.

  aggregate() function is used to calculate mean of each variable




