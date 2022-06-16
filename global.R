library(shiny)
library(shinyjs)
library(vcd)
library(MASS)
library(DT)
library(RColorBrewer)
library(datasets)
library(corrgram)
library(visdat)
library(tidytext)
library(tidyverse)
library(janeaustenr)
library(stringr)
library(wordcloud2)
library(reshape2)
library(pls)
library(ggplot2)
library(car)
library(textdata)
library(seriation)
library(leaflet)
library(shinycssloaders)
library(readr)
library(summarytools)
library(matrixStats)

library(devtools)
install_github("mtennekes/tabplot")

## read the data from Ass1Data.csv
dat <- read.csv("data.csv", header = TRUE, stringsAsFactors = TRUE)

dat$ID <- as.character(dat$ID)
dat$Date <- as.Date(dat$Date)
dat$Priority <- ordered(dat$Priority, levels=c("Low", "Medium", "High"))
dat$Price <- ordered(dat$Price, levels=c("Cheap","Costly","Extravagant"))
dat$Speed <- ordered(dat$Speed, levels=c("Slow","Medium","Fast"))
dat$Duration <-ordered(dat$Duration, levels=c("Short","Long","Very Long"))
dat$Temp <- ordered(dat$Temp,levels=c("Cold","Warm","Hot"))


## categorical subset, for Mosaic plot, tabplot1
catsdata <- subset(dat, select = c(2:14))
choicesA <- colnames(as.data.frame(catsdata))
#choicesA <- choicesA[-length(choicesA)]
choicesA_1 <- colnames(as.data.frame(catsdata[4:6]))


## numeric subset, for boxplot, correlation chart, and rising-value chart
numsdata <- subset(dat, select = c(1,15:44))
choicesB <- colnames(as.data.frame(numsdata))
 
choicesC <- c(choicesB , "median_survey1to10","median_surveyr11to20","median_survey21to30")

#choicesA_default <- c("Price","Speed", "Temp")

#choicesB_default <- c("Y","survey1", "survey11", "survey21")

#choicesC_default <- c("survey4", "survey5","survey6","survey1", "Y")

choicesD_default <- c("Price","Speed")

choicesE_default <- c("median_survey1to10","median_surveyr11to20","median_survey21to30", "Y")
 
# standardized rising value
#which(is.na(dat$Y))
#min(dat$Y)/2
#max(dat$Y)/2

# Tabplot2
dat2<-subset(numsdata, select=c(1,5,8,10,19,22,24,29)) #Y,survey4,7,9,18,21,23,28
dat2<-data.frame(row=1:nrow(dat2), dat2)


## full data, for ggpairs
dat3 <- dat[, -c(2, 4)]    #delete high cardinality variables(ID & Date),
dat4<-subset(dat, select=c(1,6,15:17,19,20,22,24)) #only select a few important variables 





