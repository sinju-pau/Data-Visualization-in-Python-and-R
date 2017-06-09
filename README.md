# Predicting using Regression methods

Enterprise companies comprise a $3.4 trillion market worldwide of which an increasingly larger share is being allocated to artificial intelligence technologies.By definition, “enterprise” technology companies create tools for workplace roles and functions that a large number of businesses use. For example, Salesforce is the primary enterprise software used by sales professionals in a company.

Plenty of enterprise companies use combinations of automated data science, machine learning, and modern deep learning approaches for tasks like data preparation, predictive analytics, and process automation. Many are well-established players with deep domain expertise and product functionality. Others are hot new startups applying artificial intelligence to new problems. Read more on these at <a href="http://www.topbots.com/essential-landscape-overview-enterprise-artificial-intelligence/">ENTERPRISE A.I. COMPANIES</a>


The task here with the dataset EnterpriseAI is to predict the Total Funding as a function of other concerned variables Year funded, Twitter Followers, Employees, Location, State etc. Several regression algorithms has been used here to compare the accuracy and errors involved. The analysis is done using R as well as Python platforms.


Dataset courtesy : Aurielle Perlmann @  <a href="https://data.world/">data.world</a>


## Analysis using R

### Step :1 Install and load required libraries in R
```R
install.packages("readr")
install.packages("Amelia")
install.packages("caTools")
library(readr)
library(Amelia)
library(caTools)
```
### Step :2 Read and view the dataset
```R
EnterpriseAI <- read_csv("EnterpriseAI.csv")
View(EnterpriseAI)
str(EnterpriseAI)
```
EnterpriseAI dataset contains 132 rows and 13 columns, with the below column headings:
1.  Name
2.  Url
3.  Total Funding
4.  Funding Stage
5.  Description
6.  Year Founded
7.  Exit Status
8.  Location
9.  State
10. Employees
11. Twitter Followers
12. Linkedin Id
13. Category

The varaibles considered for anlaysis are Total Funding, Year Founded, Exit Status, Location, Employees, Twitter Followers and Category

### Step :3 Data Preprocessing

The dataset contains missing values (NA's) , unknowns and categorical data. The missing values and unknowns be replaced with appropriate values and categorical data to be encoded.
```R
#replacing blanks and 'Unknown's by NA
EnterpriseAI[EnterpriseAI == ""] <- NA
EnterpriseAI[EnterpriseAI == "Unknown"] <- NA
```
A view of data using ```   missmap() ``` shows that there are NA's in Year Founded, Twitter Followers, Employees and State.
Let us now create a new variable Years_Active, giving active number of years and replace NA's with the mean value.
```R
#Viewing NA's in the dataset
missmap(EnterpriseAI,main = "Missing values in training data")
#Creating variable Years_Active and removing NA's
CurrentYear <- rep(2017, nrow(EnterpriseAI))
EnterpriseAI$Years_Active <- (CurrentYear - EnterpriseAI$`Year Founded`)
EnterpriseAI$Years_Active <- ifelse(is.na(EnterpriseAI$Years_Active),
                             ave(EnterpriseAI$Years_Active, FUN = function(x) mean(x, na.rm = TRUE)),
                             EnterpriseAI$Years_Active)
```
Do the same with Twitter Followers variable
```R
#Removing NA's in Twitter Followers variable
EnterpriseAI$`Twitter Followers` <- ifelse(is.na(EnterpriseAI$`Twitter Followers`),
                                    ave(EnterpriseAI$`Twitter Followers`, FUN = function(x) mean(x, na.rm = TRUE)),
                                    EnterpriseAI$`Twitter Followers`)
```
Replace range values in Employees variable by averages and converting to integer
```R
#Replacing range values by averages and converting to integer
EnterpriseAI$Employees[grep('-', EnterpriseAI$Employees)] <- c(ave(1,10),ave(11,50),ave(51,200),ave(1,10),ave(51,200))
EnterpriseAI$Employees <- as.integer(EnterpriseAI$Employees)
#Removing NA's in Employees variable
EnterpriseAI$Employees <- ifelse(is.na(EnterpriseAI$Employees),
                                          ave(EnterpriseAI$Employees, FUN = function(x) mean(x, na.rm = TRUE)),
                                          EnterpriseAI$Employees)
```       
Replace NA's in State by 'U'
```R
#Removing NA's in State variable
EnterpriseAI$State[is.na(EnterpriseAI$State)] <- 'U'
```
Let us now encode the categorical variables. For Exit Status
```R
#Creating factors for Exit Status
EnterpriseAI$`Exit Status`<- factor(EnterpriseAI$`Exit Status`)
```
For the State variable, categorize them into US and Non_US. By inspecting the column,
```R
#Picking Non_US states by inspection 
y <- c("Barcelona","Berkshire","Catalunya","HaMerkaz","Ile-de-France","Ontario","Quebec") 
#Creating %in% for character matching
"%in%" <- function(x, table) match(x, table, nomatch = 0) > 0

EnterpriseAI$State <-  ifelse((EnterpriseAI$State %in% y),'Non_US','US')
EnterpriseAI$State <- factor(EnterpriseAI$State)
```






