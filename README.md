# Getting and Cleaning Data Course Project

This repository contains the R script and documentation for the Coursera
**Getting and Cleaning Data** course project, based on the
**Human Activity Recognition Using Smartphones Dataset (UCI HAR Dataset)**.

## Files in this Repository

- `run_analysis.R`  
  Main R script that performs data cleaning, transformation, and summarization.

- `CodeBook.md`  
  Describes the variables, data, and transformations used to generate
  `summarydata.txt`.

## How the Script Works

The script `run_analysis.R` performs the following steps:

### 1. Load required package
The `dplyr` package is used for data manipulation.

### 2. Read raw data
The script reads:
- Training and test measurement data (`X_train.txt`, `X_test.txt`)
- Subject identifiers (`subject_train.txt`, `subject_test.txt`)
- Activity labels (`y_train.txt`, `y_test.txt`)
- Feature names (`features.txt`)

### 3. Merge training and test datasets
Subject IDs, activity labels, and a group indicator (`train` or `test`)
are added to each dataset, and the two datasets are combined into one.

### 4. Extract mean and standard deviation measurements
Only variables containing `mean()` or `std()` are retained, along with
`subject`, `activity`, and `group`.

### 5. Use descriptive activity names
Numeric activity codes (1–6) are replaced with descriptive activity names
(e.g., WALKING, SITTING) using `activity_labels.txt`.

### 6. Label variables with descriptive names
Variable names are cleaned and expanded to improve readability:
- `t` → `Time`
- `f` → `Frequency`
- `Acc` → `Acceleration`
- `Gyro` → `Gyroscope`
- `mean()` → `Mean`
- `std()` → `Std`

Special characters such as parentheses and hyphens are removed.

### 7. Create the final tidy data set
The data are grouped by **subject** and **activity**, and the mean of each
measurement variable is calculated.

### 8. Output
The final tidy data set is written to `summarydata.txt`.

## How to Run the Script

1. Place the UCI HAR Dataset folder in the directory named "materials" in the working directory.
2. Run the script in R
