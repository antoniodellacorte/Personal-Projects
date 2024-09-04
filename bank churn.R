# EDA
complete_records=read.csv("Customer-Churn-Records.csv")
# sampling the dataset since it is too large
set.seed(123)
# Create a sample of 1000 rows
sampled_indices = sample(1:nrow(complete_records), 1000, replace = FALSE)
# Extract the sample from the original dataset
records=complete_records[sampled_indices, ]
View(records)
summary(records)

# DATA CLEANING
#checking if there are NA observations
sum(is.na(records))
#dropping irrelevant attributes
records=subset(records,select=-c(1:3))
View(records)
#we proceeded at analyzing data and factorizing the relevant attributes
records$Card.Type=as.factor(records$Card.Type)
records$Gender=as.factor(records$Gender)
records$Geography=as.factor(records$Geography)
records$Exited=as.factor(records$Exited)
records$HasCrCard=as.factor(records$HasCrCard)
records$Complain=as.factor(records$Complain)
records$IsActiveMember=as.factor(records$IsActiveMember)
#now check the distribution of data 
summary(records)
#we found out that data are balanced accross the different attributes 
#(i.e card.type value are similar among the clients)


#We proceed at performing data visualization 
barplot(table(records$Exited), main= "Churn Rate", ylim=c(0,800), names.arg = c("Non Exited (78.4%)", "Exited (21.6%)"), col=c("orange", "darkblue"))
table(records$Exited)
hist(records$CreditScore,breaks=18)
barplot(table(records$Exited, records$Complain), main= "Churn Rate by Complain", ylim=c(0,800), names.arg = c("Non Exited (78.4%)", "Exited (21.6%)"), col=c("orange", "darkblue"))
# in order to find the right amount of bins we apply the sturges'rule 
#however we decide to increase a little bit the amount to make it looks like a normal distribution
#making histogram for every numerical attribute
hist(records$Age,breaks=18)
#k-squared distribution 
#Tenure=number of years that the customer has been a client of the bank. 
hist(records$Tenure,breaks=18)
#uniformed distribution 
hist(records$Balance,breaks=18)
hist(records$EstimatedSalary, breaks=18)
hist(records$Point.Earned, breaks=18)
hist(records$Satisfaction.Score, breaks=5)
aggregate(records, by=list(records$Exited), FUN=mean)

#check correlation among data (most relevant attributes)
cor(as.numeric(records$Exited), records$Age)
#result= 0.3423002 which means there is a little positive correlation 
cor(as.numeric(records$Exited), as.numeric(records$Complain))
#result= 1 which means there is a perfect positive correlation 

#making tables to check possible correlations with exited (churn or not)
table(records$Complain,records$Exited)
#perfect correlation among these 2 variables (when people complain they exit!)
table(records$Gender,records$Exited)
#therefore women are slighly more likely to churn
table(records$Card.Type, records$Exited)
#data are well balanced
table(records$Age>40, records$Exited)
#people older than 40 years are more likely to churn
table(records$Geography,records$Exited)
#German people are more likely to exit. 
table(records$IsActiveMember,records$Exited)
#when not active people exit more frequently 
table(records$HasCrCard,records$Exited)
#if no cards more likely to exit
table(records$Satisfaction.Score,records$Exited)
#1:17, 2:26, 3:16%, 4:27%, 5:20% Why?
table(records$Tenure,records$Exited)
#explained by the age
table(records$NumOfProducts, records$Exited)

# DATA VISUALIZATION
table_result=table(records$Geography, records$Exited)
# Add percentage calculation
table_percentage=prop.table(table_result, margin = 1) * 100
# Combine the count table and percentage table
result_table=cbind(table_result, table_percentage)
colnames(result_table)=c("Not Exited", "Exited", "Non Churn Ratio", "Churn Ratio")
print(result_table)
#making barplot to visulize data
barplot(table(records$Complain,records$Exited), main= "Churn Rate by Complain", ylim=c(0,800), names.arg = c("Non Exited", "Exited"), col=c("orange", "darkblue"))
barplot(table(records$Gender, records$Exited),  ylim=c(0,800), names.arg = c("Non Exited", "Exited"),col=c("darkblue", "orange"), main="Churn ratio by Gender", legend=TRUE,   legend.text = c('Female', 'Male'))
barplot(table(records$Card.Type, records$Exited), ylim=c(0,800), names.arg = c("Non Exited", "Exited"), col=c("blue", "orange", "grey", "green"), main="Charn ratio by Card.Type", legend=TRUE,   legend.text = c('Diamond', 'Gold', "Platinum", "Silver"))
barplot(table(records$Age>40, records$Exited), ylim=c(0,800), names.arg = c("Non Exited", "Exited"), col=c("darkblue", "orange"), main="Churn by Age", legend=TRUE,   legend.text = c('< 40', '> 40'))
barplot(result_table, col=c("blue", "black", "orange"), main="Churn by Location", ylim=c(0,800),legend=TRUE,   legend.text = c('France', 'Germany', "Spain" ))
barplot(table(records$CreditScore>600,records$Exited),ylim=c(0,800), names.arg = c("Non Exited", "Exited"),col=c("darkblue", "orange"), main="Churn ratio by CreditScore", legend=TRUE,   legend.text = c('<600', '>600'))
table(records$CreditScore>600)
table(records$EstimatedSalary<150000, records$Exited)

