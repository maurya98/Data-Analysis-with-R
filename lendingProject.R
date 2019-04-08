path="E:\\project\\R programming\\lendingdata.csv"
lending=read.csv(path,header = T)
#View(lending)


#num_data=names(lending[sapply(lending,is.factor)])
#num_data
#str(lending)
#colnames(lending)
#corrsd=cor(lending[1:24])
#corrsd
#library(corrplot)
#corrplot(corrsd,method="number",type="lower")
#?corrplot()

#--------------------------------------------------------------------------------

str(lending)
sapply(lending,class)

# identify total no. of missing values
sum(is.na(lending))

#column names with missing data
names(lending[,!complete.cases(t(lending))])

#data cleanup
#removing NA values and replacing with 0s
lending$mths_since_last_delinq[is.na(lending$mths_since_last_delinq)]=0
lending$mths_since_last_record[is.na(lending$mths_since_last_record)]=0

#removing months with xx months to numeric value
lending$term=as.numeric(strsplit(as.character(lending$term),"months"))

#Droping irrelevant columns
lending$policy_code=NULL
lending$collections_12_mths_ex_med=NULL
lending$emp_length=NULL
lending$Verification_Status=NULL
lending$mths_since_last_major_derog=NULL
lending$initial_list_status=NULL
lending$id=NULL
lending$member_id=NULL
lending$desc=NULL
lending$zip_code=NULL
lending$title=NULL
lending$emp_title=NULL
lending$application_type=NULL
lending$pymnt_plan=NULL
lending$home_ownership=NULL
lending$purpose=NULL
lending$addr_state=NULL
lending$last_credit_pull_d=NULL
lending$next_pymnt_d=NULL
lending$last_pymnt_d=NULL
lending$issue_d=NULL
lending$earliest_cr_line=NULL
lending$verification_status=NULL
lending$grade=NULL
lending$sub_grade=NULL
length(colnames(lending))
#lending$emp_length=as.numeric(strsplit(as.character(lending$emp_length),"years"))


#checking annual income outliars
#boxplot(lending$annual_inc,horizontal = T,main="annual income")

#fixing outliar with the mean
#quantile(lending$annual_inc)
#right_wisker=80000+((80000-40440.5)*1.5)
#right_wisker

#mean(lending$annual_inc)
#lending$annual_inc[lending$annual_inc>right_wisker]=right_wisker

#info and plot
#summary(lending$int_rate)

#set plot display to 1 row and 3 graphs
#par(mfrow=c(1,3))

#plot intrest rate and check normal distribution
#boxplot(lending$int_rate,horizontal = T,col = "purple",xlab="intrest rate",main="boxplot intrest rate")
#hist(lending$int_rate,col = "red", xlab = "intrest rate",main="histogram")
#qqnorm(lending$int_rate)
#qqline(lending$int_rate,col="orange",lwd=1)

# Boxplot using 2 variables
#par(mfrow = c(1, 3))
#boxplot(lending$int_rate ~ lending$term, col = "orange", varwidth = TRUE,horizontal=T  , xlab = "Loan Length")
#boxplot(lending$int_rate ~ lending$purpose, col = "green", varwidth = TRUE, horizontal=T , xlab = "Loan Purpose",  ylab = "Interest Rate")
#boxplot(lending$int_rate ~ lending$home_ownership, col = "orange", varwidth = TRUE,horizontal=T, xlab = "Home Ownership", ylab = "Interest Rate")


#modeling----------------------------------------------------
set.seed(1234)

sampledata1 = sample(2, nrow(lending), replace = T, prob = c(0.7,0.3))
train = lending[sampledata1==1,]
test = lending[sampledata1==2,]
attach(lending)
#View(train)
# logistic regression - build the model
glm_bbd = glm(default_ind ~. , binomial(link="logit"),data=train)
summary(glm_bbd)


# predict the Binary outcome for attrition_value
# type = "response" gives probabilities
preds1 = predict(glm_bbd, test, type="response")
#summary(preds1)
#print(preds[1:20])

length(preds<=0.5)
length(preds>0.5)
# check the count to convert probabilites to 0/1
table(test$default_ind)

cutpoint = 0.5
predictions1 = ifelse(preds1 <=0.5, 0,1)
#predictions1

# confusion matrix
# 1 --> positive class
#install.packages("caret",dependencies = T)
library(caret)
#install.packages("e1071")
confusionMatrix(as.factor(test$default_ind), as.factor(predictions1), positive="1")


