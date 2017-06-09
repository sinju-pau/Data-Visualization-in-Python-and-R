# Predicting using Regression methods

Enterprise companies comprise a $3.4 trillion market worldwide of which an increasingly larger share is being allocated to artificial intelligence technologies.By definition, “enterprise” technology companies create tools for workplace roles and functions that a large number of businesses use. For example, Salesforce is the primary enterprise software used by sales professionals in a company.

Plenty of enterprise companies use combinations of automated data science, machine learning, and modern deep learning approaches for tasks like data preparation, predictive analytics, and process automation. Many are well-established players with deep domain expertise and product functionality. Others are hot new startups applying artificial intelligence to new problems. Read more on these at <a href="http://www.topbots.com/essential-landscape-overview-enterprise-artificial-intelligence/">ENTERPRISE A.I. COMPANIES</a>


The task here with the dataset EnterpriseAI is to predict the Total Funding as a function of other concerned variables Year funded, Twitter Followers, Employees, Location, State etc. Several regression algorithms has been used here to compare the accuracy and errors involved. The analysis is done using R as well as Python platforms.


Dataset courtesy : Aurielle Perlmann @  <a href="https://data.world/">data.world</a>


## Analysis using R

Step :1 Install and load required libraries in R
```R
install.packages("readr")
install.packages("Amelia")
install.packages("caTools")
library(readr)
library(Amelia)
library(caTools)
```
Step :2 Read and view the dataset
```R
Step :2 Read and view the dataset
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











