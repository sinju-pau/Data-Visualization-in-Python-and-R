
#TO PREDICT TOTAL FUNDING AS A FUNCTON OF OTHER VARIABLES
#Installing and Loading appropriate libraries
library(readr)
library(Amelia)
library(caTools)
library(boot)

#Reading the Dataset and viewing
EnterpriseAI <- read_csv("~/Documents/R/EnterpriseAI.csv")
View(EnterpriseAI)
str(EnterpriseAI)
dim(EnterpriseAI)

#DATA PREPROCESSING STAGE
#replacing blanks and 'Unknown's by NA
EnterpriseAI[EnterpriseAI == ""] <- NA
EnterpriseAI[EnterpriseAI == "Unknown"] <- NA
#Viewing NA's in the dataset
missmap(EnterpriseAI,main = "Missing values in training data")

#Creating variable Years_Active and removing NA's
CurrentYear <- rep(2017, nrow(EnterpriseAI))
EnterpriseAI$Years_Active = (CurrentYear - EnterpriseAI$`Year Founded`)
EnterpriseAI$Years_Active = ifelse(is.na(EnterpriseAI$Years_Active),
                     ave(EnterpriseAI$Years_Active, FUN = function(x) mean(x, na.rm = TRUE)),
                     EnterpriseAI$Years_Active)

#Removing NA's in Twitter Followers variable
EnterpriseAI$`Twitter Followers` = ifelse(is.na(EnterpriseAI$`Twitter Followers`),
                                   ave(EnterpriseAI$`Twitter Followers`, FUN = function(x) mean(x, na.rm = TRUE)),
                                   EnterpriseAI$`Twitter Followers`)

#Removing NA's in Employees variable
#Replacing range values by averages and converting to integer
EnterpriseAI$Employees[grep('-', EnterpriseAI$Employees)] = c(ave(1,10),ave(11,50),ave(51,200),ave(1,10),ave(51,200))
EnterpriseAI$Employees = as.integer(EnterpriseAI$Employees)
#Removing NA's in Employees variable
EnterpriseAI$Employees = ifelse(is.na(EnterpriseAI$Employees),
                                          ave(EnterpriseAI$Employees, FUN = function(x) mean(x, na.rm = TRUE)),
                                          EnterpriseAI$Employees)
#Removing NA's in State variable
EnterpriseAI$State[is.na(EnterpriseAI$State)] <- 'U'


#Encoding categorical data
#Creating factors for Exit Status
EnterpriseAI$`Exit Status`=factor(EnterpriseAI$`Exit Status`)
#Creating factors for State
EnterpriseAI$State[is.na(EnterpriseAI$State)] <- 'U'
#Picking Non_US states by inspection 
y <- c("Barcelona","Berkshire","Catalunya","HaMerkaz","Ile-de-France","Ontario","Quebec") 
#creating %in% for character matching
"%in%" <- function(x, table) match(x, table, nomatch = 0) > 0
EnterpriseAI$State =  ifelse((EnterpriseAI$State %in% y),'Non_US','US')

EnterpriseAI$State=factor(EnterpriseAI$State)
EnterpriseAI$`Exit Status`=factor(EnterpriseAI$`Exit Status`)
EnterpriseAI$Category=factor(EnterpriseAI$Category)
#Viewing NA's in dataset final
missmap(EnterpriseAI,main = "Missing values in training data")

#relevant features chosen by elimination
EnterpriseAI = EnterpriseAI[,c(3,9,10,11,14)] #relevant features chosen by elimination

#Scaling variables in dataset
EnterpriseAI$`Total Funding` = scale(EnterpriseAI$`Total Funding`)
EnterpriseAI$Years_Active = scale(EnterpriseAIt$Years_Active)
EnterpriseAI$`Twitter Followers` = scale(EnterpriseAI$`Twitter Followers`)
EnterpriseAI$Employees = scale(EnterpriseAI$Employees)

#splitting to training and test sets
set.seed(99)
split=sample.split(EnterpriseAI$`Total Funding`, SplitRatio= 0.8)
training_set=subset(EnterpriseAI,split==TRUE)
test_set=subset(EnterpriseAI,split==FALSE)

#MACHINE LEARNING STAGE
# Fitting Multiple Linear Regression to the Training set
regressor = glm(formula = `Total Funding` ~ Years_Active + `Twitter Followers` + Employees + State ,
               data = training_set)
# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)
summary(regressor)  

#Rebuilding model avoiding State variable
regressor = glm(formula = `Total Funding` ~ Years_Active + `Twitter Followers` + Employees ,
                data = training_set)
# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)
summary(regressor)  

#TESTING STAGE
#To check for accuracy of predictions made
#To determine the parameter test set MSE(Mean Squared Error) for the final model
testMSE = mean((test_set$`Total Funding` - y_pred)^2)
#To test the accuracy of the final model using k-fold Cross-Validation
cv_Error = cv.glm(training_set, regressor, K=10)$delta[1]











         
