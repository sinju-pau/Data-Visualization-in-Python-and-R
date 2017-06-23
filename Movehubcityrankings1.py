
# # PREDICTING MOVEHUB RATING FOR CITIES#
# To predict Movehub ratings for cities with the given input features, to find out which features could be relevant predictors, and to find the prediction errors. More at : http://www.movehub.com/city-rankings. 
# 
# Data courtesy : https://www.kaggle.com/blitzr/movehub-city-rankings
# 
# This project analysis is done in Python 3.6
# 

# Lets begin by importing libraries necessary for this project

# In[1]:

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


# Loading the dataset

# In[2]:

cities = pd.read_csv('cities.csv') 
movehubqualityoflife = pd.read_csv('movehubqualityoflife.csv')
movehubcostofliving = pd.read_csv('movehubcostofliving.csv')


# There are some missing information. Lets move to data preprocessing.

# ## Data Preprocessing

# In[3]:

#Check for NAN's
cities.info()


# There are three NAN's. Now insert missing countries,

# In[4]:

#Insertion of missing countries
cities.iloc[654,1]='Ukraine'
cities.iloc[724,1]='Russia'
cities.iloc[1529,1]='Kosovo'


# In[5]:

#To make sure there isn't any more NAN:
cities.info()


# Do same with movehubqualityoflife and movehubcostofliving

# In[6]:

movehubqualityoflife.info()
movehubcostofliving.info()


# Perfect ! Lets now merge the datasets and modify indices

# In[7]:

#Merge Datasets
movehubcity = pd.merge(movehubqualityoflife, movehubcostofliving, how ='outer')
#Sort Dataset by 'City'
movehubcity = movehubcity.sort_values(by='City')
#Modification of the values of the index
movehubcity.reset_index(drop = True)


# Now insert column country to data and create the final dataset

# In[8]:

#Insert column country to dataset and create data.
data= pd.merge(movehubcity, cities, how = 'left',on='City')
#Checking for NAN's again after merge
data.info()
data[data['Country'].isnull()]


# There are NAN's in Country names, needs to be corrected only for completeness.

# In[9]:

#Update missing Country names
data.iloc[10,13]='United States' 
data.iloc[51,13]='Philippines'
data.iloc[61,13]='Argentina'
data.iloc[66,13]='Philippines' 
data.iloc[74,13]='Germany'
data.iloc[79,13]='Germany'
data.iloc[81,13]='Ireland'
data.iloc[100,13]='Turkey'
data.iloc[101,13]='Turkey'
data.iloc[122,13]='Poland'
data.iloc[129,13]='Spain'
data.iloc[130,13]='Scania'
data.iloc[134,13]='Spain'
data.iloc[136,13]='Colombia'
data.iloc[139,13]='United States'
data.iloc[141,13]='United States'
data.iloc[164,13]='Thailand'
data.iloc[166,13]='United States'
data.iloc[167,13]='United States'
data.iloc[168,13]='United States'
data.iloc[176,13]='Brazil'
data.iloc[178,13]='United States'
data.iloc[183,13]='United States'
data.iloc[184,13]='United States'
data.iloc[185,13]='United States'
data.iloc[188,13]='Brazil'
data.iloc[193,13]='Malta'
data.iloc[201,13]='United States'
data.iloc[224,13]='United states'
data.iloc[227,13]='Switzerland'
#Update wrong names of some of the cities
data.iloc[224,0]='Washington D.C'
data.iloc[66,0]='Davao City'

#Checking again for NAN's
data.info()


# In[10]:

#Replace '' in column names by '_' and view the final dataset
data.columns = data.columns.str.replace(' ','_')


# The dataset is now ready ! Let's visualize to find some interesting patterns if any,

# ## Data Visualization

# In[11]:

# visualize the relationship between the features and the response using scatterplots

fig, axs = plt.subplots(1, 10, sharey=True)
data.plot(kind='scatter', x='Purchase_Power', y='Movehub_Rating', ax=axs[0], figsize=(16, 8))
data.plot(kind='scatter', x='Health_Care', y='Movehub_Rating', ax=axs[1])
data.plot(kind='scatter', x='Pollution', y='Movehub_Rating', ax=axs[2])
data.plot(kind='scatter', x='Quality_of_Life', y='Movehub_Rating', ax=axs[3])
data.plot(kind='scatter', x='Crime_Rating', y='Movehub_Rating', ax=axs[4])
data.plot(kind='scatter', x='Cappuccino', y='Movehub_Rating', ax=axs[5])
data.plot(kind='scatter', x='Cinema', y='Movehub_Rating', ax=axs[6])
data.plot(kind='scatter', x='Wine', y='Movehub_Rating', ax=axs[7])
data.plot(kind='scatter', x='Avg_Rent', y='Movehub_Rating', ax=axs[8])
data.plot(kind='scatter', x='Avg_Disposable_Income', y='Movehub_Rating', ax=axs[9])
plt.show()


# The scatter plots indicate that more or less linear variation can be assumed between variables.
# 
# Also we notice some outliers where the value of Movehub_Rating < 65.00.
# 
# Lets drop them from the dataset and visualize again.

