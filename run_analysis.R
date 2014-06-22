# Download zipfile from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Save downloaded zipfile to your Data Specialization directory
# Unzip data

# Load variable & activity lookup tables
setwd('UCI HAR Dataset')
variable_lookup = read.table("features.txt")
activity_lookup = read.table("activity_labels.txt")

# Load training data
setwd('train')
subject_train = read.table("subject_train.txt")
X_train = read.table("X_train.txt")
y_train = read.table("y_train.txt") 

# Load test data
setwd('..')
setwd('test')
subject_test = read.table("subject_test.txt")
X_test = read.table("X_test.txt")
y_test = read.table("y_test.txt")
setwd('..')

# Merge training data & test data
subject_all = rbind(subject_train, subject_test)
X_all = rbind(X_train, X_test)
y_all = rbind(y_train, y_test)

# Determine which variables denote mean() or std()
column_numbers = c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44, 45, 46, 
            81, 82, 83, 84, 85, 86, 
            121, 122, 123, 124, 125, 126, 
            161, 162, 163, 164, 165, 166, 
            201, 202, 214, 215, 227, 228, 240, 241, 
            253, 254, 266, 267, 268, 269, 270, 271, 
            345, 346, 347, 348, 349, 350, 
            424, 425, 426, 427, 428, 429, 
            503, 504, 516, 517, 529, 530, 542, 543)

# Generate column labels
column_labels = NULL
for (c in column_numbers){
    column_labels = rbind(column_labels, as.character(variable_lookup[c,2]))
}

# Subset data
tidy_data = X_all[,column_numbers]

# Convert activity codes to activity descriptions
activity_name = NULL
for (a in y_all){
    activity_name = cbind(activity_name, as.character(activity_lookup[a,2]))
}

# Add subjects and activities to tidy data
# Update column labels as well
tidy_data = cbind(subject_all, y_all, activity_name, tidy_data)
column_labels = rbind('subject','activity_code','activity_description',column_labels)

# Rename columns
colnames(tidy_data) = column_labels

# Number of columns
col = ncol(tidy_data)

# Number of subjects
sub = max(tidy_data$subject)

# Number of activities
act = max(tidy_data$activity_code)

# Generate a matrix in which to store answers
ans = matrix(0, nrow = sub*act, ncol = col)
colnames(ans) = column_labels

# Calculate mean for each combination of subject and activity
for (s in 1:30){
    for (a in 1:6){
        X = tidy_data[which(tidy_data$subject == s & tidy_data$activity_code == a),]
        ans[(s-1)*act+a,1] = s
        ans[(s-1)*act+a,2] = a
        ans[(s-1)*act+a,3] = as.character(activity_lookup[a,2])
        for (c in 4:69){
            x = mean(X[,c])
            ans[(s-1)*act+a,c] = x
        }
    }
}

write.csv(ans, 'mean_by_subject_and_activity.csv', row.names = FALSE)
