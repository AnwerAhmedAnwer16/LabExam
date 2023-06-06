#reading the dataset

setwd("C:/Users/mmm/Downloads/Telegram Desktop/dr hamada/New folder (2)/labs")
getwd()
mydata <- read.csv('G4_howell.csv')
str(mydata)
summary(mydata)

# convert sex vector into factor

class(mydata$sex)
mydata$sex <- factor(mydata$sex)
summary(mydata$sex)
levels(mydata$sex) <- c("Female","Male" )

# removing  kg from the end of weight

mydata$weight <- gsub(" kg","",mydata$weight)
mydata$weight <- as.numeric(mydata$weight)
class(mydata$weight)


#remove overweight column (all null values)
mydata$Overweight = NULL


# filling missing values

install.packages("mice")
library(mice)

mydata[!complete.cases(mydata), ]
Pre.imputation <- mice(mydata , m = 5, meth = c("pmm"), maxit = 20)
Pre.imputation$imp
mydata <- complete(Pre.imputation, 3)


# manipulating age variable with round value

for ( r in 1:length(mydata$age))
  mydata$age[r] = round(mydata$age[r])

mydata$age


#visualization
install.packages("tidyverse")
library(tidyverse)
library(ggplot2)
draw1 <- ggplot(mydata)
draw1 <- ggplot(mydata, aes(x=height, y=weight))
draw1
draw1 + geom_point()


draw_bar <- ggplot(mydata, aes(x=sex, fill = sex))
draw_bar + geom_bar()







