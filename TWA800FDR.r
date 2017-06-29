
#Import the libraries
library(ggplot2)
library(caTools)

#Import the dataset
twa800fdr <- read.csv("twa800fdr.csv")
dim(twa800fdr)
head(twa800fdr)

#checking for NA"s
sum(is.na(twa800fdr))

#treating last row data at 753 seconds equal to the one at 752, some abnormality related to the crash 
twa800fdr[753,c(2:17)] <- twa800fdr[752,c(2:17)]
sum(is.na(twa800fdr))

#Visualization
par(mfrow = c(3,5))
for(i in (2:16)){
    plot(x = twa800fdr[,i], y = twa800fdr[,17], xlab = colnames(twa800fdr)[i], ylab = "Pressure on Aircraft",col ='cyan3')
}

ggplot() +
  geom_point(aes(x = twa800fdr[,1], y = twa800fdr[,17], color = 'darksalmon'))+
  ggtitle('Pressure vs Seconds')+
  xlab(colnames(twa800fdr)[1])+
  ylab("Pressure at altitude")

set.seed(123)
split <- sample.split(twa800fdr[,17], SplitRatio = 0.75)
training_set <- subset(twa800fdr, split == TRUE)
test_set <- subset(twa800fdr, split == FALSE)

# Fitting Multiple Linear Regression to the Training set
Linear_regressor <- lm(formula = PressureAlt ~.-Second,
                data = training_set)

#print summary statistics
summary(Linear_regressor)

#Removing insignificant variables
Linear_regressor <- lm(formula = PressureAlt ~.-Second-RudderPos-AngleAttack-LongAccel,
                data = training_set)

#print summary statistics
summary(Linear_regressor)

# Predicting the Test set results
y_pred <- predict(Linear_regressor, newdata = test_set)
Linear_mse <- mean((test_set$PressureAlt - y_pred)^2)
Linear_mse
dim(test_set)

ggplot() +
  geom_line(aes(x = seq(8,15,length.out = 189), y = test_set$PressureAlt, color = 'True')) +
  geom_line(aes(x = seq(8,15,length.out = 189), y = y_pred, color = 'Predicted'))+
  scale_color_manual(name=' ',values=c(True ='green', Predicted ='blue'))+
  ggtitle('Pressure - True vs Predicted') +
  xlab(' ') +
  ylab('Pressure')


