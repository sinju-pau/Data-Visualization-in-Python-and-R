
# Energy Efficiency Analysis using Regression methods

The goal of this project is to assessing the heating load and cooling load requirements of buildings (that is, energy efficiency) as a function of building parameters. The dataset and associated information is obtained from the below link :

https://archive.ics.uci.edu/ml/datasets/Energy+efficiency#

The data is obtained by performing energy analysis using 12 different building shapes simulated in Ecotect.The buildings differ with respect to the glazing area, the glazing area distribution, and the orientation, amongst other parameters. Various settings were simulated as functions of the afore-mentioned characteristics to obtain 768 building shapes. The dataset comprises 768 samples and 8 features, aiming to predict two real valued responses i.e Heating Load and Cooling Load. 

This project analysis is done in R. Various regression methods are used and compared against their error metrics.The analysis involves the following :
    1. Data Visualization and Preprocessing
    2. Model building & Fitting Regression method to Data (Machine Learning stage)
    3. Model Evaluation (Making Predictions)

Lets first try to fit a Linear Regression to the data. Begin by loading libraries for this project


```R
# Load the libraries
library(readxl)
library(ggplot2)
library(caTools)
library(gridExtra)
```


```R
# Read the dataset into the varaible Energyefficiency
Energyefficiency <- read_excel("ENB2012.xlsx",col_names = TRUE)
```


```R
Energyefficiency
dim(Energyefficiency)
```


<table>
<thead><tr><th scope=col>X1</th><th scope=col>X2</th><th scope=col>X3</th><th scope=col>X4</th><th scope=col>X5</th><th scope=col>X6</th><th scope=col>X7</th><th scope=col>X8</th><th scope=col>Y1</th><th scope=col>Y2</th><th scope=col></th></tr></thead>
<tbody>
	<tr><td>0.98  </td><td>514.5 </td><td>294.0 </td><td>110.25</td><td>7.0   </td><td>2     </td><td>0     </td><td>0     </td><td>15.55 </td><td>21.33 </td><td>NA    </td></tr>
	<tr><td>0.98  </td><td>514.5 </td><td>294.0 </td><td>110.25</td><td>7.0   </td><td>3     </td><td>0     </td><td>0     </td><td>15.55 </td><td>21.33 </td><td>NA    </td></tr>
	<tr><td>0.98  </td><td>514.5 </td><td>294.0 </td><td>110.25</td><td>7.0   </td><td>4     </td><td>0     </td><td>0     </td><td>15.55 </td><td>21.33 </td><td>NA    </td></tr>
	<tr><td>0.98  </td><td>514.5 </td><td>294.0 </td><td>110.25</td><td>7.0   </td><td>5     </td><td>0     </td><td>0     </td><td>15.55 </td><td>21.33 </td><td>NA    </td></tr>
	<tr><td>0.90  </td><td>563.5 </td><td>318.5 </td><td>122.50</td><td>7.0   </td><td>2     </td><td>0     </td><td>0     </td><td>20.84 </td><td>28.28 </td><td>NA    </td></tr>
	<tr><td>0.90  </td><td>563.5 </td><td>318.5 </td><td>122.50</td><td>7.0   </td><td>3     </td><td>0     </td><td>0     </td><td>21.46 </td><td>25.38 </td><td>NA    </td></tr>
	<tr><td>0.90  </td><td>563.5 </td><td>318.5 </td><td>122.50</td><td>7.0   </td><td>4     </td><td>0     </td><td>0     </td><td>20.71 </td><td>25.16 </td><td>NA    </td></tr>
	<tr><td>0.90  </td><td>563.5 </td><td>318.5 </td><td>122.50</td><td>7.0   </td><td>5     </td><td>0     </td><td>0     </td><td>19.68 </td><td>29.60 </td><td>NA    </td></tr>
	<tr><td>0.86  </td><td>588.0 </td><td>294.0 </td><td>147.00</td><td>7.0   </td><td>2     </td><td>0     </td><td>0     </td><td>19.50 </td><td>27.30 </td><td>NA    </td></tr>
	<tr><td>0.86  </td><td>588.0 </td><td>294.0 </td><td>147.00</td><td>7.0   </td><td>3     </td><td>0     </td><td>0     </td><td>19.95 </td><td>21.97 </td><td>NA    </td></tr>
	<tr><td>0.86  </td><td>588.0 </td><td>294.0 </td><td>147.00</td><td>7.0   </td><td>4     </td><td>0     </td><td>0     </td><td>19.34 </td><td>23.49 </td><td>NA    </td></tr>
	<tr><td>0.86  </td><td>588.0 </td><td>294.0 </td><td>147.00</td><td>7.0   </td><td>5     </td><td>0     </td><td>0     </td><td>18.31 </td><td>27.87 </td><td>NA    </td></tr>
	<tr><td>0.82  </td><td>612.5 </td><td>318.5 </td><td>147.00</td><td>7.0   </td><td>2     </td><td>0     </td><td>0     </td><td>17.05 </td><td>23.77 </td><td>NA    </td></tr>
	<tr><td>0.82  </td><td>612.5 </td><td>318.5 </td><td>147.00</td><td>7.0   </td><td>3     </td><td>0     </td><td>0     </td><td>17.41 </td><td>21.46 </td><td>NA    </td></tr>
	<tr><td>0.82  </td><td>612.5 </td><td>318.5 </td><td>147.00</td><td>7.0   </td><td>4     </td><td>0     </td><td>0     </td><td>16.95 </td><td>21.16 </td><td>NA    </td></tr>
	<tr><td>0.82  </td><td>612.5 </td><td>318.5 </td><td>147.00</td><td>7.0   </td><td>5     </td><td>0     </td><td>0     </td><td>15.98 </td><td>24.93 </td><td>NA    </td></tr>
	<tr><td>0.79  </td><td>637.0 </td><td>343.0 </td><td>147.00</td><td>7.0   </td><td>2     </td><td>0     </td><td>0     </td><td>28.52 </td><td>37.73 </td><td>NA    </td></tr>
	<tr><td>0.79  </td><td>637.0 </td><td>343.0 </td><td>147.00</td><td>7.0   </td><td>3     </td><td>0     </td><td>0     </td><td>29.90 </td><td>31.27 </td><td>NA    </td></tr>
	<tr><td>0.79  </td><td>637.0 </td><td>343.0 </td><td>147.00</td><td>7.0   </td><td>4     </td><td>0     </td><td>0     </td><td>29.63 </td><td>30.93 </td><td>NA    </td></tr>
	<tr><td>0.79  </td><td>637.0 </td><td>343.0 </td><td>147.00</td><td>7.0   </td><td>5     </td><td>0     </td><td>0     </td><td>28.75 </td><td>39.44 </td><td>NA    </td></tr>
	<tr><td>0.76  </td><td>661.5 </td><td>416.5 </td><td>122.50</td><td>7.0   </td><td>2     </td><td>0     </td><td>0     </td><td>24.77 </td><td>29.79 </td><td>NA    </td></tr>
	<tr><td>0.76  </td><td>661.5 </td><td>416.5 </td><td>122.50</td><td>7.0   </td><td>3     </td><td>0     </td><td>0     </td><td>23.93 </td><td>29.68 </td><td>NA    </td></tr>
	<tr><td>0.76  </td><td>661.5 </td><td>416.5 </td><td>122.50</td><td>7.0   </td><td>4     </td><td>0     </td><td>0     </td><td>24.77 </td><td>29.79 </td><td>NA    </td></tr>
	<tr><td>0.76  </td><td>661.5 </td><td>416.5 </td><td>122.50</td><td>7.0   </td><td>5     </td><td>0     </td><td>0     </td><td>23.93 </td><td>29.40 </td><td>NA    </td></tr>
	<tr><td>0.74  </td><td>686.0 </td><td>245.0 </td><td>220.50</td><td>3.5   </td><td>2     </td><td>0     </td><td>0     </td><td> 6.07 </td><td>10.90 </td><td>NA    </td></tr>
	<tr><td>0.74  </td><td>686.0 </td><td>245.0 </td><td>220.50</td><td>3.5   </td><td>3     </td><td>0     </td><td>0     </td><td> 6.05 </td><td>11.19 </td><td>NA    </td></tr>
	<tr><td>0.74  </td><td>686.0 </td><td>245.0 </td><td>220.50</td><td>3.5   </td><td>4     </td><td>0     </td><td>0     </td><td> 6.01 </td><td>10.94 </td><td>NA    </td></tr>
	<tr><td>0.74  </td><td>686.0 </td><td>245.0 </td><td>220.50</td><td>3.5   </td><td>5     </td><td>0     </td><td>0     </td><td> 6.04 </td><td>11.17 </td><td>NA    </td></tr>
	<tr><td>0.71  </td><td>710.5 </td><td>269.5 </td><td>220.50</td><td>3.5   </td><td>2     </td><td>0     </td><td>0     </td><td> 6.37 </td><td>11.27 </td><td>NA    </td></tr>
	<tr><td>0.71  </td><td>710.5 </td><td>269.5 </td><td>220.50</td><td>3.5   </td><td>3     </td><td>0     </td><td>0     </td><td> 6.40 </td><td>11.72 </td><td>NA    </td></tr>
	<tr><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td><td>NA</td></tr>
