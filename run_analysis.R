library(dplyr)

## loading all relevant data

#names <- read.table("features.txt")
#y_train <- read.table("y_train.txt")
#y_test <- read.table("y_test.txt")
#X_test <- read.table("X_test.txt", col.names = names$V2)
#X_train <- read.table("X_train.txt", col.names = names$V2)

# merging data (binding per col/row)

test <- cbind(y_test, X_test)
train <- cbind(y_train, X_train)
full_data <- rbind(test, train)

# getting the relevant columns

my_data <- full_data[,grep("(mean)|(std)", names(full_data))]
my_data <- cbind(full_data$V1, my_data)
my_data <- rename(my_data, "Activity" = "full_data$V1")

# renaming the activities 

my_data$Activity <- factor(my_data$Activity, levels = c(1,2,3,4,5,6), labels = c("WALKING", "WALKING UPSTAIRS", 
                                                  "WALKING DOWNSTAIRS", "SITTING",
                                                  "STANDING", "LAYING"))





