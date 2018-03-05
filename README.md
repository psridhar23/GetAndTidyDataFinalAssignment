==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'run_analysis.R': This R script analyses experimental data and summarizes and tidies up the data from the experiment described above into the features described in features_info.txt.

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

run_analysis steps:
==============

# Load training data and bind to subject and activity

# Load test data and bind to subject and activity

# Combine training and test data by doing a row bind 

# Load features and activity labels

# Apply column names from feature names + "subject" + "activity"

# Select only columns that are a mean or standard deviation or subject/activity

# Group by activity and subject

# Summarize one level to obtain means and arrange by activity

# Merge activity with activity labels

# Bring activity label columns to the front

# Apply transform function as described below on variable name to get descriptive name for columns
# and apply these names to columns

Name transformation - 
=================
Split each column name into 4 parts - domain, direction, measurement, quantity
If column name is prefixed with t, domain is Time, with f, domain is Frequency etc.
If column name has "-X" direction is set to "in X dir", has "-Y" direction is set to "in Y dir" and so on
If column name has "BodyAccJerk" measurement is set to "Linear Acceleration Jerk" and so on
If column name has "Mean" qty is set to "Mean of" and so on
At the end paste domain, direction, measurement and quantity to get the transformed descriptive variable names


License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

Paranji Sriram Sridhar
