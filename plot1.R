#getwd()
#setwd("C:/Users/gbasa002/Desktop/EDA_Course Project1")

#install.packages ("dplyr")
#install.packages ("plyr")
#install.packages("lubridate")
library (dplyr)
library (plyr)
library (lubridate)
library (datasets)

###############################################read data##################################################################

myWholeData <- read.table ("household_power_consumption.txt", sep = ";")

##CHANGE THE NAMES
names (myWholeData) <- c("Date", "Time", "GAP", "GRP", "Voltage", "GI", "SM1", "SM2", "SM3")

##############################################remove first column#########################################################

myWholeData <- myWholeData [-1,]
str (myWholeData$Date)

#########################################################convert date columns/use lubridate###############################

myWholeData$Date <- dmy(as.character(myWholeData$Date))
str (myWholeData$Date)

###############################################subsetting february data####################################################

myPartialData <- subset(myWholeData, myWholeData$Date == ymd("2007-02-01") | myWholeData$Date == ymd ("2007-02-02"))
#unique (myPartialData$Date)
#names(myPartialData)

##Plot 1: Histogram of Global Active Power versus Frequency
#names(myPartialData)
#str (myPartialData$GAP)
myPartialData$GAP <- as.numeric(as.character(myPartialData$GAP))

##remove missing data of Global Active Power if any no need
#myPartialData2 <- myPartialData [which(myPartialData$GAP != "?"),]
#?hist
#unique(myPartialData$GAP)

#myPartialData$GAP <- as.numeric(myPartialData$GAP)
# add kilowatts column for GAP
png("plot1.png", 480, 480)
hist(myPartialData$GAP, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()





























