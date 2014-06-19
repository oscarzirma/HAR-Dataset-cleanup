Readme for run_analysis.R
----

This script will load and process the Human Activity Recognition Using Smartphones Dataset.

**If HAR dataset is in the working directory, this is what it does:**

1. Load subject, X, and y files from 'test' and 'train' directories.
2. Combine 'train' and 'test' files, for subject, X, and y.
3. Load features file, and assigns those features as column names.
4. Add the subject ID as a column in X ('Subject').
5. Load activity_labels and use it to convert activities in 'y' to descriptive labels.
6. Add the descriptive activity label to X ('Activity').
7. Rearrange columns to make Subject and Activity first and second columns, respectively.

**This basic tidy dataset is then used to produce two futher processed dataset. For the first:**

1. Pull only the columns containing mean or standard deviation values. See Note1.
2. Save this dataset as tidyHAR_1.csv. It is saved in csv format without row names.

**For the second:**

1. In each column, find the mean value for each subject during each activity.
2. Save this dataset as tidyHAR_2.csv. It is saved in csv format without row names.

**Note1**

Columns are considered to contain mean or standard deviation value if the column name contains 'mean' or
'std', but not 'meanFreq'. The rationale behind this is that these columns contain mean or standard deviation 
values of a particular measure. This excludes mean frequency values, which seem to me to be of a different class of values than a simple mean or std.
