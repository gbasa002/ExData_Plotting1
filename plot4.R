#################                                  SET WORKING DIRECTORY                                ##################

#getwd()
#setwd("C:/Users/gbasa002/Desktop/EDA_Course Project1")

#################                                   INSTALL/INCLUDE LIBRARIES                           ##################

#install.packages ("dplyr")
#install.packages ("plyr")
#install.packages("lubridate")
library (dplyr)
library (plyr)
library (lubridate)
library (datasets)

#################                                   READ DATA                                            ##################

myWholeData <- read.table ("household_power_consumption.txt", sep = ";")

###CHANGE THE NAMES
names (myWholeData) <- c("Date", "Time", "GAP", "GRP", "Voltage", "GI", "SM1", "SM2", "SM3")

################                                     REMOVE HEADER COLUMN                                 #################

myWholeData <- myWholeData [-1,]
str (myWholeData$Date)

#############                          CONVERT DATES FROM CHARACTER TO POSIXCT                              ################

myWholeData$Date <- dmy(as.character(myWholeData$Date))
str (myWholeData$Date)

##########                                    SUBSET FEBRUARY DATA                                               ############

myPartialData <- subset(myWholeData, myWholeData$Date == ymd("2007-02-01") | myWholeData$Date == ymd ("2007-02-02"))

##############                               ARRANGE DATA BEFORE PLOTTING                                    ################

#COMBINE DATE AND TIME COLUMN
datetimecombined <- as.POSIXct (paste (myPartialData$Date, myPartialData$Time), format = "%Y-%m-%d %H:%M:%S")
#ADD COMBINED DATE-TIME AS A NEW COLUMN
myPartialData <- mutate (myPartialData, DateTimeCombined = datetimecombined)

##CONVERT FROM FACTORS TO NUMERIC
myPartialData$SM1 <- as.numeric(as.character(myPartialData$SM1))
myPartialData$SM2 <- as.numeric(as.character(myPartialData$SM2))
myPartialData$SM3 <- as.numeric(as.character(myPartialData$SM3))

#str(myPartialData$Voltage)
#str(myPartialData$GRP)
##BOTH ARE FACTORS. 
##CONVERT FROM FACTORS TO NUMERIC
myPartialData$GAP <- as.numeric(as.character(myPartialData$GAP))
myPartialData$Voltage <- as.numeric(as.character(myPartialData$Voltage))
myPartialData$GRP <- as.numeric(as.character(myPartialData$GRP))

##NOW PLOTTING
##4 FIGURE 2 BY 2 IN ROWS VS. COLUMNS: USE MFROW
##SAVE PLOT4 TO PNG FILE
png ("plot4.png", 480, 480)
attach (myPartialData)
par (mfrow = c(2,2))
plot (myPartialData$DateTimeCombined,myPartialData$GAP, type ="l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot (myPartialData$DateTimeCombined,myPartialData$Voltage, type ="l", ylab = "Voltage", xlab = "datetime")
plot (myPartialData$DateTimeCombined,myPartialData$SM1, type ="l", ylab = "Energy sub metering", xlab = "")
lines(myPartialData$DateTimeCombined, myPartialData$SM2, type ="l", col = "red")
lines(myPartialData$DateTimeCombined, myPartialData$SM3, type ="l", col = "blue")
##PUT THE LEGEND TO TOPRIGHT CORNER
legend(x = "topright", y = NULL,c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),lwd=c(2.5,2.5, 2.5),col=c("black","blue","red"))
plot (myPartialData$DateTimeCombined,myPartialData$GRP, type ="l", ylab = "Global Reactive Power", xlab = "datetime")
dev.off()






