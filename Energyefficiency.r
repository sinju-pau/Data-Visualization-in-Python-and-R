
# Load the libraries
library(readxl)
library(ggplot2)
library(caTools)
library(gridExtra)

# Read the dataset into the varaible Energyefficiency
Energyefficiency <- read_excel("ENB2012.xlsx",col_names = TRUE)

Energyefficiency
dim(Energyefficiency)

# Removing the column with NA's
Energyefficiency <- Energyefficiency[,-11]

# Removing all rows with NA's using complete.cases command
Energyefficiency <- Energyefficiency[complete.cases(Energyefficiency),]

Energyefficiency
dim(Energyefficiency)

colnames(Energyefficiency) <- c("Relative.Compactness","Surface.Area","Wall.Area","Roof.Area",
                                "Overall.Height","Orientation","Glazing.Area","Glazing.Area.Distribution",
                                "Heating.Load","Cooling.Load") 

head(Energyefficiency)

summary(Energyefficiency)

par(mfrow = c(2,4))
plot(Energyefficiency$Relative.Compactness, Energyefficiency$Heating.Load, xlab ="Relative.Compactness", ylab= "Heating.Load" , col ='blueviolet')
plot(Energyefficiency$Surface.Area, Energyefficiency$Heating.Load, xlab ="Surface.Area", ylab= " " ,col ='cyan3')
plot(Energyefficiency$Wall.Area, Energyefficiency$Heating.Load, xlab ="Wall.Area", ylab= " " ,col ='darksalmon')
plot(Energyefficiency$Roof.Area , Energyefficiency$Heating.Load, xlab ="Roof.Area", ylab= " " ,col ='indianred')
plot(Energyefficiency$Overall.Height, Energyefficiency$Heating.Load, xlab ="Overall.Height", ylab= "Heating.Load " ,col ='mediumvioletred')
plot(Energyefficiency$Orientation, Energyefficiency$Heating.Load, xlab ="Orientation", ylab= " " ,col ='royalblue')
plot(Energyefficiency$Glazing.Area, Energyefficiency$Heating.Load, xlab ="Glazing.Area ", ylab= " " ,col ='darksalmon')
plot(Energyefficiency$Glazing.Area.Distribution, Energyefficiency$Heating.Load, xlab ="Glazing.Area.Distribution", ylab= " " ,col ='cyan3')


par(mfrow = c(2,4))
plot(Energyefficiency$Relative.Compactness, Energyefficiency$Cooling.Load, xlab ="Relative.Compactness", ylab= "Cooling.Load" , col ='blueviolet')
plot(Energyefficiency$Surface.Area, Energyefficiency$Cooling.Load, xlab ="Surface.Area", ylab= " " ,col ='cyan3')
plot(Energyefficiency$Wall.Area, Energyefficiency$Cooling.Load, xlab ="Wall.Area", ylab= " " ,col ='darksalmon')
plot(Energyefficiency$Roof.Area , Energyefficiency$Cooling.Load, xlab ="Roof.Area", ylab= " " ,col ='indianred')
plot(Energyefficiency$Overall.Height, Energyefficiency$Cooling.Load, xlab ="Overall.Height", ylab= "Cooling.Load " ,col ='mediumvioletred')
plot(Energyefficiency$Orientation, Energyefficiency$Cooling.Load, xlab ="Orientation", ylab= " " ,col ='royalblue')
plot(Energyefficiency$Glazing.Area, Energyefficiency$Cooling.Load, xlab ="Glazing.Area ", ylab= " " ,col ='darksalmon')
plot(Energyefficiency$Glazing.Area.Distribution, Energyefficiency$Cooling.Load, xlab ="Glazing.Area.Distribution", ylab= " " ,col ='cyan3')

ggplot() +
  geom_point(aes(x = Energyefficiency$Heating.Load, y = Energyefficiency$Cooling.Load, color = 'cyan3'))+
  ggtitle('Heating.Load  vs Cooling.Load')+
  xlab('Heating.Load')+
  ylab('Cooling.Load')

#Removing Outliers in Heating Load
Energyefficiency <- Energyefficiency[Energyefficiency$Heating.Load >= 10,]

set.seed(123)
split <- sample.split(Energyefficiency$Heating.Load, SplitRatio = 0.8)
training_set <- subset(Energyefficiency, split == TRUE)
test_set <- subset(Energyefficiency, split == FALSE)

# Feature Scaling
training_set <- data.frame(scale(training_set))
test_set <- data.frame(scale(test_set))

# Fitting Multiple Linear Regression to the Training set
Linear_regressor1 <- lm(formula = Heating.Load ~Relative.Compactness + Surface.Area + Wall.Area +
                          Roof.Area + Overall.Height + Orientation + Glazing.Area + Glazing.Area.Distribution,
                data = training_set)

