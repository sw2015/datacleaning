## Introduction

This project is intended to generate a tidy data file from the UCI HAR Dataset. The UCI HAR Dataset consists of accelerometer readings from 30 individuals (labels 1 to 30) engaged in 6 activities (1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING).

## Code

The code file is run_analysis.R. Briefly we merge the test and training files from the UCI HAR Dataset into one data file. We choose the columns of subject, activity, mean and standard diviation to form a new data file. On the new file we use gsub to clean variable names. Also we use the reshape2 package to generate the output file: tidy_data.txt

To run the script, type in R
source(run_analysis.R). Make sure that you are in a directory that contains the data files.

More information on variables is in CodeBook.md and more comments are in run_analysis.R

