setwd("~/Desktop/")

#1: Function to calculate pollutant mean from files in directory

pollutantmean <- function(directory, pollutant, id = 1:332) {
  file_names <- dir(directory)[id]
  df <- do.call(rbind,lapply(paste(directory,"/",file_names,sep=""),read.csv))
  mean(df[,pollutant], na.rm=TRUE)
}

#2: Function to aggregate only complete data points

complete <- function(directory, id=1:332) {
  file_names <- dir(directory)[id]
  df <- do.call(rbind,lapply(paste(directory,"/",file_names,sep=""),read.csv))
  df <- df[complete.cases(df),]
  aggregate(Date~ID,df,length)[order(id),]
}

#3: Function to calculate the correlation between sulfate and nitrate 
# on all complete cases of the files and subset by threshold

library(plyr)

corr <- function(directory, threshold=0) {
  file_names <- dir(directory)
  df <- do.call(rbind,lapply(paste(directory,"/",file_names,sep=""),read.csv))
  df <- df[complete.cases(df),]
  cases <- ddply(df,"ID",summarise, corr=cor(sulfate,nitrate))
  cases$length <- aggregate(Date~ID,df,length)$Date
  cases[cases$length>threshold,]$corr
}
