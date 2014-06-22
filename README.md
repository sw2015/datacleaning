## Introduction

This project is intended to generate a tidy data file from the UCI HAR Dataset. The UCI HAR Dataset consists of accelerometer readings from 30 individuals (labeled 1 to 30) engaged in 6 activities (1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING).

## Code

The code file is run_analysis.R. Before running the script, we install reshape2 packages. And also we download the UCI data files from the web and store them in /Users/datascience/cleaning/Project directory. We first use cbind to merge X_test, y_test and subject_test in test from test directory into one data file, and then use cbind to merge X_train, y_train and subject_train in the train directory into another data file. After that we combine the two data files into one data file using rbind. We choose the columns of subject, activity, mean and standard diviation to form a new data file. On the new file we use gsub to clean variable names, that is, we get more readable variable names. Also we use the reshape2 package to compute means of the columns of interest. In particular, we use functions melt and dcast in this case. The output from the mean computation is written into a text file: tidy_data.txt

To run the script make sure that you are in a directory that contains the data files.

More information on variables is in CodeBook.md and more comments are in run_analysis.R