#print summary statistics
summary(Linear_regressor1)

#Removing insignificant variables
Linear_regressor1 <- lm(formula = Heating.Load ~Relative.Compactness + Surface.Area + Wall.Area 
                + Overall.Height + Glazing.Area,
                data = training_set)
summary(Linear_regressor1)

# Predicting the Test set results
y_pred <- predict(Linear_regressor1, newdata = test_set)
Linear_mse1 <- mean((test_set$Heating.Load - y_pred)^2)
Linear_mse1

ggplot() +
  geom_line(aes(x = seq(-1,3,length.out = 150), y = test_set$Heating.Load, color = 'True')) +
  geom_line(aes(x = seq(-1,3,length.out = 150), y = y_pred,color = 'Predicted'))+
  scale_color_manual(name=' ',values=c(True ='green', Predicted ='blue'))+
  ggtitle('Heating.Load - True vs Predicted') +
  xlab(' ') +
  ylab('Heating.Load')

#splitting to training and test sets
set.seed(123)
split <- sample.split(Energyefficiency$Cooling.Load, SplitRatio = 0.8)
training_set <- subset(Energyefficiency, split == TRUE)
test_set <- subset(Energyefficiency, split == FALSE)

#Feature Scaling
training_set = data.frame(scale(training_set))
test_set = data.frame(scale(test_set))

#Fitting Linear Regression to the dataset
Linear_regressor2 <- lm(formula = Cooling.Load ~Relative.Compactness + Surface.Area + Wall.Area +
                   Roof.Area + Overall.Height + Orientation + Glazing.Area + Glazing.Area.Distribution,
                 data = training_set)

summary(Linear_regressor2)

Linear_regressor2 <- lm(formula = Cooling.Load ~Relative.Compactness + Surface.Area + Wall.Area 
                  + Overall.Height + Glazing.Area,
                 data = training_set)
summary(Linear_regressor2)

# Predicting the Test set results and evaluate the Mean Squared Error
y_pred = predict(Linear_regressor2, newdata = test_set)
mse2 <- mean((test_set$Cooling.Load - y_pred)^2)
mse2

#Here we create an x sequence of the size of Heating.Load in the range of the same (-1 to 3)
ggplot() +
  geom_line(aes(x = seq(-1,3,length.out = 150), y = test_set$Cooling.Load, color = 'True')) +
  geom_line(aes(x = seq(-1,3,length.out = 150), y = y_pred,color = 'Predicted'))+
  scale_color_manual(name=' ',values=c(True ='green', Predicted ='blue'))+
  ggtitle('Cooling.Load - True vs Predicted') +
  xlab(' ') +
  ylab('Cooling.Load')

#Lets begin by importing libraries
#install.packages("FNN")
library(FNN)
library(rpart)
library(randomForest)

#Splitting to training and test sets
set.seed(123)
split <- sample.split(Energyefficiency$Heating.Load, SplitRatio = 0.8)
training_set <- subset(Energyefficiency, split == TRUE)
test_set <- subset(Energyefficiency, split == FALSE)

# Fitting Decision Tree Regression to the dataset
dec_tree_regressor = rpart(formula = Heating.Load ~Relative.Compactness + Surface.Area + Wall.Area +
                           Overall.Height + Orientation + Glazing.Area,
                  data = training_set,
                  control = rpart.control(minsplit = 1))

# Predicting with Decision Tree Regression
y_pred = predict(dec_tree_regressor, newdata = test_set)

#Evaluating MSE on test set
dec_tree_mse1 <- mean((test_set$Heating.Load - y_pred)^2)
dec_tree_mse1

# Fitting KNN Regression to the dataset
knn_regressor = knn.reg(train = training_set, test = test_set, y =training_set$Heating.Load)

# Predicting with KNN Regression
#Evaluating MSE on test set
knn_mse1 <- mean((test_set$Heating.Load - knn_regressor$pred)^2)
knn_mse1

# Fitting Random Forest Regression to the dataset
set.seed(1234)
randForest_regressor = randomForest(formula = Heating.Load ~Relative.Compactness + Surface.Area + Wall.Area +
                          Overall.Height + Glazing.Area + Glazing.Area.Distribution,
                          data = training_set,         
                          ntree = 500)

# Predicting with Random Forests Regression
y_pred = predict(randForest_regressor, newdata = test_set)

rf_mse1 <- mean((test_set$Heating.Load - y_pred)^2)
rf_mse1

Method <- c("Linear Regression", "Decision Tree Regression","KNN Regerssion", "Random Forests Regression")
MSE  <- c(Linear_mse1,dec_tree_mse1,knn_mse1,rf_mse1)
data.frame(Method,MSE)


