library(dplyr)
# Merges the training and the test sets to create one data set.
testsj <- read.table("./materials/UCI HAR Dataset/test/subject_test.txt") # load test subjects
test <- read.table("./materials/UCI HAR Dataset/test/X_test.txt")    # load test sets
testlabels <- read.table("./materials/UCI HAR Dataset/test/Y_test.txt") # load test labels
trainsj <- read.table("./materials/UCI HAR Dataset/train/subject_train.txt") # load test subjects
train <- read.table("./materials/UCI HAR Dataset/train/X_train.txt") # load train sets
trainlabels <- read.table("./materials/UCI HAR Dataset/train/Y_train.txt") # load train labels
varname <- read.table("./materials/UCI HAR Dataset/features.txt")    # load features(variable names)

test <- mutate(test, 
               subject = testsj[,1],
               activity = testlabels[,1],
               group = "test"
               )   # merge the subjects, activities & group to test sets

train <- mutate(train, 
                subject = trainsj[,1], 
                activity = trainlabels[,1],
                group = "train"
                )   # merge the subjects, activities & group to train sets

names(test) <- c(varname[,2], "subject", "activity", "group")  # assign the features to variable names in test data
names(train) <- c(varname[,2], "subject", "activity", "group") # assign the features to variable names in train data

merged <- rbind(test, train) # merge the test and train data

# Extracts only the measurements on the mean and standard deviation for each measurement. 
merged_mean_std <- select(merged, 
                          contains("mean()") |
                            contains("subject") |
                            contains("std()") | 
                            contains("activity")|
                            contains("group"))

# Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("./materials/UCI HAR Dataset/activity_labels.txt",
  col.names = c("activity", "activity_name")
)
data_labeled <- merge(merged_mean_std, activity_labels,
              by = "activity",
              sort = FALSE
              )

# Appropriately labels the data set with descriptive variable names
names(data_labeled) <- names(data_labeled) |>
  gsub("^t", "Time", x = _) |>
  gsub("^f", "Frequency", x = _) |>
  gsub("Acc", "Acceleration", x = _) |>
  gsub("Gyro", "Gyroscope", x = _) |>
  gsub("mean\\(\\)", "Mean", x = _) |>
  gsub("std\\(\\)", "Std", x = _) |>
  gsub("[-()]", "", x = _)

# creates a second, independent tidy data set with the average of each variable for each activity and each subject.
summary_df <- data_labeled %>% 
  group_by(activity_name,subject) %>%
  summarise(across(everything(), mean), .groups = "drop")
write.table(summary_df, "./materials/UCI HAR Dataset/summarydata.txt", row.names = FALSE)
