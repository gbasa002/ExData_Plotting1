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

##CHANGE THE NAMES OF COLUMNS
names (myWholeData) <- c("Date", "Time", "GAP", "GRP", "Voltage", "GI", "SM1", "SM2", "SM3")

##############################################remove first column#########################################################

myWholeData <- myWholeData [-1,]
#str (myWholeData$Date)

#########################################################convert date columns/use lubridate###############################

myWholeData$Date <- dmy(as.character(myWholeData$Date))
#str (myWholeData$Date)

###############################################subsetting february data####################################################

myPartialData <- subset(myWholeData, myWholeData$Date == ymd("2007-02-01") | myWholeData$Date == ymd ("2007-02-02"))

#str (myPartialData$SM1)
#str (myPartialData$SM2)
#str (myPartialData$SM3)

##convert from factors to numeric to be able to plot
myPartialData$SM1 <- as.numeric(as.character(myPartialData$SM1))
myPartialData$SM2 <- as.numeric(as.character(myPartialData$SM2))
myPartialData$SM3 <- as.numeric(as.character(myPartialData$SM3))

#combine date and time column
datetimecombined <- as.POSIXct (paste (myPartialData$Date, myPartialData$Time), format = "%Y-%m-%d %H:%M:%S")
#add an extra column for date time combined
myPartialData <- mutate (myPartialData, DateTimeCombined = datetimecombined)

#png create
png("plot3.png", 480, 480)
##plot
plot (myPartialData$DateTimeCombined,myPartialData$SM1, type ="l", ylab = "Energy sub metering", xlab = "")
lines(myPartialData$DateTimeCombined, myPartialData$SM2, type ="l", col = "red")
lines(myPartialData$DateTimeCombined, myPartialData$SM3, type ="l", col = "blue")
#put the legend to topright
legend(x = "topright", y = NULL,c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),lwd=c(2.5,2.5, 2.5),col=c("black","blue","red"))
dev.off()