</tbody>
</table>




<ol class=list-inline>
	<li>1296</li>
	<li>11</li>
</ol>



## Data Preprocessing
The dataset has 1296 observations as rows and 11 columns. Observe that the last column and a few last rows contain all NA's. Lets remove them.



```R
# Removing the column with NA's
Energyefficiency <- Energyefficiency[,-11]
```


```R
# Removing all rows with NA's using complete.cases command
Energyefficiency <- Energyefficiency[complete.cases(Energyefficiency),]
```


```R
Energyefficiency
dim(Energyefficiency)
```


<table>
<thead><tr><th scope=col>X1</th><th scope=col>X2</th><th scope=col>X3</th><th scope=col>X4</th><th scope=col>X5</th><th scope=col>X6</th><th scope=col>X7</th><th scope=col>X8</th><th scope=col>Y1</th><th scope=col>Y2</th></tr></thead>
<tbody>
	<tr><td>0.98  </td><td>514.5 </td><td>294.0 </td><td>110.25</td><td>7.0   </td><td>2     </td><td>0     </td><td>0     </td><td>15.55 </td><td>21.33 </td></tr>
	<tr><td>0.98  </td><td>514.5 </td><td>294.0 </td><td>110.25</td><td>7.0   </td><td>3     </td><td>0     </td><td>0     </td><td>15.55 </td><td>21.33 </td></tr>
	<tr><td>0.98  </td><td>514.5 </td><td>294.0 </td><td>110.25</td><td>7.0   </td><td>4     </td><td>0     </td><td>0     </td><td>15.55 </td><td>21.33 </td></tr>
	<tr><td>0.98  </td><td>514.5 </td><td>294.0 </td><td>110.25</td><td>7.0   </td><td>5     </td><td>0     </td><td>0     </td><td>15.55 </td><td>21.33 </td></tr>
	<tr><td>0.90  </td><td>563.5 </td><td>318.5 </td><td>122.50</td><td>7.0   </td><td>2     </td><td>0     </td><td>0     </td><td>20.84 </td><td>28.28 </td></tr>
	<tr><td>0.90  </td><td>563.5 </td><td>318.5 </td><td>122.50</td><td>7.0   </td><td>3     </td><td>0     </td><td>0     </td><td>21.46 </td><td>25.38 </td></tr>
	<tr><td>0.90  </td><td>563.5 </td><td>318.5 </td><td>122.50</td><td>7.0   </td><td>4     </td><td>0     </td><td>0     </td><td>20.71 </td><td>25.16 </td></tr>
	<tr><td>0.90  </td><td>563.5 </td><td>318.5 </td><td>122.50</td><td>7.0   </td><td>5     </td><td>0     </td><td>0     </td><td>19.68 </td><td>29.60 </td></tr>
	<tr><td>0.86  </td><td>588.0 </td><td>294.0 </td><td>147.00</td><td>7.0   </td><td>2     </td><td>0     </td><td>0     </td><td>19.50 </td><td>27.30 </td></tr>
	<tr><td>0.86  </td><td>588.0 </td><td>294.0 </td><td>147.00</td><td>7.0   </td><td>3     </td><td>0     </td><td>0     </td><td>19.95 </td><td>21.97 </td></tr>
	<tr><td>0.86  </td><td>588.0 </td><td>294.0 </td><td>147.00</td><td>7.0   </td><td>4     </td><td>0     </td><td>0     </td><td>19.34 </td><td>23.49 </td></tr>
	<tr><td>0.86  </td><td>588.0 </td><td>294.0 </td><td>147.00</td><td>7.0   </td><td>5     </td><td>0     </td><td>0     </td><td>18.31 </td><td>27.87 </td></tr>
	<tr><td>0.82  </td><td>612.5 </td><td>318.5 </td><td>147.00</td><td>7.0   </td><td>2     </td><td>0     </td><td>0     </td><td>17.05 </td><td>23.77 </td></tr>
	<tr><td>0.82  </td><td>612.5 </td><td>318.5 </td><td>147.00</td><td>7.0   </td><td>3     </td><td>0     </td><td>0     </td><td>17.41 </td><td>21.46 </td></tr>
	<tr><td>0.82  </td><td>612.5 </td><td>318.5 </td><td>147.00</td><td>7.0   </td><td>4     </td><td>0     </td><td>0     </td><td>16.95 </td><td>21.16 </td></tr>
	<tr><td>0.82  </td><td>612.5 </td><td>318.5 </td><td>147.00</td><td>7.0   </td><td>5     </td><td>0     </td><td>0     </td><td>15.98 </td><td>24.93 </td></tr>
	<tr><td>0.79  </td><td>637.0 </td><td>343.0 </td><td>147.00</td><td>7.0   </td><td>2     </td><td>0     </td><td>0     </td><td>28.52 </td><td>37.73 </td></tr>
	<tr><td>0.79  </td><td>637.0 </td><td>343.0 </td><td>147.00</td><td>7.0   </td><td>3     </td><td>0     </td><td>0     </td><td>29.90 </td><td>31.27 </td></tr>
	<tr><td>0.79  </td><td>637.0 </td><td>343.0 </td><td>147.00</td><td>7.0   </td><td>4     </td><td>0     </td><td>0     </td><td>29.63 </td><td>30.93 </td></tr>
	<tr><td>0.79  </td><td>637.0 </td><td>343.0 </td><td>147.00</td><td>7.0   </td><td>5     </td><td>0     </td><td>0     </td><td>28.75 </td><td>39.44 </td></tr>
	<tr><td>0.76  </td><td>661.5 </td><td>416.5 </td><td>122.50</td><td>7.0   </td><td>2     </td><td>0     </td><td>0     </td><td>24.77 </td><td>29.79 </td></tr>
	<tr><td>0.76  </td><td>661.5 </td><td>416.5 </td><td>122.50</td><td>7.0   </td><td>3     </td><td>0     </td><td>0     </td><td>23.93 </td><td>29.68 </td></tr>
	<tr><td>0.76  </td><td>661.5 </td><td>416.5 </td><td>122.50</td><td>7.0   </td><td>4     </td><td>0     </td><td>0     </td><td>24.77 </td><td>29.79 </td></tr>
	<tr><td>0.76  </td><td>661.5 </td><td>416.5 </td><td>122.50</td><td>7.0   </td><td>5     </td><td>0     </td><td>0     </td><td>23.93 </td><td>29.40 </td></tr>
	<tr><td>0.74  </td><td>686.0 </td><td>245.0 </td><td>220.50</td><td>3.5   </td><td>2     </td><td>0     </td><td>0     </td><td> 6.07 </td><td>10.90 </td></tr>
	<tr><td>0.74  </td><td>686.0 </td><td>245.0 </td><td>220.50</td><td>3.5   </td><td>3     </td><td>0     </td><td>0     </td><td> 6.05 </td><td>11.19 </td></tr>
	<tr><td>0.74  </td><td>686.0 </td><td>245.0 </td><td>220.50</td><td>3.5   </td><td>4     </td><td>0     </td><td>0     </td><td> 6.01 </td><td>10.94 </td></tr>
	<tr><td>0.74  </td><td>686.0 </td><td>245.0 </td><td>220.50</td><td>3.5   </td><td>5     </td><td>0     </td><td>0     </td><td> 6.04 </td><td>11.17 </td></tr>
	<tr><td>0.71  </td><td>710.5 </td><td>269.5 </td><td>220.50</td><td>3.5   </td><td>2     </td><td>0     </td><td>0     </td><td> 6.37 </td><td>11.27 </td></tr>
	<tr><td>0.71  </td><td>710.5 </td><td>269.5 </td><td>220.50</td><td>3.5   </td><td>3     </td><td>0     </td><td>0     </td><td> 6.40 </td><td>11.72 </td></tr>
	<tr><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td></tr>
	<tr><td>0.79 </td><td>637.0</td><td>343.0</td><td>147.0</td><td>7.0  </td><td>4    </td><td>0.4  </td><td>5    </td><td>41.09</td><td>47.01</td></tr>
	<tr><td>0.79 </td><td>637.0</td><td>343.0</td><td>147.0</td><td>7.0  </td><td>5    </td><td>0.4  </td><td>5    </td><td>40.79</td><td>44.87</td></tr>
	<tr><td>0.76 </td><td>661.5</td><td>416.5</td><td>122.5</td><td>7.0  </td><td>2    </td><td>0.4  </td><td>5    </td><td>38.82</td><td>39.37</td></tr>
	<tr><td>0.76 </td><td>661.5</td><td>416.5</td><td>122.5</td><td>7.0  </td><td>3    </td><td>0.4  </td><td>5    </td><td>39.72</td><td>39.80</td></tr>
	<tr><td>0.76 </td><td>661.5</td><td>416.5</td><td>122.5</td><td>7.0  </td><td>4    </td><td>0.4  </td><td>5    </td><td>39.31</td><td>37.79</td></tr>
	<tr><td>0.76 </td><td>661.5</td><td>416.5</td><td>122.5</td><td>7.0  </td><td>5    </td><td>0.4  </td><td>5    </td><td>39.86</td><td>38.18</td></tr>
	<tr><td>0.74 </td><td>686.0</td><td>245.0</td><td>220.5</td><td>3.5  </td><td>2    </td><td>0.4  </td><td>5    </td><td>14.41</td><td>16.69</td></tr>
	<tr><td>0.74 </td><td>686.0</td><td>245.0</td><td>220.5</td><td>3.5  </td><td>3    </td><td>0.4  </td><td>5    </td><td>14.19</td><td>16.62</td></tr>
	<tr><td>0.74 </td><td>686.0</td><td>245.0</td><td>220.5</td><td>3.5  </td><td>4    </td><td>0.4  </td><td>5    </td><td>14.17</td><td>16.94</td></tr>
	<tr><td>0.74 </td><td>686.0</td><td>245.0</td><td>220.5</td><td>3.5  </td><td>5    </td><td>0.4  </td><td>5    </td><td>14.39</td><td>16.70</td></tr>
	<tr><td>0.71 </td><td>710.5</td><td>269.5</td><td>220.5</td><td>3.5  </td><td>2    </td><td>0.4  </td><td>5    </td><td>12.43</td><td>15.59</td></tr>
	<tr><td>0.71 </td><td>710.5</td><td>269.5</td><td>220.5</td><td>3.5  </td><td>3    </td><td>0.4  </td><td>5    </td><td>12.63</td><td>14.58</td></tr>
	<tr><td>0.71 </td><td>710.5</td><td>269.5</td><td>220.5</td><td>3.5  </td><td>4    </td><td>0.4  </td><td>5    </td><td>12.76</td><td>15.33</td></tr>
	<tr><td>0.71 </td><td>710.5</td><td>269.5</td><td>220.5</td><td>3.5  </td><td>5    </td><td>0.4  </td><td>5    </td><td>12.42</td><td>15.31</td></tr>
	<tr><td>0.69 </td><td>735.0</td><td>294.0</td><td>220.5</td><td>3.5  </td><td>2    </td><td>0.4  </td><td>5    </td><td>14.12</td><td>16.63</td></tr>
	<tr><td>0.69 </td><td>735.0</td><td>294.0</td><td>220.5</td><td>3.5  </td><td>3    </td><td>0.4  </td><td>5    </td><td>14.28</td><td>15.87</td></tr>
	<tr><td>0.69 </td><td>735.0</td><td>294.0</td><td>220.5</td><td>3.5  </td><td>4    </td><td>0.4  </td><td>5    </td><td>14.37</td><td>16.54</td></tr>
	<tr><td>0.69 </td><td>735.0</td><td>294.0</td><td>220.5</td><td>3.5  </td><td>5    </td><td>0.4  </td><td>5    </td><td>14.21</td><td>16.74</td></tr>
	<tr><td>0.66 </td><td>759.5</td><td>318.5</td><td>220.5</td><td>3.5  </td><td>2    </td><td>0.4  </td><td>5    </td><td>14.96</td><td>17.64</td></tr>
	<tr><td>0.66 </td><td>759.5</td><td>318.5</td><td>220.5</td><td>3.5  </td><td>3    </td><td>0.4  </td><td>5    </td><td>14.92</td><td>17.79</td></tr>
	<tr><td>0.66 </td><td>759.5</td><td>318.5</td><td>220.5</td><td>3.5  </td><td>4    </td><td>0.4  </td><td>5    </td><td>14.92</td><td>17.55</td></tr>
	<tr><td>0.66 </td><td>759.5</td><td>318.5</td><td>220.5</td><td>3.5  </td><td>5    </td><td>0.4  </td><td>5    </td><td>15.16</td><td>18.06</td></tr>
	<tr><td>0.64 </td><td>784.0</td><td>343.0</td><td>220.5</td><td>3.5  </td><td>2    </td><td>0.4  </td><td>5    </td><td>17.69</td><td>20.82</td></tr>
	<tr><td>0.64 </td><td>784.0</td><td>343.0</td><td>220.5</td><td>3.5  </td><td>3    </td><td>0.4  </td><td>5    </td><td>18.19</td><td>20.21</td></tr>
	<tr><td>0.64 </td><td>784.0</td><td>343.0</td><td>220.5</td><td>3.5  </td><td>4    </td><td>0.4  </td><td>5    </td><td>18.16</td><td>20.71</td></tr>
	<tr><td>0.64 </td><td>784.0</td><td>343.0</td><td>220.5</td><td>3.5  </td><td>5    </td><td>0.4  </td><td>5    </td><td>17.88</td><td>21.40</td></tr>
	<tr><td>0.62 </td><td>808.5</td><td>367.5</td><td>220.5</td><td>3.5  </td><td>2    </td><td>0.4  </td><td>5    </td><td>16.54</td><td>16.88</td></tr>
	<tr><td>0.62 </td><td>808.5</td><td>367.5</td><td>220.5</td><td>3.5  </td><td>3    </td><td>0.4  </td><td>5    </td><td>16.44</td><td>17.11</td></tr>
	<tr><td>0.62 </td><td>808.5</td><td>367.5</td><td>220.5</td><td>3.5  </td><td>4    </td><td>0.4  </td><td>5    </td><td>16.48</td><td>16.61</td></tr>
	<tr><td>0.62 </td><td>808.5</td><td>367.5</td><td>220.5</td><td>3.5  </td><td>5    </td><td>0.4  </td><td>5    </td><td>16.64</td><td>16.03</td></tr>
