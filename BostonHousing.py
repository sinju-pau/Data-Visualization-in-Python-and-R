
# coding: utf-8

# # PREDICTING HOUSING PRICES FOR BOSTON CITIES DATA
# 
# The dataset contains information collected by the U.S Census Service concerning housing in the area of Boston Mass. It was obtained from the StatLib archive (http://lib.stat.cmu.edu/datasets/boston), and has been used extensively throughout the literature to benchmark algorithms. 
# 
# There are 14 attributes in each case of the dataset:
# 1. CRIM - per capita crime rate by town
# 2. ZN - proportion of residential land zoned for lots over 25,000 sq.ft.
# 3. INDUS - proportion of non-retail business acres per town.
# 4. CHAS - Charles River dummy variable (1 if tract bounds river; 0 otherwise)
# 5. NOX - nitric oxides concentration (parts per 10 million)
# 6. RM - average number of rooms per dwelling
# 7. AGE - proportion of owner-occupied units built prior to 1940
# 8. DIS - weighted distances to five Boston employment centres
# 9. RAD - index of accessibility to radial highways
# 10. TAX - full-value property-tax rate per 10,000 dollars
# 11. PTRATIO - pupil-teacher ratio by town
# 12. B - 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
# 13. LSTAT - % lower status of the population
# 14. MEDV - Median value of owner-occupied homes in $1000's
# 
# The task here is to predict the housing prices variable, MEDV, making use of other variables as input features and to find out which of the features could be relevant predictors.
# 
# This project analysis is done in Python 3.6
# 

# Import necessary libraries for the analysis

# In[1]:

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
plt.style.use('ggplot')
get_ipython().magic('matplotlib inline')
import statsmodels.api as sm


# Read the dataset into the variable, boston

# In[2]:

boston = pd.read_csv("boston.csv")
print(boston.head())


# Print the size and check for NaN's

# In[3]:

print(boston.shape)
boston.info()


# The dataset seems to be void of NaN's. Lets now try to visualize medv, the output variable agianst other variables.

# ## Data Visualization

# In[4]:

# visualize the relationship between the features and the response using scatterplots
fig, axs = plt.subplots(1, 6, sharey = True)
boston.plot(kind='scatter', x = 'crim', y='medv', ax=axs[0], figsize = (16,8))
boston.plot(kind='scatter', x = 'zn', y='medv', ax=axs[1])
boston.plot(kind='scatter', x = 'indus', y='medv', ax=axs[2])
boston.plot(kind='scatter', x = 'chas', y='medv', ax=axs[3])
boston.plot(kind='scatter', x = 'nox', y='medv', ax=axs[4])
boston.plot(kind='scatter', x = 'rm', y='medv', ax=axs[5])
plt.show()


# In[5]:

fig, axs = plt.subplots(1, 7, sharey = True)
boston.plot(kind='scatter', x = 'age', y='medv', ax=axs[0], figsize = (16,8))
boston.plot(kind='scatter', x = 'dis', y='medv', ax=axs[1])
boston.plot(kind='scatter', x = 'rad', y='medv', ax=axs[2])
boston.plot(kind='scatter', x = 'tax', y='medv', ax=axs[3])
boston.plot(kind='scatter', x = 'ptratio', y='medv', ax=axs[4])
boston.plot(kind='scatter', x = 'black', y='medv', ax=axs[5])
boston.plot(kind='scatter', x = 'lstat', y='medv', ax=axs[6])
plt.show()


# From these plots we can observe some underlying nonlinearities in the data. Lets now split the dataset into training and test sets.

# ## Splitting data into training and test sets

# In[6]:

#Import 'train_test_split'
from sklearn.model_selection import train_test_split
X = boston.iloc[:,0:13].values 
y = boston.iloc[:,13].values
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=0)


# Lets move on to building some regession models to make predictions.

# ## Build Regression models

# In[23]:

from sklearn import linear_model
linear_reg = linear_model.LinearRegression()
linear_reg.fit(X_train,y_train)


# Lets now make predictions on the test set using the model built

# In[8]:

#Making Predictions
y_pred_linear_reg = linear_reg.predict(X_test)


# Now evaluate the error parameters and print the  summary statistics for the regression model

# In[9]:

from sklearn.metrics import mean_squared_error
mean_squared_error=mean_squared_error(y_test, y_pred_linear_reg)

