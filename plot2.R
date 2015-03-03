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
#str (myWholeData$Date)

#########################################################convert date columns/use lubridate###############################

myWholeData$Date <- dmy(as.character(myWholeData$Date))
#str (myWholeData$Date)

###############################################subsetting february data####################################################

myPartialData <- subset(myWholeData, myWholeData$Date == ymd("2007-02-01") | myWholeData$Date == ymd ("2007-02-02"))

##Plot 2: Line- GAP versus Days (lubridate weekday??)
#wday (myPartialData$Date, label = T)
#myPartialData  <- mutate (myPartialData, Weekday = wday(myPartialData$Date, label = T)) #this was not necessary

##this is necessary
#combine date and time column
datetimecombined <- as.POSIXct (paste (myPartialData$Date, myPartialData$Time), format = "%Y-%m-%d %H:%M:%S")
#add an extra column for date time combined
myPartialData <- mutate (myPartialData, DateTimeCombined = datetimecombined)
#str(myPartialData$GAP)
#this is factors.Convert to numeric to plot.// use combined date time
myPartialData$GAP <- as.numeric(as.character(myPartialData$GAP))

png("plot2.png", 480, 480)
plot (myPartialData$DateTimeCombined,myPartialData$GAP, type ="l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()