</tbody>
</table>




<ol class=list-inline>
	<li>768</li>
	<li>10</li>
</ol>



All NA's are now removed. Lets now update the column names,


```R
colnames(Energyefficiency) <- c("Relative.Compactness","Surface.Area","Wall.Area","Roof.Area",
                                "Overall.Height","Orientation","Glazing.Area","Glazing.Area.Distribution",
                                "Heating.Load","Cooling.Load") 
```


```R
head(Energyefficiency)
```


<table>
<thead><tr><th scope=col>Relative.Compactness</th><th scope=col>Surface.Area</th><th scope=col>Wall.Area</th><th scope=col>Roof.Area</th><th scope=col>Overall.Height</th><th scope=col>Orientation</th><th scope=col>Glazing.Area</th><th scope=col>Glazing.Area.Distribution</th><th scope=col>Heating.Load</th><th scope=col>Cooling.Load</th></tr></thead>
<tbody>
	<tr><td>0.98  </td><td>514.5 </td><td>294.0 </td><td>110.25</td><td>7     </td><td>2     </td><td>0     </td><td>0     </td><td>15.55 </td><td>21.33 </td></tr>
	<tr><td>0.98  </td><td>514.5 </td><td>294.0 </td><td>110.25</td><td>7     </td><td>3     </td><td>0     </td><td>0     </td><td>15.55 </td><td>21.33 </td></tr>
	<tr><td>0.98  </td><td>514.5 </td><td>294.0 </td><td>110.25</td><td>7     </td><td>4     </td><td>0     </td><td>0     </td><td>15.55 </td><td>21.33 </td></tr>
	<tr><td>0.98  </td><td>514.5 </td><td>294.0 </td><td>110.25</td><td>7     </td><td>5     </td><td>0     </td><td>0     </td><td>15.55 </td><td>21.33 </td></tr>
	<tr><td>0.90  </td><td>563.5 </td><td>318.5 </td><td>122.50</td><td>7     </td><td>2     </td><td>0     </td><td>0     </td><td>20.84 </td><td>28.28 </td></tr>
	<tr><td>0.90  </td><td>563.5 </td><td>318.5 </td><td>122.50</td><td>7     </td><td>3     </td><td>0     </td><td>0     </td><td>21.46 </td><td>25.38 </td></tr>
