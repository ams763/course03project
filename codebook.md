#Course Project: Cleaning and Summarizing Smartphone Data

Andrew Shoffner  
Data Science Course 3: Getting and Cleaning Data  
Johns Hopkins University, Coursera  

##Study Design

The script run_analysis.R is used to get, format, and process data from a study carried out at the Università degli Studi di Genova in which smartphone accelerometer and gyroscope data were collected from 30 subjects while they performed 6 different activities. The subjects were randomly divided into two groups, and a data set was produced for each group. Each data set contains thousands of observations of 561 variables which abstract mathematical features from the raw sensor output over short time slices. Each observation corresponds to a 2.56 s time slice of sensor output. More information on the study can be found in the README.txt file of the study data, available as a [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The script contains a function `analyze_data`, called without arguments, which processes the downloaded study data into two R data frames and outputs these as elements of a list of length 2. The data frames are a data set and a summary table.

The data set's ID variables are study subject and activity, and its measure variables are a subset of the study's 561 variables, namely the 66 variables that take either the mean or the standard deviation of some measurement observed over a time slice. The data set contains all observations from both of the study data sets, 10,299 in total. See below for list and descriptions of variables.

The summary table collapses all observations for each subject-activity pair into a single observation, whose measure variables contain means of the corresponding measure variables taken over all observations of the subject-activity pair. The result is a data frame of 180 observations, i.e. one for each possible subject-activity pair. For example, if Subject 12 was observed walking in 53 different time slices, the summary table will contain a single row with subjectid = 12 and activity = walking, and the value of tBodyAccMeanX in this row will be the mean of 53 different observations of tBodyAccMeanX in the data set.

The steps performed by `analyze_data` are as follows:

1. Generate an ordered list of the 6 activities.
2. Generate an ordered list of the 561 mathematical feature names, formatted for use in data frames. 
3. Generate an index vector to select only mean and standard deviation features. 
4. Convert the study's "test" data set to an R data frame. 
  1. Convert the text file containing observed data to an R matrix. 
  2. Convert the matrix to a data frame and label with feature names. 
  3. Select only the mean and standard deviation feature variables. 
  4. Append ID variables for activity and subject to the data frame. 
5. Convert the study's "train" data set to an R data frame in the same manner.
6. Merge the data frames from steps 4 and 5. The train/test distinction will be lost.
7. Generate a summary table for the data frame from step 6.

##Code Book

###Remarks

Variable names for the data set and the summary table are identical.
 
The general formula for the retained mathematical feature names has six components selected from:

Component                  | Abbreviation
-------------------------- | ---------------------         
Time or Frequency          | t, f
Body or Gravity            | Body, Grav
Accelerometer or Gyroscope | Acc, Gyr
Jerk                       | NULL, Jerk
Mean or Standard Deviation | Mean, Std
Dimension or Magnitude     | NULL, X, Y, Z, Mag

* "Frequency" refers to features obtained by a Fast Fourier Transform on the corresponding "time" feature.
* "Body" and "Gravity" refer to mathematically separated components of accelerometer measurements.
* "Jerk" refers to features obtained by differentiation with respect to time.
* "Magnitude" is the Euclidean norm of the X, Y, and Z measurements for the named feature. "Mag" appears earlier in the name than dimension labels.
 
 
###Variables
 
1. subjectid 
  + Integers 1 - 30 representing the 30 study subjects
2. activity
	+ LAYING
	+ SITTING
	+ STANDING
	+ WALKING
	+ WALKING_DOWNSTAIRS
	+ WALKING_UPSTAIRS
3. tBodyAccMeanX
	+ Mean of accelerometer signal over time due to body motion in x dimension 
4. tBodyAccMeanY
	+ Mean of accelerometer signal over time due to body motion in y dimension 
5. tBodyAccMeanZ
	+ Mean of accelerometer signal over time due to body motion in z dimension 
6. tBodyAccStdX
	+ Standard deviation of accelerometer signal over time due to body motion in x dimension 
7. tBodyAccStdY
	+ Standard deviation of accelerometer signal over time due to body motion in y dimension
8. tBodyAccStdZ
	+ Standard deviation of accelerometer signal over time due to body motion in z dimension
9. tGravityAccMeanX
	+ Mean of accelerometer signal over time due to gravity in x dimension 
10. tGravityAccMeanY
	+ Mean of accelerometer signal over time due to gravity in y dimension 
11. tGravityAccMeanZ
	+ Mean of accelerometer signal over time due to gravity in z dimension 
12. tGravityAccStdX
	+ Standard deviation of accelerometer signal over time due to gravity in x dimension 
13. tGravityAccStdY
	+ Standard deviation of accelerometer signal over time due to gravity in y dimension 
14. tGravityAccStdZ
	+ Standard deviation of accelerometer signal over time due to gravity in z dimension 
15. tBodyAccJerkMeanX
	+ Mean of derivative of accelerometer signal over time due to body motion in x dimension
16. tBodyAccJerkMeanY
	+ Mean of derivative of accelerometer signal over time due to body motion in y dimension
17. tBodyAccJerkMeanZ
	+ Mean of derivative of accelerometer signal over time due to body motion in z dimension
18. tBodyAccJerkStdX
	+ Standard deviation of derivative of accelerometer signal over time due to body motion in x dimension
19. tBodyAccJerkStdY
	+ Standard deviation of derivative of accelerometer signal over time due to body motion in y dimension
20. tBodyAccJerkStdZ
	+ Standard deviation of derivative of accelerometer signal over time due to body motion in z dimension
21. tBodyGyroMeanX
	+ Mean of gyroscope signal over time due to body motion in x dimension 
22. tBodyGyroMeanY
	+ Mean of gyroscope signal over time due to body motion in y dimension 
23. tBodyGyroMeanZ
	+ Mean of gyroscope signal over time due to body motion in z dimension 
24. tBodyGyroStdX
	+ Standard deviation of gyroscope signal over time due to body motion in x dimension 
25. tBodyGyroStdY
	+ Standard deviation of gyroscope signal over time due to body motion in y dimension
26. tBodyGyroStdZ
	+ Standard deviation of gyroscope signal over time due to body motion in z dimension
27. tBodyGyroJerkMeanX
	+ Mean of derivative of gyroscope signal over time due to body motion in x dimension 
28. tBodyGyroJerkMeanY
	+ Mean of derivative of gyroscope signal over time due to body motion in y dimension 
29. tBodyGyroJerkMeanZ
	+ Mean of derivative of gyroscope signal over time due to body motion in z dimension 
30. tBodyGyroJerkStdX
	+ Standard deviation of derivative of gyroscope signal over time due to body motion in x dimension 
31. tBodyGyroJerkStdY
	+ Standard deviation of derivative of gyroscope signal over time due to body motion in y dimension
32. tBodyGyroJerkStdZ
	+ Standard deviation of derivative of gyroscope signal over time due to body motion in z dimension
33. tBodyAccMagMean
	+ Mean of magnitude of accelerometer signal over time due to body motion
34. tBodyAccMagStd
	+ Standard deviation of magnitude of accelerometer signal over time due to body motion
35. tGravityAccMagMean
	+ Mean of magnitude of accelerometer signal over time due to gravity
36. tGravityAccMagStd
	+ Standard deviation of magnitude of accelerometer signal over time due to gravity
37. tBodyAccJerkMagMean
	+ Mean of magnitude of derivative of accelerometer signal over time due to body motion
38. tBodyAccJerkMagStd
	+ Standard deviation of magnitude of derivative of accelerometer signal over time due to body motion
39. tBodyGyroMagMean
	+ Mean of magnitude of gyroscope signal over time due to body motion
40. tBodyGyroMagStd
	+ Standard deviation of magnitude of gyroscope signal over time due to body motion
41. tBodyGyroJerkMagMean
	+ Mean of magnitude of derivative of gyroscope signal over time due to body motion
42. tBodyGyroJerkMagStd
	+ Standard deviation of magnitude of derivative of gyroscope signal over time due to body motion
43. fBodyAccMeanX
	+ Mean of FFT of accelerometer signal over time due to body motion in x dimension 
44. fBodyAccMeanY
	+ Mean of FFT of accelerometer signal over time due to body motion in y dimension 
45. fBodyAccMeanZ
	+ Mean of FFT of accelerometer signal over time due to body motion in z dimension 
46. fBodyAccStdX
	+ Standard deviation of FFT of accelerometer signal over time due to body motion in x dimension 
47. fBodyAccStdY
	+ Standard deviation of FFT of accelerometer signal over time due to body motion in y dimension 
48. fBodyAccStdZ
	+ Standard deviation of FFT of accelerometer signal over time due to body motion in z dimension 
49. fBodyAccJerkMeanX
	+ Mean of FFT of derivative of accelerometer signal over time due to body motion in x dimension 
50. fBodyAccJerkMeanY
	+ Mean of FFT of derivative of accelerometer signal over time due to body motion in y dimension 
51. fBodyAccJerkMeanZ
	+ Mean of FFT of derivative of accelerometer signal over time due to body motion in z dimension 
52. fBodyAccJerkStdX
	+ Standard deviation of FFT of derivative of accelerometer signal over time due to body motion in x dimension 
53. fBodyAccJerkStdY
	+ Standard deviation of FFT of derivative of accelerometer signal over time due to body motion in y dimension 
54. fBodyAccJerkStdZ
	+ Standard deviation of FFT of derivative of accelerometer signal over time due to body motion in z dimension 
55. fBodyGyroMeanX
	+ Mean of FFT of derivative of gyroscope signal over time due to body motion in x dimension 
56. fBodyGyroMeanY
	+ Mean of FFT of derivative of gyroscope signal over time due to body motion in y dimension 
57. fBodyGyroMeanZ
	+ Mean of FFT of derivative of gyroscope signal over time due to body motion in z dimension 
58. fBodyGyroStdX
	+ Standard deviation of FFT of derivative of gyroscope signal over time due to body motion in x dimension 
59. fBodyGyroStdY
	+ Standard deviation of FFT of derivative of gyroscope signal over time due to body motion in y dimension 
60. fBodyGyroStdZ
	+ Standard deviation of FFT of derivative of gyroscope signal over time due to body motion in z dimension 
61. fBodyAccMagMean
	+ Mean of magnitude of FFT of accelerometer signal over time due to body motion
62. fBodyAccMagStd
	+ Standard deviation of magnitude of FFT of accelerometer signal over time due to body motion
63. fBodyAccJerkMagMean
	+ Mean of magnitude of FFT of derivative of accelerometer signal over time due to body motion
64. fBodyAccJerkMagStd
	+ Standard deviation of magnitude of FFT of derivative of accelerometer signal over time due to body motion
65. fBodyGyroMagMean
	+ Mean of magnitude of FFT of gyroscope signal over time due to body motion
66. fBodyGyroMagStd
	+ Standard deviation of magnitude of FFT of gyroscope signal over time due to body motion
67. fBodyGyroJerkMagMean
	+ Mean of magnitude of FFT of derivative of gyroscope signal over time due to body motion
68. fBodyGyroJerkMagStd
	+ Standard deviation of magnitude of FFT of derivative of gyroscope signal over time due to body motion
	
*end of document*
