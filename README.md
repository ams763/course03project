##Course Project: Cleaning and Summarizing Smartphone Data

Andrew Shoffner  
Data Science Course 3: Getting and Cleaning Data  
Johns Hopkins University, Coursera  

###Readme

 
The script run_analysis.R contains two main functions, `get_data` and `analyze_data`.
 
The function `get_data`, called without arguments, downloads a zip file containing all necessary data and documentation into a "data" subdirectory of the working directory, if the zip file does not already exist there. It then extracts the contents into the "data" subdirectory, overwriting any existing copies. If the zip file does exist, the user can overwrite this as well by using `get_data(download = TRUE)`; a new copy will be downloaded from the study website. 
 
The function `analyze_data`, called without arguments, processes the downloaded study data into two R dataframes and outputs these as elements of a list of length 2. The dataframes are a data set and a summary table. See code book for details.

Much of the work of `analyze_data` is done by helper functions. Some can be run from the command line, but most are internal to `analyze_data`. They are as follows:


*`extract_jth` outputs a vector whose nth element is the jth element of the nth element of the input list.
*`feature_parse` converts the study's variable list to an R character vector, and generates a logical vector indexing only "mean" and "std" variables.
*`clean_data` converts the study's measurement data to a large matrix.
*`select_data` selects only "mean" and "std" variables from an input data set (matrix or data frame), and labels it with variable names. Returns a data frame.
*`activity_parse` generates a vector of activity labels whose position corresponds to their code number.
*`append_activity` adds an "activity" id variable to the input data frame.
*`append_subject` adds a "subjectid" id variable to the input data frame.
*`factorize_subject` converts the input data frame's "subjectid" variable to a factor.
*`make_summary` generates a short data frame whose variables are means of the input data frame's measure variables.

*end of document*
