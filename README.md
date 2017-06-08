# Predicting using Regression methods

Enterprise companies comprise a $3.4 trillion market worldwide of which an increasingly larger share is being allocated to artificial intelligence technologies.By definition, “enterprise” technology companies create tools for workplace roles and functions that a large number of businesses use. For example, Salesforce is the primary enterprise software used by sales professionals in a company.

Plenty of enterprise companies use combinations of automated data science, machine learning, and modern deep learning approaches for tasks like data preparation, predictive analytics, and process automation. Many are well-established players with deep domain expertise and product functionality. Others are hot new startups applying artificial intelligence to new problems. Read more on these at <a href="http://www.topbots.com/essential-landscape-overview-enterprise-artificial-intelligence/">ENTERPRISE A.I. COMPANIES</a>

Dataset courtesy : Aurielle Perlmann @ data.world
The task here with the dataset EnterpriseAI is to predict the Total Funding as a function of other concerned variables Year funded, Twitter Followers, Employees, Location, State etc. Several regression algorithms has been used here to compare the errors and accuracy involved. The analysis is done using R as well as Python platforms.

## Analysis using R

Step :1 Install and load required libraries in R
```R

#TO PREDICT TOTAL FUNDING AS A FUNCTON OF OTHER VARIABLES
#Install and Load required libraries
library(readr)
library(Amelia)
library(caTools)

```





