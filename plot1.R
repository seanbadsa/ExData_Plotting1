###ptot1.R
#####################################################################
# RUN THE PROGRAM AS IS
# FIRST TIME RUN MAY TAKE LITTLE LONGER
# AS IT WILL DOWNLOAD, UNZIP AND CREATE A NEW DATA SET.
# PLS BE PATIENT
# THE plot1[1..].png FILE WILL BE CREATED UNDER ~/EDA/data directory
# THIS SCRIPT WILL CREATE THE DIRECTORY YOU CAN RUN : CD ~/EDA2/DATA/
## THIS SCRIPT IS TESTED UNDER WINDOWS R CONSOLE VERSION -3.1.3
#####################################################################
##set_env.R
# set dir path
# load the required packages
library(data.table)
library(lubridate)
library(plyr)
library(dplyr)
src <- "~/EDA/"
sfile <- paste(src,"power_consumption.zip",sep="")
destfile=paste(src,"data/household_power_consumption.txt",sep="")
subfile=paste(src,"data/sub_power_consumption.txt",sep="")
##setwd('~/EDA/')

# check the sources data folder exists
##unlink(src)
if (!file.exists(destfile)) {
  if (!file.exists(src)) {
    dir.create(src)
  }
  dir.create(src)
  setwd(src)
  cat("### downloading the file please wait..... ##\n")
  url<-'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(url,destfile=sfile)
  cat("### Unziping the file please wait ........##\n")
  unzip(sfile,exdir="data", overwrite=TRUE)
  cat("### Reading the downloaded file and cleaning the data.. ##\n")
  pc<-read.table(destfile,header=TRUE,sep=';',na.strings='?') 
  cat("## Filtering required records from the file...   ##\n")
  pc <- filter(pc, Date=='1/2/2007' | Date=='2/2/2007')
  pc$DateTime<-dmy(pc$Date)+hms(pc$Time)
  pc$DateTime <- strptime(paste(pc$Date, pc$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
  
  write.table(pc,subfile,sep=';')
  cat("##  Read the filtered file .... ###\n")
  pc<-read.table(subfile,header=TRUE,sep=';')
} else {
setwd(src)
cat("##    Read the filtered file    ... ### \n")
pc<-read.table(subfile,header=TRUE,sep=';') 
}


## Q1
png(filename='plot1.png',width=480,height=480,units='px')
hist(pc$Global_active_power,main='Global Active Power',xlab='Global Active Power(killowatts)',col='red')
# Turn off device
x<-dev.off()
#### end ###


