## Read all necessary data files
X_test <- read.table(filename)

filename <- file.path("UCI HAR Dataset","test","y_test.txt")
y_test <- read.table(filename)

filename <- file.path("UCI HAR Dataset","test","subject_test.txt")
subject_test <- read.table(filename)

filename <- file.path("UCI HAR Dataset","train","X_train.txt")
X_train <- read.table(filename)

filename <- file.path("UCI HAR Dataset","train","y_train.txt")
y_train <- read.table(filename)

filename <- file.path("UCI HAR Dataset","train","subject_train.txt")
subject_train <- read.table(filename)

filename <- file.path("UCI HAR Dataset","features.txt")
features <- read.table(filename)
features$V2 <- as.character(features$V2)

filename <- file.path("UCI HAR Dataset","activity_labels.txt")
activity_labels <- read.table(filename)


## Merge training and test sets
x <- rbind(X_test,X_train)
y <- rbind(y_test,y_train)
subject <- rbind(subject_test,subject_train)

## Remove obsolete data from environment
rm(X_test, X_train, y_test, y_train, subject_test, subject_train)


## Extract measurements on mean and std
x <- x[,grep("mean|std",features$V2)]

## Label data set with descriptive names
names(x) <- gsub("[.]","",make.names(features$V2[grep("mean|std",features$V2)]))
names(y) <- "activity"
names(subject) <- "subject"

## Uses descriptive activity names to name the activities in the data
for (i in seq(nrow(activity_labels))){
  y$activity <- gsub(activity_labels[i,1],activity_labels[i,2],y$activity)
}

##
merged <- cbind(x,y,subject)
library(dplyr)
a <- group_by(merged,subject,activity)
tidy_data_set <- summarise_all(a,mean)

write.table(tidy_data_set,"tidy_data_set.txt",row.name = FALSE)
