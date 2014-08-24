Coursera's Getting and Cleaning Data Course Project
========================================
I though that this was a great and timely project. Recently I bought a Jawbone Up24 band to track my sleep and daily exercise levels.
The data used in this project is sensor data in a Samsung Galaxy II phone attached to a group of voulunteers. More information can be
found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

These are the instructions on how to run the run_anlysis.R script:
1) Download the zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to your working directory.
2) Using tool of choice (WinRar, Winzip, 7zip, etc.) do an 'unzip here' command and the directory 'UCI HAR Dataset' is created.
3) Open the script "run_analysis.R" in RStudio 
4) Use source("run_analysis.R") command in RStudio
5) run_analysis.R produces two output files:
	a) merged_data.txt 
	b) data_with_means.txt
6) In RStudio use the command data<-read.table("data_with_means.txt") to read the data_with_means file.
	This command allows the user to read the calculated averages for each of the 6 activities for each of the volunteers.  

