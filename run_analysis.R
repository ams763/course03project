
library(dplyr)
library(reshape2)

################

##Download file if not already in working directory/data (or if user
##sets download = TRUE), extract and overwrite existing copies
get_data <- function(download = FALSE) {
        
        if (!file.exists("./data")) {
                dir.create("./data")
        }
        zippath <- "./data/samsungdata.zip"
        if (download | !file.exists(zippath)) {
                fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(fileurl, zippath)
        }
        unzip(zippath, exdir = "./data")
        setwd("./data/")
}

################

##Input any list, build character vector from jth entry of each list element
extract_jth <- function(x, j) {
        output_vector <- character(0)
        for(i in seq_along(x)) {
                output_vector <- c(output_vector, x[[c(i, j)]])
        }
        output_vector
}
##Input features.txt, return list of formatted feature names matched
##to logicals for subsetting dataset
feature_parse <- function(filename) {
        ##Input UNFORMATTED feature vector, return logical
        ##vector for selecting mean and standard deviation
        select_features <- function(x) {
                grepl("mean\\(\\)", x) | grepl("std\\(\\)", x)
        }
        ##Input unformatted feature vector, return formatted feature vector
        feature_format <- function(vec) {
                ##Format each component of a decomposed feature name
                element_format <- function(x) {
                        capitalize <- function(s) {
                                paste0(toupper(substring(s, 1, 1)),
                                       substring(s, 2))
                        }
                        ##Remove reduplications
                        x[1] <- sub("BodyBody", "Body", x[1])
                        ##Capitalize statistic name and remove parens
                        if (!is.na(x[2])) {
                                x[2] <- capitalize(x[2])
                                x[2] <- sub("\\(\\)", "", x[2])
                        }
                        ##Output pasted string
                        if (!is.na(x[3])) {
                                paste0(x[1], x[2], x[3])
                        } else if (!is.na(x[2])) {
                                paste0(x[1], x[2])
                        } else {
                                x[1]
                        }
                }
                sapply(strsplit(vec, "-"), element_format)
        }
        raw_text <- readLines(filename)
        feature_vector <- extract_jth(strsplit(raw_text, " "), j = 2)
        list("names" = feature_format(feature_vector),
             "index" = select_features(feature_vector))
}
##Main function
analyze_data <- function() {
        ##Input dataset filename, return matrix
        clean_data <- function(file) {
                raw_text <- readLines(file)
                better_text <- sub("^ +", "", raw_text)
                split_lines <- strsplit(better_text, split = " +")
                clean_lines <- lapply(split_lines, as.numeric)
                matrix(unlist(clean_lines), 
                       nrow = length(clean_lines), 
                       byrow = TRUE)
        }
        ##Input matrix from clean_data, list from feature_parse, 
        ##return labelled dataframe of only selected measurements
        select_data <- function(dataset, features_list) {
                selection_vector <- features_list$index
                colnames(dataset) <- features_list$names
                data.frame(dataset[ , selection_vector])
        }
        ##Input activity_labels.txt, return vector of activity labels
        activity_parse <- function(file) {
                raw_text <- readLines(file)
                activity_list <- strsplit(raw_text, " ")
                extract_jth(activity_list, 2)
        }
        ##Input labelled dataframe, corresponding activity id filename, 
        ##and activity labels from activity_parse; return dataframe with activity
        ##variable
        append_activity <- function(dataset, activity_file, activity_labels) {
                x <- as.numeric(readLines(activity_file))
                activity_vector <- sapply(x, function(i) {activity_labels[i]})
                cbind(activity = activity_vector, dataset)
        }
        ##Input labelled dataframe, subject id file, return dataframe
        ##with subject variable
        append_subject <- function(dataset, subject_file){
                subject_vector <- as.integer(readLines(subject_file))
                cbind(subjectid = subject_vector, dataset)
        }
        ##Input a dataset, return the dataset with subjectid variable
        ##converted to a factor
        factorize_subject <- function(x) {
                mutate(x, subjectid = as.factor(subjectid))
        }
        ##Input labelled, augmented dataframe, return dataframe of feature
        ##means for each subjectid-activity pair
        make_summary <- function(x) {
                y <- melt(x, id = c("subjectid", "activity"))
                dcast(y, subjectid+activity ~ variable, mean)
        }

        trainxfile <- "./UCI HAR Dataset/train/X_train.txt"
        trainyfile <- "./UCI HAR Dataset/train/y_train.txt"
        trainsubfile <- "./UCI HAR Dataset/train/subject_train.txt"

        testxfile <- "./UCI HAR Dataset/test/X_test.txt"
        testyfile <- "./UCI HAR Dataset/test/y_test.txt"
        testsubfile <- "./UCI HAR Dataset/test/subject_test.txt"
        
        activitiesfile <- "./UCI HAR Dataset/activity_labels.txt"
        featuresfile <- "./UCI HAR Dataset/features.txt"

        activities <- activity_parse(activitiesfile)
        features <- feature_parse(featuresfile)
        
        trainx1 <- select_data(clean_data(trainxfile), features)
        trainx2 <- append_activity(trainx1, trainyfile, activities)
        trainset <- append_subject(trainx2, trainsubfile)
        
        testx1 <- select_data(clean_data(testxfile), features)
        testx2 <-  append_activity(testx1, testyfile, activities)
        testset <- append_subject(testx2, testsubfile)
        
        output1 <- factorize_subject(rbind(trainset, testset))
        output2 <- make_summary(output1)
        
        list(dataset = output1, datasummary = output2)
}