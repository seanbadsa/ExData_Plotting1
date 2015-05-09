# plot4.R
# Instruction - Copy and paste the entire code into R console.
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
  write.table(pc,subfile,sep=';')
  cat("##  Read the filtered file .... ###\n")
  pc<-read.table(subfile,header=TRUE,sep=';')
} else {
setwd(src)
cat("##    Read the filtered file    ... ### \n")
pc<-read.table(subfile,header=TRUE,sep=';') 
}

###########
png(filename='plot4.png',width=480,height=480,units='px')

# make 4 plots
par(mfrow=c(2,2))

# plot data on top left (1,1)
plot(pc$DateTime,pc$Global_active_power,ylab='Global Active Power',xlab='',type='l')

# plot data on top right (1,2)
plot(pc$DateTime,pc$Voltage,xlab='datetime',ylab='Voltage',type='l')

# plot data on bottom left (2,1)
lncol<-c('black','red','blue')
lbls<-c('Sub_metering_1','Sub_metering_2','Sub_metering_3')
plot(pc$DateTime,pc$SubMetering_1,type='l',col=lncol[1],xlab='',ylab='Energy sub metering')
lines(pc$DateTime,pc$SubMetering_2,col=lncol[2])
lines(pc$DateTime,pc$SubMetering_3,col=lncol[3])

# plot data on bottom right (2,2)
plot(pc$DateTime,pc$Global_reactive_power,xlab='datetime',ylab='Global_reactive_power',type='l')

# close device
x<-dev.off()
###########################################

