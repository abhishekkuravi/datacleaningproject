##Steps for executing the Coursera - Getting and Cleaning Data Course Project

1. Set your desired working directory
2. Create a folder named "project" in the working directory
3. Download the R script named "run_analysis.R" in the same working directory
4. Procure data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip it directly into the project folder
5. Source the run_analysis.R file using the "source" command in R or R-Studio
6. You will find two output files: "Combined Data.txt" and "Tidy Data.txt"
7. "Tidy Data.txt" is the desired output for the course project
8. Use read.table("Tidy Data.txt") to read in the file and inspect it for 68 columns (subject, activity and features columns) and 180 rows