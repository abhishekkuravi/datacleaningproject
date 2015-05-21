This codebook provides a reference to the transformations made in the code to obtain the final tidy data, as well as to understand the feature names.

1. Read the data sets - training and test. Do this for the data, labels and subject data sets.

2. Combine the train and test data sets together.merged_set represents join of the training and test data sets. merged_labels represents joins of the labels. merged_subject represents join of the subjects.

3. Read the features of the data set for which values have been measured. It should have 561 variables of measure.

4. Look for features with mean() or std() at the end of the name. Neglect features with meanFreq() at the end of the name,
since meanFreq() and mean() are defined as separate functions in features-info text file. You should have 66 features.

5. Identify key indices using mean_indices.

6. Remove the () at the end of each variable name. 

7. 66 Means and Standard Deviations of variables are now filtered in the data set. Example: Mean of Body Acceleration Magnitude is given by tBodyAccMagmean

8. Read the activity labels file and call it activity_labels.

9. Convert the activity names to lowercase and remove _ between words.

10. Replace activity number with the activity name in the merged data set

11. Concatenate the subjects, activities and measurements to one single file called "combined_data"

12. From this file, we need to obtain the tidy data which has means of all observations for each subject and activity

13. Call this tidy data "final_tidydata"

14. Write this file to a txt file called "Tidy Data"