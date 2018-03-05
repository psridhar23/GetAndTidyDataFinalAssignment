# Function to transform variable name to descriptive name
namexform <- function(x) {
  tp <- ""
  dir <- ""
  f <- ""
  qty <- ""
  if (grepl("^f",x)) {
    tp <- "Freq domain"
  } else if (grepl("^t",x)) {
    tp <- "Time domain"
  } else if (grepl("^angle",x)) {
    tp <- "Signal Window Averaged"
  } 
  if (grepl("BodyGyroJerk",x)&&grepl("gravity",x)) {
    f <- "Angle between Angular Velocity Jerk and Gravity"    
  } else if (grepl("BodyGyro",x)&&grepl("gravity",x)) {
    f <- "Angle between Angular Velocity and Gravity"    
  } else if (grepl("BodyAccMean",x)&&grepl("gravity",x)) {
    f <- "Angle between Mean Linear Acceleration and Gravity"    
  } else if (grepl("BodyAccJerkMean",x)&&grepl("gravity",x)) {
    f <- "Angle between Mean Linear Acceleration Jerk and Gravity"    
  } else if (grepl("BodyGyroMean",x)&&grepl("gravity",x)) {
    f <- "Angle between Mean Angular Velocity and Gravity"    
  } else if (grepl("X",x)&&grepl("gravity",x)) {
    f <- "Angle between X and Gravity"    
  } else if (grepl("Y",x)&&grepl("gravity",x)) {
    f <- "Angle between Y and Gravity"    
  } else if (grepl("Z",x)&&grepl("gravity",x)) {
    f <- "Angle between Z and Gravity"    
  } else if (grepl("BodyAccJerk",x)) {
    f <- "Linear Acceleration Jerk"
  } else if (grepl("BodyGyroJerk",x)) {
    f <- "Angular Velocity Jerk"
  } else if (grepl("Gravity|gravity",x)) {
    f <- "Acc. due to Gravity"
  } else if (grepl("BodyAcc",x)&&!grepl("Jerk",x)) {
    f <- "Linear Acceleration"
  } else if (grepl("BodyGyro",x)&&!grepl("Jerk",x)) {
    f <- "Angular Velocity"
  } else if (grepl("Acc",x)&&!grepl("Jerk",x)&&!grepl("Body",x)) {
    f <- "Raw Accelerometer"
  } else if (grepl("Gyro",x)&&!grepl("Jerk",x)&&!grepl("Body",x)) {
    f <- "Raw Gyroscope"
  }
  if (grepl("-X",x)) {
    dir <- "in X dir"
  } else if(grepl("-Y",x)) {
    dir <- "in Y dir"
  } else if(grepl("-Z",x)) {
    dir <- "in Z dir"
  } else if(grepl("Mag",x)) {
    dir <- "magnitude"
  }
  if (grepl("meanFreq()",x)) {
    qty <- "Wghtd avg of"
  } else if (grepl("std()",x)) {
    qty <- "Std deviation of"
  } else if (grepl("mad()",x)) {
    qty <- "Median abs deviation of"
  } else if (grepl("mean()",x)) {
    qty <- "Mean of"
  } else if (grepl("energy()",x)) {
    qty <- "Energy Measure"
  }
  if (x=="subject"||x=="activity") {
    x
  } else if (x=="V2") {
    "Activity Name"
  }  else {
    paste(qty,tp,f,dir)
  }
}


# Load training data and bind to subject and activity
setwd("~/CourseraAssignments/GettingCleaningData/UCI HAR Dataset/train")
subject_train <- read.table("subject_train.txt")
X_train <- read.table("X_train.txt")
train <- cbind(X_train,subject_train)
y_train <- read.table("y_train.txt")
train <- cbind(train,y_train)


# Load test data and bind to subject and activity
setwd("~/CourseraAssignments/GettingCleaningData/UCI HAR Dataset/test")
subject_test <- read.table("subject_test.txt")
X_test <- read.table("X_test.txt")
test <- cbind(X_test,subject_test)
y_test <- read.table("y_test.txt")
test <- cbind(test,y_test)
X_merged <- rbind(train,test)

# Load features and activity labels
setwd("~/CourseraAssignments/GettingCleaningData/UCI HAR Dataset")
features <- read.table("features.txt")
act_labs <- read.table("activity_labels.txt")
featNames <- as.vector(features[,2])
featNames <- append(featNames,"subject")
featNames <- append(featNames,"activity")

# Apply column names from feature names + "subject" + "activity"
colnames(X_merged) <- featNames

# Select only columns that are a mean or standard deviation or subject/activity
X_mean_std <- X_merged[,grep(pattern="mean|std|subject|activity",colnames(X_merged),ignore.case=TRUE,value=TRUE)]

# Group by activity and subject
X_avg <- group_by(X_mean_std,activity,subject)

# Summarize one level to obtain means and arrange by activity
X_avg_subject <- X_avg %>% summarize_all(mean) %>% arrange(activity)

# Merge activity with activity labels
X_avg_subject <- merge(X_avg_subject,act_labs,by.x="activity",by.y="V1")

# Bring activity label columns to the front
cnames <- colnames(X_avg_subject)
meanfeatsorig <- cnames[1]
meanfeatsorig <- append(meanfeatsorig,cnames[length(cnames)])
meanfeatsorig <- append(meanfeatsorig,cnames[3:length(cnames)-1])
X_avg_subject <- X_avg_subject[,meanfeatsorig]

# Apply transform function on variable name to get descriptive name for columns
# and apply these names to columns
meanfeats <- sapply(meanfeatsorig,namexform)
colnames(X_avg_subject) <- meanfeats