</tbody>
</table>



Lets now print the summary statistics


```R
summary(Energyefficiency)
```


     Relative.Compactness  Surface.Area     Wall.Area       Roof.Area    
     Min.   :0.6200       Min.   :514.5   Min.   :245.0   Min.   :110.2  
     1st Qu.:0.6825       1st Qu.:606.4   1st Qu.:294.0   1st Qu.:140.9  
     Median :0.7500       Median :673.8   Median :318.5   Median :183.8  
     Mean   :0.7642       Mean   :671.7   Mean   :318.5   Mean   :176.6  
     3rd Qu.:0.8300       3rd Qu.:741.1   3rd Qu.:343.0   3rd Qu.:220.5  
     Max.   :0.9800       Max.   :808.5   Max.   :416.5   Max.   :220.5  
     Overall.Height  Orientation    Glazing.Area    Glazing.Area.Distribution
     Min.   :3.50   Min.   :2.00   Min.   :0.0000   Min.   :0.000            
     1st Qu.:3.50   1st Qu.:2.75   1st Qu.:0.1000   1st Qu.:1.750            
     Median :5.25   Median :3.50   Median :0.2500   Median :3.000            
     Mean   :5.25   Mean   :3.50   Mean   :0.2344   Mean   :2.812            
     3rd Qu.:7.00   3rd Qu.:4.25   3rd Qu.:0.4000   3rd Qu.:4.000            
     Max.   :7.00   Max.   :5.00   Max.   :0.4000   Max.   :5.000            
      Heating.Load    Cooling.Load  
     Min.   : 6.01   Min.   :10.90  
     1st Qu.:12.99   1st Qu.:15.62  
     Median :18.95   Median :22.08  
     Mean   :22.31   Mean   :24.59  
     3rd Qu.:31.67   3rd Qu.:33.13  
     Max.   :43.10   Max.   :48.03  


