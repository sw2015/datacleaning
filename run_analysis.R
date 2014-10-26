############# -1. preliminaries

#set working directory. This directory contains the test and train data sets that were downloaded from the web. 

setwd("/Users/datascience")

#install reshape2 package
# install.packages("reshape2")

############ 0. load data sets and merge test and train data sets by columns separately


#load test data

X_test <- read.table("./cleaning/Project/test/X_test.txt", sep="", header=FALSE)
y_test <- read.table("./cleaning/Project/test/y_test.txt", sep="", header=FALSE)
subject_test <- read.table("./cleaning/Project/test/subject_test.txt", sep="", header=FALSE)

#load train data

X_train <- read.table("./cleaning/Project/train/X_train.txt", sep="", header=FALSE)
y_train <- read.table("./cleaning/Project/train/y_train.txt", sep="", header=FALSE)
subject_train <- read.table("./cleaning/Project/train/subject_train.txt", sep="", header=FALSE)

#merge columns of test data in the order of subject, y_test and X_test

mergedtest <- cbind(subject_test, y_test, X_test)

#merge columns of train data in the order of subject, y_train and X_train

mergedtrain <- cbind(subject_train, y_train, X_train)


############ 1. merge the training and the test sets together to create one data set by rows


merged <- rbind(mergedtest,mergedtrain)

feature <- read.table("./cleaning/Project/features.txt", sep="", header=FALSE)

# add column names to it

names(merged) <- c("Subject", "activitylabel", as.character(feature[,2]))


############ 2. extract only the measurements on the mean and standard deviation
############ for each measurement, and the resulting data set is mean_std_measure


# choose activities containing mean()

title_mean <- grep("mean\\(\\)", names(merged), value=TRUE)

# choose activities containing std()

title_std <- grep("std\\(\\)", names(merged), value=TRUE)

# merge subject, activitylabel columns with the mean and std columns

mean_std_measure <- merged[, c("Subject", "activitylabel", title_mean, title_std)]


############### 3. replace activity labels with activity names, and order
############### the data set by subjects and acitivty labels(for tie breaking)


activity_labels <- read.table("./cleaning/Project/activity_labels.txt", sep="", header=FALSE)

names(activity_labels) <- c("activitylabel", "Activity")

mean_std_measure <- merge(activity_labels, mean_std_measure, by = "activitylabel")

mean_std_measure <- mean_std_measure[order(mean_std_measure$Subject, mean_std_measure$activitylabel), ]

# activity labels are redundant and therefore we remove them

mean_std_measure$activitylabel <- NULL

# put subjects on the first column

mean_std_measure[, c(1, 2)] <- mean_std_measure[, c(2, 1)]

# swap column names between the first and the second

names(mean_std_measure)[c(1, 2)] <- names(mean_std_measure)[c(2, 1)]


############### 4. label the data set with descriptive activity names


names(mean_std_measure) <- gsub("^t", "Time", names(mean_std_measure))

names(mean_std_measure) <- gsub("^f", "Freq", names(mean_std_measure))

names(mean_std_measure) <- gsub("mean", "Mean", names(mean_std_measure))

names(mean_std_measure) <- gsub("std", "Std", names(mean_std_measure))

names(mean_std_measure) <- gsub("-", "", names(mean_std_measure))

names(mean_std_measure) <- gsub("\\(\\)", "", names(mean_std_measure))


############### 5. creates a second, independent tidy data set with the average
############### of each variable for each activity and each subject.


library(reshape2)

melt_measure <- melt(mean_std_measure, id=c("Subject", "Activity"))

average_measure <- dcast(melt_measure, Subject + Activity ~ variable, fun.aggregate=mean)

# write to a file on computer

write.table(average_measure, "tidy_data.txt", row.names= FALSE)


