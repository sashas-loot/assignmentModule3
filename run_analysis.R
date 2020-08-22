library(dplyr)

fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "data.zip", method = "curl")
unzip("data.zip")

## loading all relevant data

names <- read.table("./UCI HAR Dataset/features.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = names$V2)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = names$V2)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

## renaming columns

names(subject_train)<-"subjectID"
names(subject_test)<-"subjectID"

## merging data (binding per col/row)

test <- cbind(subject_test, y_test, X_test)
train <- cbind(subject_train, y_train, X_train)
full_data <- rbind(test, train)

## getting the relevant columns

my_data <- full_data[,grep("(mean)|(std)", names(full_data))]
my_data <- cbind(full_data$subjectID, full_data$V1, my_data)
my_data <- rename(my_data, "activity" = "full_data$V1")
my_data <- rename(my_data, "subjectID" = "full_data$subjectID")

## renaming the activities 

labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
my_data$activity <- factor(my_data$activity, levels = labels$V1 , labels = labels$V2)

## renaming variables 

names(my_data)<-gsub("tBody","TimeDomainBody",names(my_data), fixed=TRUE)
names(my_data)<-gsub("tGravity","TimeDomainGravity",names(my_data), fixed=TRUE)
names(my_data)<-gsub("fBody","FrequencyDomainBody",names(my_data), fixed=TRUE)
names(my_data)<-gsub("Acc","Acceleration",names(my_data), fixed=TRUE)
names(my_data)<-gsub("Gyro", "AngularVelocity",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-XYZ","3AxialSignals",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-X","XAxis",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-Y","YAxis",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-Z","ZAxis",names(my_data), fixed=TRUE)
names(my_data)<-gsub("Mag","MagnitudeSignals",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-mean()","MeanValue",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-std()","StandardDeviation",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-mad()","MedianAbsoluteDeviation ",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-max()","LargestValueInArray",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-min()","SmallestValueInArray",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-sma()","SignalMagnitudeArea",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-energy()","EnergyMeasure",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-iqr()","InterquartileRange ",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-entropy()","SignalEntropy",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-arCoeff()","AutoRegresionCoefficientsWithBurgOrderEqualTo4",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-correlation()","CorrelationCoefficient",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-maxInds()", "IndexOfFrequencyComponentWithLargestMagnitude",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-meanFreq()","WeightedAverageOfFrequencyComponentsForMeanFrequency",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-skewness()","Skewness",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-kurtosis()","Kurtosis",names(my_data), fixed=TRUE)
names(my_data)<-gsub("-bandsEnergy()","EnergyOfFrequencyInterval.",names(my_data), fixed=TRUE)

## creating the tidy dataset 

DT <- data.frame(my_data)
tidy<- aggregate(DT[,3:81], DT[,1:2], mean)
write.table(tidy, file="TidyData.txt", row.name=FALSE, col.names=TRUE)
print ("The script 'run_analysis.R was executed successfully.  As a result, the file TidyData.txt has been saved in the working directory, in folder UCI HAR Dataset.")
rm(list=ls())