Lets now eyeball scatterplots of Heating Load and Cooling Load as functions of ther features.


```R
par(mfrow = c(2,4))
plot(Energyefficiency$Relative.Compactness, Energyefficiency$Heating.Load, xlab ="Relative.Compactness", ylab= "Heating.Load" , col ='blueviolet')
plot(Energyefficiency$Surface.Area, Energyefficiency$Heating.Load, xlab ="Surface.Area", ylab= " " ,col ='cyan3')
plot(Energyefficiency$Wall.Area, Energyefficiency$Heating.Load, xlab ="Wall.Area", ylab= " " ,col ='darksalmon')
plot(Energyefficiency$Roof.Area , Energyefficiency$Heating.Load, xlab ="Roof.Area", ylab= " " ,col ='indianred')
plot(Energyefficiency$Overall.Height, Energyefficiency$Heating.Load, xlab ="Overall.Height", ylab= "Heating.Load " ,col ='mediumvioletred')
plot(Energyefficiency$Orientation, Energyefficiency$Heating.Load, xlab ="Orientation", ylab= " " ,col ='royalblue')
plot(Energyefficiency$Glazing.Area, Energyefficiency$Heating.Load, xlab ="Glazing.Area ", ylab= " " ,col ='darksalmon')
plot(Energyefficiency$Glazing.Area.Distribution, Energyefficiency$Heating.Load, xlab ="Glazing.Area.Distribution", ylab= " " ,col ='cyan3')

```


![png](output_15_0.png)



```R
par(mfrow = c(2,4))
plot(Energyefficiency$Relative.Compactness, Energyefficiency$Cooling.Load, xlab ="Relative.Compactness", ylab= "Cooling.Load" , col ='blueviolet')
plot(Energyefficiency$Surface.Area, Energyefficiency$Cooling.Load, xlab ="Surface.Area", ylab= " " ,col ='cyan3')
plot(Energyefficiency$Wall.Area, Energyefficiency$Cooling.Load, xlab ="Wall.Area", ylab= " " ,col ='darksalmon')
plot(Energyefficiency$Roof.Area , Energyefficiency$Cooling.Load, xlab ="Roof.Area", ylab= " " ,col ='indianred')
plot(Energyefficiency$Overall.Height, Energyefficiency$Cooling.Load, xlab ="Overall.Height", ylab= "Cooling.Load " ,col ='mediumvioletred')
plot(Energyefficiency$Orientation, Energyefficiency$Cooling.Load, xlab ="Orientation", ylab= " " ,col ='royalblue')
plot(Energyefficiency$Glazing.Area, Energyefficiency$Cooling.Load, xlab ="Glazing.Area ", ylab= " " ,col ='darksalmon')
plot(Energyefficiency$Glazing.Area.Distribution, Energyefficiency$Cooling.Load, xlab ="Glazing.Area.Distribution", ylab= " " ,col ='cyan3')
```


![png](output_16_0.png)



```R
ggplot() +
  geom_point(aes(x = Energyefficiency$Heating.Load, y = Energyefficiency$Cooling.Load, color = 'cyan3'))+
  ggtitle('Heating.Load  vs Cooling.Load')+
  xlab('Heating.Load')+
  ylab('Cooling.Load')
```




![png](output_17_1.png)


From the plots, we infer the following:
1. Heating.Load and Cooling.Load do have some correlations, as is evident from their linear variation w.r.t each other
2. Most of the variables are discrete in nature, except Heating.Load and Cooling.Load.
3. No underlying patterns like nonlinearity is observed.

There are some outliers in the Heating.Load column for values less than 10. Lets remove them


```R
#Removing Outliers in Heating Load
Energyefficiency <- Energyefficiency[Energyefficiency$Heating.Load >= 10,]
```


The dataset is now ready for analysis. Lets now split the dataset into training and test set

## Splitting to training and test sets


```R
set.seed(123)
split <- sample.split(Energyefficiency$Heating.Load, SplitRatio = 0.8)
training_set <- subset(Energyefficiency, split == TRUE)
test_set <- subset(Energyefficiency, split == FALSE)
```

Lets do some feature scaling for ensuring uniformity,


```R
# Feature Scaling
training_set <- data.frame(scale(training_set))
test_set <- data.frame(scale(test_set))
```

## Fitting a Linear Regression - Linear_regressor1

Lets now fit a Linear Regression to predict the output Heating.Load as a function of other features.


```R
# Fitting Multiple Linear Regression to the Training set
Linear_regressor1 <- lm(formula = Heating.Load ~Relative.Compactness + Surface.Area + Wall.Area +
                          Roof.Area + Overall.Height + Orientation + Glazing.Area + Glazing.Area.Distribution,
                data = training_set)
```


```R
#print summary statistics
summary(Linear_regressor1)
```


    
    Call:
    lm(formula = Heating.Load ~ Relative.Compactness + Surface.Area + 
        Wall.Area + Roof.Area + Overall.Height + Orientation + Glazing.Area + 
        Glazing.Area.Distribution, data = training_set)
    
    Residuals:
        Min      1Q  Median      3Q     Max 
    -0.9590 -0.1355 -0.0034  0.1325  0.7501 
    
    Coefficients: (1 not defined because of singularities)
                                Estimate Std. Error t value Pr(>|t|)    
    (Intercept)               -3.390e-16  1.216e-02   0.000    1.000    
    Relative.Compactness      -7.191e-01  1.263e-01  -5.693 1.97e-08 ***
    Surface.Area              -8.201e-01  1.751e-01  -4.685 3.48e-06 ***
    Wall.Area                  2.738e-01  3.300e-02   8.296 7.34e-16 ***
    Roof.Area                         NA         NA      NA       NA    
    Overall.Height             7.195e-01  6.829e-02  10.537  < 2e-16 ***
    Orientation                2.752e-03  1.218e-02   0.226    0.821    
    Glazing.Area               2.497e-01  1.231e-02  20.281  < 2e-16 ***
    Glazing.Area.Distribution  1.190e-02  1.232e-02   0.966    0.335    
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    
    Residual standard error: 0.2973 on 590 degrees of freedom
    Multiple R-squared:  0.9126,	Adjusted R-squared:  0.9116 
    F-statistic: 880.3 on 7 and 590 DF,  p-value: < 2.2e-16



From these statistics, it is observed that Roof.Area creates singularities and Orientation and Glazing.area.Distribution may not be good predictors of the dependent variable, Heating.Load just because of their elevated p-values.  Lets now rebuild removing these predictors.


```R
#Removing insignificant variables
Linear_regressor1 <- lm(formula = Heating.Load ~Relative.Compactness + Surface.Area + Wall.Area 
                + Overall.Height + Glazing.Area,
                data = training_set)
summary(Linear_regressor1)
```


    
    Call:
    lm(formula = Heating.Load ~ Relative.Compactness + Surface.Area + 
        Wall.Area + Overall.Height + Glazing.Area, data = training_set)
    
    Residuals:
         Min       1Q   Median       3Q      Max 
    -0.97687 -0.13657 -0.00395  0.13346  0.74196 
    
    Coefficients:
                           Estimate Std. Error t value Pr(>|t|)    
    (Intercept)          -3.357e-16  1.215e-02   0.000        1    
    Relative.Compactness -7.223e-01  1.262e-01  -5.725 1.65e-08 ***
    Surface.Area         -8.250e-01  1.748e-01  -4.719 2.96e-06 ***
    Wall.Area             2.744e-01  3.297e-02   8.324 5.89e-16 ***
    Overall.Height        7.173e-01  6.819e-02  10.519  < 2e-16 ***
    Glazing.Area          2.514e-01  1.217e-02  20.664  < 2e-16 ***
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    
    Residual standard error: 0.2971 on 592 degrees of freedom
    Multiple R-squared:  0.9125,	Adjusted R-squared:  0.9117 
    F-statistic:  1234 on 5 and 592 DF,  p-value: < 2.2e-16



This looks fine, with the R-squared and Adjusted R-squared having values (0.9125 & 0.9117) pretty much close to 1. Lets now proceed further to make predictions,

## Making Predictions


```R
# Predicting the Test set results
y_pred <- predict(Linear_regressor1, newdata = test_set)
Linear_mse1 <- mean((test_set$Heating.Load - y_pred)^2)
Linear_mse1
```


0.0984099195855078


## Visualization

Heating.Load being a continuous variable, lets now plot the true vs predictced values.


```R
ggplot() +
  geom_line(aes(x = seq(-1,3,length.out = 150), y = test_set$Heating.Load, color = 'True')) +
  geom_line(aes(x = seq(-1,3,length.out = 150), y = y_pred,color = 'Predicted'))+
  scale_color_manual(name=' ',values=c(True ='green', Predicted ='blue'))+
  ggtitle('Heating.Load - True vs Predicted') +
  xlab(' ') +
  ylab('Heating.Load')
```




![png](output_36_1.png)


The predictions seem to be closely following the true values. Lets now proceed to predicting the Cooling.Load as functions of other variables. We just need to repeat the above steps for regressor2.

## Fitting a Linear Regression - regressor2


```R
#splitting to training and test sets
set.seed(123)
split <- sample.split(Energyefficiency$Cooling.Load, SplitRatio = 0.8)
training_set <- subset(Energyefficiency, split == TRUE)
test_set <- subset(Energyefficiency, split == FALSE)
```


```R
#Feature Scaling
training_set = data.frame(scale(training_set))
test_set = data.frame(scale(test_set))
```


```R
#Fitting Linear Regression to the dataset
Linear_regressor2 <- lm(formula = Cooling.Load ~Relative.Compactness + Surface.Area + Wall.Area +
                   Roof.Area + Overall.Height + Orientation + Glazing.Area + Glazing.Area.Distribution,
                 data = training_set)
```


```R
summary(Linear_regressor2)
```


    
    Call:
    lm(formula = Cooling.Load ~ Relative.Compactness + Surface.Area + 
        Wall.Area + Roof.Area + Overall.Height + Orientation + Glazing.Area + 
        Glazing.Area.Distribution, data = training_set)
    
    Residuals:
        Min      1Q  Median      3Q     Max 
    -0.9515 -0.1844 -0.0267  0.1636  1.1883 
    
    Coefficients: (1 not defined because of singularities)
                                Estimate Std. Error t value Pr(>|t|)    
    (Intercept)               -3.277e-16  1.411e-02   0.000    1.000    
    Relative.Compactness      -8.185e-01  1.466e-01  -5.583 3.61e-08 ***
    Surface.Area              -8.893e-01  2.031e-01  -4.378 1.42e-05 ***
    Wall.Area                  2.272e-01  3.830e-02   5.931 5.12e-09 ***
    Roof.Area                         NA         NA      NA       NA    
    Overall.Height             7.544e-01  7.925e-02   9.520  < 2e-16 ***
    Orientation                1.775e-02  1.414e-02   1.256    0.210    
    Glazing.Area               1.966e-01  1.429e-02  13.759  < 2e-16 ***
    Glazing.Area.Distribution -9.103e-03  1.430e-02  -0.636    0.525    
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    
    Residual standard error: 0.3451 on 590 degrees of freedom
    Multiple R-squared:  0.8823,	Adjusted R-squared:  0.8809 
    F-statistic:   632 on 7 and 590 DF,  p-value: < 2.2e-16



From the abve statistics, we remove insignificant variables Roof.Area, Orientation and Glazing.Area.Distribution and rebuild the model


