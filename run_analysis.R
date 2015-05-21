                                      ##CourseProject
library(dplyr)
                ######Step1. Merge training and test sets to create one data set######
#Read data sets
#setwd("C:/Users/usakuravi/Github/DataCleaningProject/UCI HAR Dataset/")
training_set <- read.table("./project/train/X_train.txt")
training_labels <- read.table("./project/train/y_train.txt")
training_subjects<-read.table("./project/train/subject_train.txt")

testing_set <- read.table("./project/test/X_test.txt")
testing_labels <- read.table("./project/test/y_test.txt")
testing_subjects<-read.table("./project/test/subject_test.txt")
                        
#Merge train and test data sets
merged_set<-rbind(training_set,testing_set)
merged_labels<-rbind(training_labels,testing_labels)
merged_subjects<-rbind(training_subjects,testing_subjects)
names(merged_subjects)<-"subject"
                
           #####Step2.Extracts only measurements on mean and standard deviation######

#Read features data set
features_set <- read.table("./project/features.txt")
head(features_set)

#Identify features with "mean" or "std" in the name            
#mean_indices <- grep("mean|std", features_set[,2])               
                
#The above command chooses meanFreq() variables as well. These are different from mean(), 
#since, in the features info file, we see that mean and meanFreq are different functions.
#In order to avoid that, we execute the following command which picks variables
#with "mean()" or "std()"
reqd_indices <- grep("mean\\(\\)|std\\(\\)", features_set[, 2])                

#Extract corresponding features from the merged set using reqd_indices
merged_set<-merged_set[,reqd_indices]
reqd_features <- names(merged_set)
                
#Remove the "()" from the names
names(merged_set)<-gsub("\\(\\)", "", features_set[reqd_indices, 2]) 
                
        ######Step3. Uses descriptive activity names for activities in dataset###### 
                
#Read the activity labels file
activity_labels <- read.table("./project/activity_labels.txt")
                
#Remove "_" and convert to lower case  
activity_labels[, 2] <- tolower(gsub("_", " ", activity_labels[, 2]))
                
#Replace activity number with activity name in merged_labels
label_lookup<-activity_labels[merged_labels[,1],2]
merged_labels[,1]<-label_lookup
names(merged_labels)<-"activity"
                
        ###### Step4. Appropriately label data set with descriptive activity names######
                
#Combine the subjects, activities and measurements
combined_data<-cbind(merged_subjects,merged_labels,merged_set)                
         
        ###### Step5. Creates a second, independent tidy data set with the average of 
              #each variable for each activity and each subject######
                
#Count number of activities, subjects
activity_length <- nrow(activity_labels)
subject_length <- length(unique(merged_subjects[,1]))

#Execute the 2 for loops below to construct the tidy data set
for (i in 1:subject_length){
  for(j in 1:activity_length){
    #Subset out all measurements for each subject for each activity
    temp<-subset(combined_data, (combined_data[,1]==i)&(combined_data[,2]==activity_labels[j,2]))
    #Subset out just the measurement columns from temp with the numeric values
    temp1<-select(temp,-(subject:activity))
    #Calculate the column means - means of all measured variables
    column_means <- colMeans(temp1)
    #Transpose the means to present them in a single row instead of a single column
    column_means <- t(as.data.frame(column_means))
    #Initialize the temporary dataframe temp_df for the first time by combining 
    #the columns
    if((i==1)&(j==1))
      temp_df<-cbind(i,activity_labels[j,2],column_means)
    #After the first initialization, as i and j change, create temp_row by combining 
    #the columns and append the temp_row to the temporary dataframe temp_df
    if(!((i==1)&(j==1)))
    {
      temp_row<-cbind(i,activity_labels[j,2],column_means)
      temp_df<-rbind(temp_df,temp_row)
    }
  }
}                
final_tidydata<-as.data.frame(temp_df)                
names(final_tidydata)<- names(combined_data)          
write.table(combined_data, "Combined Data", row.names=F)                    
write.table(final_tidydata, "Tidy Data", row.names=F)
