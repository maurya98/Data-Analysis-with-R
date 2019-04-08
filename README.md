# Data-Analysis-with-R
Data analysis on lending data on bank using logistic regression

First set the path of your CSV file
Then read the file using 'read.csv(path, header=T)

Then check for relevance of the data and remove which are not relevant
Mostly the column which have 'factor' data type are irrelevant but some times they need to be fixed and converted into numeric

We replace null,blank value with 0 in this case (may be not necessary in othe data set)

Then do the sampling in ratio of 70:30 percent for better result

Then perfom Logistic regression 
and find out the confusion matrix

In this project I have consider 28 features(column) and have achived 97% +ve class acuraccy and 99% -ve class accuracy