#Adding intercept trems to X_train
X_train_mod = np.append(arr = np.ones((X_train.shape[0],1)).astype(int),values = X_train,axis = 1)
regressor_OLS = sm.OLS(endog=y_train, exog=X_train_mod).fit()
regressor_OLS.summary()


# In[10]:

print("Mean Squared Error(MSE) of the test set: {:.3f} ".format(mean_squared_error))


# Observe that two variables have higher p-values, so lets rebilud the model eliminating them.

# In[11]:

#Import 'train_test_split'
from sklearn.model_selection import train_test_split
X = boston.iloc[:,(0,1,3,4,5,7,8,9,10,11,12)].values 
y = boston.iloc[:,13].values
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=0)
linear_reg = linear_model.LinearRegression()
linear_reg.fit(X_train,y_train)
#Making Predictions
y_pred_linear_reg = linear_reg.predict(X_test)


# In[12]:

from sklearn.metrics import mean_squared_error
mse1 = mean_squared_error(y_test, y_pred_linear_reg)

#to print summary statistics
import statsmodels.formula.api as sm
#Adding intercept trems to X_train
X_train_mod = np.append(arr = np.ones((X_train.shape[0],1)).astype(int),values = X_train,axis = 1)
regressor_OLS = sm.OLS(endog=y_train, exog=X_train_mod).fit()
regressor_OLS.summary()


# In[13]:

print("Mean Squared Error(MSE) of the test set: {:.3f} ".format(mse1))


# We observe that the error values are not too small with the Linear Regression model. Lets see if other regression models can make some improvments over it.

# In[14]:

#Fitting Support Vector Regression (Linear Kernel) to the data
from sklearn.svm import SVR
regressor = SVR(kernel ='linear')
regressor.fit(X_train, y_train)


# In[15]:

# Predicting results
y_pred_svr = regressor.predict(X_test)
from sklearn.metrics import mean_squared_error
mse2 = mean_squared_error(y_test, y_pred_svr)
print("Mean Squared Error(MSE) of the test set: {:.3f} ".format(mse2))


# In[16]:

#Fitting Support Vector Regression (Radial Kernel) to the data
from sklearn.svm import SVR
regressor = SVR(kernel ='rbf')
regressor.fit(X_train, y_train)
# Predicting results
y_pred_svr = regressor.predict(X_test)
from sklearn.metrics import mean_squared_error
mse3 = mean_squared_error(y_test, y_pred_svr)
print("Mean Squared Error(MSE) of the test set: {:.3f} ".format(mse3))


# Evidently, Support Vector Regression caanot capture the features of the model well.
# This is probably something to do with the scaling of the parameter values.
# Lets move on.

# In[17]:

#Fitting Decision Tree Regression 
from sklearn.tree import DecisionTreeRegressor
regressor = DecisionTreeRegressor(random_state = 0)
regressor.fit(X_train, y_train)


# In[18]:

# Predicting results
y_pred_dt = regressor.predict(X_test)
from sklearn.metrics import mean_squared_error
mse4 = mean_squared_error(y_test, y_pred_dt)
print("Mean Squared Error(MSE) of the test set: {:.3f} ".format(mse4))


# In[19]:

# Fitting Random Forest Regression to the dataset
from sklearn.ensemble import RandomForestRegressor
regressor = RandomForestRegressor(n_estimators = 10, random_state = 0)
regressor.fit(X_train, y_train)


# In[20]:

# Predicting a new result
y_pred_rf = regressor.predict(X_test)
from sklearn.metrics import mean_squared_error
mse5= mean_squared_error(y_test, y_pred_rf)
print("Mean Squared Error(MSE) of the test set: {:.3f} ".format(mse5))


# Lets now summarize the error values

# In[21]:

Algorithm =['Linear Regression','Linear SVM','Kernel SVM','Decision Tree', 'Random Forests']
mse =[mse1,mse2,mse3,mse4,mse5]


# In[22]:

df = pd.DataFrame.from_items([('Algorithm',Algorithm),('Mean Squared Error(MSE)', mse)])
df


# ## Concluding Remarks

# 1. For the bston dataset, the Linear Regression is not capable of making good predictions , so does the SVM's
# 2. The Decision Tree and Random Forests are performing well, for the fact that the features of the dataset are not linearly separable. These algorithms are independent of the shape of the variables.
# 3. Cross-validation can be performed to optimize the parameters.

# In[ ]:



