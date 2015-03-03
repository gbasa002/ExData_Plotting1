##########################            CHECK AND SET WORKING DIRECTORY         ###################################
#getwd()
#setwd("C:/Users/gbasa002/Desktop/EDA_Course Project1")

##########################                        INCLUDE LIBRARIES           ###################################
#install.packages ("dplyr")
#install.packages ("plyr")
#install.packages("lubridate")
library (dplyr)
library (plyr)
library (lubridate)
library (datasets)

#####################################        READ DATA       #####################################################

myWholeData <- read.table ("household_power_consumption.txt", sep = ";")

##CHANGE THE NAMES TO EASIER-TO-REMEMBER NAMES
names (myWholeData) <- c("Date", "Time", "GAP", "GRP", "Voltage", "GI", "SM1", "SM2", "SM3")

##REMOVE THE HEADER ROW
myWholeData <- myWholeData [-1,]

#############################          CONVERT CHARACTERS TO DATES        ###############################

myWholeData$Date <- dmy(as.character(myWholeData$Date))
#str (myWholeData$Date)

############################           SUBSET FEBRUARY DATA              ############################### 

myPartialData <- subset(myWholeData, myWholeData$Date == ymd("2007-02-01") | myWholeData$Date == ymd ("2007-02-02"))
#unique (myPartialData$Date)
#names(myPartialData)

##Plot 1: Histogram of Global Active Power versus Frequency
##names(myPartialData)
##str (myPartialData$GAP)
myPartialData$GAP <- as.numeric(as.character(myPartialData$GAP))

##remove missing data of Global Active Power if any////no need////NO MISSING VALUE
##myPartialData2 <- myPartialData [which(myPartialData$GAP != "?"),]
##unique(myPartialData$GAP)

############################              PLOT AND SAVE AS PNG              ###################################
png("plot1.png", 480, 480)
hist(myPartialData$GAP, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()





