# In[12]:

data = data.loc[(data['Movehub_Rating'] >= 65)]
fig, axs = plt.subplots(1, 10, sharey=True)
data.plot(kind='scatter', x='Purchase_Power', y='Movehub_Rating', ax=axs[0], figsize=(16, 8))
data.plot(kind='scatter', x='Health_Care', y='Movehub_Rating', ax=axs[1])
data.plot(kind='scatter', x='Pollution', y='Movehub_Rating', ax=axs[2])
data.plot(kind='scatter', x='Quality_of_Life', y='Movehub_Rating', ax=axs[3])
data.plot(kind='scatter', x='Crime_Rating', y='Movehub_Rating', ax=axs[4])
data.plot(kind='scatter', x='Cappuccino', y='Movehub_Rating', ax=axs[5],figsize=(16, 8))
data.plot(kind='scatter', x='Cinema', y='Movehub_Rating', ax=axs[6])
data.plot(kind='scatter', x='Wine', y='Movehub_Rating', ax=axs[7])
data.plot(kind='scatter', x='Avg_Rent', y='Movehub_Rating', ax=axs[8])
data.plot(kind='scatter', x='Avg_Disposable_Income', y='Movehub_Rating', ax=axs[9])
plt.show()


# Looks fine !. Nowthat the outliers are removed, lets split the dataset.

# ## Splitting data into training and test sets

# In[13]:

#Import 'train_test_split'
from sklearn.model_selection import train_test_split
X = data.drop(['Movehub_Rating','Country','City'], axis = 1) 
y = data['Movehub_Rating']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)


# Feature scaling is not required because the library takes care of it. Let us now create a Linear Regression Model for the dataset

# ## Build a Linear Regression model

# In[15]:

from sklearn import linear_model
linear_reg = linear_model.LinearRegression()
linear_reg.fit(X_train,y_train)


# Lets now make predictions on the test set using the model built

# In[16]:

#Making Predictions
y_pred_linear_reg = linear_reg.predict(X_test)


# Now evaluate the error parameters and summary statistics

# In[17]:

from sklearn.metrics import mean_squared_error
mean_squared_error=mean_squared_error(y_test, y_pred_linear_reg)

#to print summary statistics
import statsmodels.formula.api as sm
#Adding intercept trems to X_train
X_train_mod = np.append(arr = np.ones((X_train.shape[0],1)).astype(int),values = X_train,axis = 1)
regressor_OLS = sm.OLS(endog=y_train, exog=X_train_mod).fit()
regressor_OLS.summary()


# In[19]:

print("Mean Squared Error(MSE) of the test set: {:.3f} ".format(mean_squared_error))


# Assuming the level of significance parameter for regression to be alpha = 0.05, some features may be insignificant, specifically x2, x3 followed by x4, x5, x7 and x8. Let us now remove these variables and rebuild the model.

# In[20]:

#Drop variables and do'train_test_split'
X = data.drop(['Movehub_Rating','Country','City','Health_Care','Pollution','Quality_of_Life','Crime_Rating','Cinema','Wine'], axis = 1) 
y = data['Movehub_Rating']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)


# In[21]:

linear_reg = linear_model.LinearRegression()
linear_reg.fit(X_train,y_train)


# In[22]:

#Making Predictions
y_pred_linear_reg = linear_reg.predict(X_test)


# In[23]:

from sklearn.metrics import mean_squared_error
mean_squared_error = mean_squared_error(y_test, y_pred_linear_reg)

#to print summary statistics
import statsmodels.formula.api as sm
#Adding intercept trems to X_train
X_train_mod = np.append(arr = np.ones((X_train.shape[0],1)).astype(int),values = X_train,axis = 1)
regressor_OLS = sm.OLS(endog=y_train, exog=X_train_mod).fit()
regressor_OLS.summary()


# In[24]:

print("Mean Squared Error(MSE) of the test set: {:.3f} ".format(mean_squared_error))


# The MSE for test set now shows a slight decrease of 3.518. 
# 
# Let us now employ another algorithm i.e Support Vector Regression. Since the data is linear in nature, we will use a Linear kernel.

# ## Build a Support Vector Regression model and make predictions

# In[25]:

X = data.drop(['Movehub_Rating','Country','City'], axis = 1) 
y = data['Movehub_Rating']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)


# In[26]:

from sklearn.svm import SVR
regressor = SVR(kernel ='linear')
regressor.fit(X_train, y_train)


# In[27]:

y_pred_SVR = regressor.predict(X_test)


# In[28]:

from sklearn.metrics import mean_squared_error
mean_squared_error = mean_squared_error(y_test, y_pred_SVR)


# In[29]:

print("Mean Squared Error(MSE) of the test set: {:.3f} ".format(mean_squared_error))


# ## Concluding Remarks

# 1. The test MSE for the Linear Regression model shows a rate of 22.923, upon including all input features. Eliminating insignificant features could reduce the test MSE of the same only to 19.350.
# 2. An equivalent linear model but with Support Vectors showed a test MSE of 21.480, in a comparable range with Linear Regression.
# 3. Cross-validation techniques can be applied to further optimize the hyperparameters of the model.