```R
Linear_regressor2 <- lm(formula = Cooling.Load ~Relative.Compactness + Surface.Area + Wall.Area 
                  + Overall.Height + Glazing.Area,
                 data = training_set)
summary(Linear_regressor2)
```


    
    Call:
    lm(formula = Cooling.Load ~ Relative.Compactness + Surface.Area + 
        Wall.Area + Overall.Height + Glazing.Area, data = training_set)
    
    Residuals:
         Min       1Q   Median       3Q      Max 
    -0.92836 -0.17823 -0.03176  0.15877  1.21718 
    
    Coefficients:
                           Estimate Std. Error t value Pr(>|t|)    
    (Intercept)          -3.209e-16  1.411e-02   0.000        1    
    Relative.Compactness -8.198e-01  1.465e-01  -5.595 3.38e-08 ***
    Surface.Area         -8.907e-01  2.030e-01  -4.387 1.36e-05 ***
    Wall.Area             2.272e-01  3.829e-02   5.934 5.04e-09 ***
    Overall.Height        7.550e-01  7.920e-02   9.534  < 2e-16 ***
    Glazing.Area          1.956e-01  1.413e-02  13.842  < 2e-16 ***
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    
    Residual standard error: 0.3451 on 592 degrees of freedom
    Multiple R-squared:  0.8819,	Adjusted R-squared:  0.8809 
    F-statistic: 884.4 on 5 and 592 DF,  p-value: < 2.2e-16




```R
# Predicting the Test set results and evaluate the Mean Squared Error
y_pred = predict(Linear_regressor2, newdata = test_set)
mse2 <- mean((test_set$Cooling.Load - y_pred)^2)
mse2
```


0.117171739635422


Error rate is lower!. R-squared values are also good. Now visualize True vs Predicted values


```R
#Here we create an x sequence of the size of Heating.Load in the range of the same (-1 to 3)
ggplot() +
  geom_line(aes(x = seq(-1,3,length.out = 150), y = test_set$Cooling.Load, color = 'True')) +
  geom_line(aes(x = seq(-1,3,length.out = 150), y = y_pred,color = 'Predicted'))+
  scale_color_manual(name=' ',values=c(True ='green', Predicted ='blue'))+
  ggtitle('Cooling.Load - True vs Predicted') +
  xlab(' ') +
  ylab('Cooling.Load')
```




![png](output_47_1.png)


The Linear Regression models which we created seem to be good predictors of Heating.Load and Cooling.Load i.e. the model can capture most of the features of the Energyefficiency dataset. 

Lets now create a few other types of regression models commonly used and see how it does impact the error statistics :
1. Decision Tree Regression
1. KNN Regression
2. RandomForests Regression


```R
#Lets begin by importing libraries
#install.packages("FNN")
library(FNN)
library(rpart)
library(randomForest)
```

    randomForest 4.6-12
    Type rfNews() to see new features/changes/bug fixes.
    
    Attaching package: ‘randomForest’
    
    The following object is masked from ‘package:gridExtra’:
    
        combine
    
    The following object is masked from ‘package:ggplot2’:
    
        margin
    



```R
#Splitting to training and test sets
set.seed(123)
split <- sample.split(Energyefficiency$Heating.Load, SplitRatio = 0.8)
training_set <- subset(Energyefficiency, split == TRUE)
test_set <- subset(Energyefficiency, split == FALSE)
```


```R
# Fitting Decision Tree Regression to the dataset
dec_tree_regressor = rpart(formula = Heating.Load ~Relative.Compactness + Surface.Area + Wall.Area +
                           Overall.Height + Orientation + Glazing.Area,
                  data = training_set,
                  control = rpart.control(minsplit = 1))
```


```R
# Predicting with Decision Tree Regression
y_pred = predict(dec_tree_regressor, newdata = test_set)
```


```R
#Evaluating MSE on test set
dec_tree_mse1 <- mean((test_set$Heating.Load - y_pred)^2)
dec_tree_mse1
```


96.7111221850762


The results for Decision Tree regression are not promising. The error rate is too large. Lets now try implementing another algorithm, 


```R
# Fitting KNN Regression to the dataset
knn_regressor = knn.reg(train = training_set, test = test_set, y =training_set$Heating.Load)
```


```R
# Predicting with KNN Regression
#Evaluating MSE on test set
knn_mse1 <- mean((test_set$Heating.Load - knn_regressor$pred)^2)
knn_mse1
```


0.495195333333334


MSE results are very good for KNN Regression ! Lets proceed to Random Forests, 


```R
# Fitting Random Forest Regression to the dataset
set.seed(1234)
randForest_regressor = randomForest(formula = Heating.Load ~Relative.Compactness + Surface.Area + Wall.Area +
                          Overall.Height + Glazing.Area + Glazing.Area.Distribution,
                          data = training_set,         
                          ntree = 500)
```


```R
# Predicting with Random Forests Regression
y_pred = predict(randForest_regressor, newdata = test_set)
```


```R
rf_mse1 <- mean((test_set$Heating.Load - y_pred)^2)
rf_mse1
```


0.851757040738826


The error rate is good !. Random forests is another good fit to the data and performs well on the test set too !.

## Concluding Remarks
1. The Linear Regression algorithm can make good predictions for the Heating Load and Cooling Load, the output    parameters of the dataset, when evaluated on a test set.
2. The methods KNN regression and the Random Forests regression do perform equaly good, giving out lower test MSE's.

Lets print a summary for Heating Load predictions with the methods adopted :


```R
Method <- c("Linear Regression", "Decision Tree Regression","KNN Regerssion", "Random Forests Regression")
MSE  <- c(Linear_mse1,dec_tree_mse1,knn_mse1,rf_mse1)
data.frame(Method,MSE)
```


<table>
<thead><tr><th scope=col>Method</th><th scope=col>MSE</th></tr></thead>
<tbody>
	<tr><td>Linear Regression        </td><td> 0.09840992              </td></tr>
	<tr><td>Decision Tree Regression </td><td>96.71112219              </td></tr>
	<tr><td>KNN Regerssion           </td><td> 0.49519533              </td></tr>
	<tr><td>Random Forests Regression</td><td> 0.85175704              </td></tr>
</tbody>
</table>




```R

```