#Performing the PCA
#selecting only numerical attributes= credit-score, age, tenure, balance,numofproducts,salary, satisfaction score,points.earned)
records.num=records[,c(4,5,6,10,13)]
records.scaled=scale(records.num)
records.pc=prcomp(records.scaled)
records.pc
summary(records.pc)
#considering the result we have decided to use 4 PC because they explain 91.3% of the variance
records.pc$x
records.pc$x[,1:4]
#we made a sample of 1k observation to make easier to calculate and show clusters

#CLUSTERING
#now find the distance
records.pc.dist=dist(records.scaled)
records.pc.hc=hclust(records.pc.dist)
plot(records.pc.hc)
# too large to use hierarchical clustering
# so we apply k-means
install.packages("cluster")
library("cluster")
records.dist=dist(records.scaled)
#K-MEANS
records.km2=kmeans(records.scaled,2)
records.km2
aggregate(records.num, by=list(records.km2$cluster), FUN=summary)
table(records.km2$cluster)
library(fpc)
cluster.stats(records.dist,records.km2$cluster)
silhouette(records.km2$cluster, records.dist)
myclustercolors=c("red", "blue")
library(dbscan)
table(records.km2$cluster, records$Exited)
plot(records$Balance, records$EstimatedSalary, col=myclustercolors[records.km2$cluster])
hullplot(records.num,records.km2$cluster)
hullplot(records[c(3,11)], records.km2$cluster)

#C-MEANS
library(e1071)
cmeans(records.scaled,2)
records.cm2=cmeans(records.scaled,2)
records.cm2$membership
records.cm2$membership[,1]
plot(records.cm2$membership[,1])
plot(ecdf(records.cm2$membership[,1]), ylim=c(0,1),col="green")
par(new=T)
plot(ecdf(records.cm2$membership[,2]), ylim=c(0,1), col="red")

#DECISION TREES
library(rpart)
library(rpart.plot)
records.idx=sample(8000, 2000)
records.idx
records.train=records[records.idx, ]
records.test=records[-records.idx, ]
table(records$Exited)
table(records.train$Exited)
table(records.test$Exited)
records.dt1=rpart(Exited ~.-Complain, data=records.train)
rpart.plot(records.dt1)
predict(records.dt1, data=records.test)
#probability associated with the various classification 
predict(records.dt1, data=records.test, type="class")
#store it in a variable
records.test.pred=predict(records.dt1, records.test,type="class")
table(records.test$Exited, records.test.pred)
accuracy1=(540+61)/(540+25+106+61)
records.dt2=rpart(Exited ~Complain+Age+Gender+Geography+Tenure+Satisfaction.Score, data=records.train)
rpart.plot(records.dt2)
predict(records.dt2, data=records.test)
#probability associated with the various classification 
predict(records.dt2, data=records.test, type="class")
#store it in a variable
records.test.pred=predict(records.dt2, records.test,type="class")
table(records.test$Exited, records.test.pred)
accuracy2=(591+152)/(591+152)

#RANDOM FOREST
#random forest to check accuracy of the model
install.packages("randomForest")
library(randomForest)
help(randomForest)
records.train=na.omit(records.train)
records.rf1=randomForest(Exited ~.-Complain, data=records.train )
records.rf1.pred=predict(records.rf1, records.test)
records.rf1$importance
table(records.test$Exited, records.rf1.pred)
accuracy3=(558+31)/(558+31+7+136)
records.rf1.sorted=sort(decreasing=TRUE, records.rf1$importance)
records.rf1.sorted
variables.rf1.names=c("Age", "Point.Earned", "CreditScore", "Balance", "NumOfProducts", 
                      "EstimatedSalary", "Tenure", "Geography", "Card.Type", 
                      "Satisfaction.Score", "HasCrCard", "Gender", "IsActiveMember")
barplot(records.rf1.sorted, names.arg=variables.rf1.names,
        main = "Feature Importances", ylab = "Importance", 
        col = "skyblue", las = 2, cex.names = 0.8)
#try with complain 
records.rf2=randomForest(Exited ~., data=records.train )
records.rf2.pred=predict(records.rf2, records.test)
records.rf2$importance
table(records.test$Exited, records.rf2.pred)
accuracy4=1
records.rf2.sorted=sort(decreasing=TRUE, records.rf2$importance)
records.rf2.sorted
variables.rf2.names=c("Complain","Age", "Point.Earned", "CreditScore", "Balance", "NumOfProducts", 
                      "EstimatedSalary", "Tenure", "Geography", "Card.Type", 
                      "Satisfaction.Score", "HasCrCard", "Gender", "IsActiveMember")
barplot(records.rf2.sorted, names.arg=variables.rf2.names,
        main = "Feature Importances", ylab = "Importance", 
        col = "skyblue", las = 2, cex.names = 0.8)
