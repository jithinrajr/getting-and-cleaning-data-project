
library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","./data")
unzip("data")


#step1 : Merges the training and the test sets to create one data set.

#reading test
xtest <- read.table(file = "./UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
ytest<-read.table(file = "./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "")
subject.test <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "")
test <- cbind(subject.test, ytest, xtest)

#reading train
xtrain <- read.table(file = "./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "") 
ytrain <-  read.table(file = "./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "")
subject.train <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "")
train <- cbind(subject.train, ytrain, xtrain )

# merging train & test

x<- rbind(xtrain,xtest)
y<- rbind(ytrain,ytest)
subject <- rbind(subject.train, subject.test)
names(subject) <- "subject"

#step 2 :Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table(file = "./UCI HAR Dataset/features.txt", header = FALSE, sep ="")
features.mean.sd<- grepl("(.*)mean[^Freq](.*)|(.*)std(.*)", features$V2)
x.mean.sd <- x[,features.mean.sd]

#step:3 Uses descriptive activity names to name the activities in the data set

activity.labels <- read.table(file = "./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep ="")
activity.labels$V2 <- tolower(activity.labels$V2)
activity.labels$V2 <- gsub("_","",activity.labels$V2)
y[,1] <- activity.labels[y[,1],2]
colnames(y) <- "activity"



#step: 4 Appropriately labels the data set with descriptive variable names.
names(x.mean.sd) <- tolower(gsub("\\(|\\)", "", features[features.mean.sd,2]))
names(x.mean.sd) <- make.names(names(x.mean.sd))
dat <- cbind(subject, y, x.mean.sd)

#step :5 From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity and each subject.

average <- aggregate(dat, by= list(dat$subject, dat$activity), mean)
average <- average[,-c(3,4)]
colnames(average)[1] <- "subject"
colnames(average)[2] <- "activity"
write.table(average, './UCI HAR Dataset/average.txt')



