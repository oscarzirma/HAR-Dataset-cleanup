#This script will load the UCI HAR dataset and turn it into two 'Tidy' data sets: tidy_HAR1.csv and tidy_HAR2.csv
#HAR1 contains only columns that were mean and standard deviation values
#HAR2 contains the mean of all values for each subject and each activity
setwd('~/Desktop/Working folder/Getting and cleaning data/Project/UCI HAR Dataset/')

#Get the activity labels and feature labels
activity_labels <- read.table('activity_labels.txt')
features <- read.table('features.txt')

#Load training data
subject_train <- read.table('./train/subject_train.txt')
y_train <- read.table('./train/y_train.txt')
X_train <- read.table('./train/X_train.txt')

#Load testing data
subject_test <- read.table('./test/subject_test.txt')
y_test <- read.table('./test/y_test.txt')
X_test <- read.table('./test/X_test.txt')

#Combine training and test datasets
subject <- unlist(rbind(subject_train,subject_test))
y <- unlist(rbind(y_train,y_test))
X <- rbind(X_train,X_test)

#Label columns
colnames(X) <- as.character(features$V2)

#Add the subject ID
X$Subject <- subject

#Make a labeled y vector that has descriptions of activity rather than numerical identifier
y_label = y
for (i in seq(1,nrow(activity_labels))) {
  y_label[y==i] <- as.character(activity_labels[i,2])
}
X$Activity <- y_label

#Rearrange columns to place Subject and Activity in first columns
nc = ncol(X)
X_r = cbind(X[,(nc-1):nc],X[,1:(nc-2)])

#Pull columns containing a mean or standard deviation
X_ms <- X_r[,c(1,2,grep('mean[^F]|std',colnames(X_r)))]

#Write tidy data 1 to file
write.csv(X_ms,file='tidyHAR_1.csv',row.names=FALSE)

#Create data set 2
#For each subject, get the mean value of each variable for each activity
k=1
X_mn = X_r[1,]
for (i in seq(1,max(subject))) {#For each subject
  print(i)
  for (j in seq(1,nrow(activity_labels))) { #For each activity
    X_mn[k,3:nc] = sapply(X_r[X_r$Subject==i&y==j,3:nc],mean) #Take the mean of all columns for each row containing this subject and activity
    X_mn[k,1] = i #subject id
    X_mn[k,2] = as.character(activity_labels[j,2]) #activity label
    k=k+1
  }
}
#Write tidy data 2 to file
write.csv(X_mn,file='tidyHAR_2.csv',row.names=FALSE)
