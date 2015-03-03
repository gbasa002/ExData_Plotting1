################                    GET AND SET WORKING DIRECTORY IF NECESSARY                      ###############
#getwd()
#setwd("C:/Users/gbasa002/Desktop/EDA_Course Project1")

###############                    INSTALL LIBRARIES IF NECESSARY AND INCLUDE                       ###############

#install.packages ("dplyr")
#install.packages ("plyr")
#install.packages("lubridate")
library (dplyr)
library (plyr)
library (lubridate)
library (datasets)

###############                      READ AND TIDY DATA FROM TXT FILE                              ###############
myWholeData <- read.table ("household_power_consumption.txt", sep = ";")

##CHANGE THE NAMES
names (myWholeData) <- c("Date", "Time", "GAP", "GRP", "Voltage", "GI", "SM1", "SM2", "SM3")
##REMOVE HEADER COLUMN
myWholeData <- myWholeData [-1,]
##CONVERT DATES FROM CHARACTERS TO DAY.MONTH.YEAR
myWholeData$Date <- dmy(as.character(myWholeData$Date))
#str (myWholeData$Date)

###############                              SUBSET THE FEBRUARY DATA                              ###############

myPartialData <- subset(myWholeData, myWholeData$Date == ymd("2007-02-01") | myWholeData$Date == ymd ("2007-02-02"))

##COMBINE DATE AND TIME COLUMNS TO USE IN PLOTTING
datetimecombined <- as.POSIXct (paste (myPartialData$Date, myPartialData$Time), format = "%Y-%m-%d %H:%M:%S")
## ADD AN EXTRA COLUMN OF DATETIMECOMBINED
myPartialData <- mutate (myPartialData, DateTimeCombined = datetimecombined)
#str(myPartialData$GAP)
#CONVERSION FROM FACTORS TO NUMERIC TO BE ABLE TO PLOT
myPartialData$GAP <- as.numeric(as.character(myPartialData$GAP))

###############                              PLOT IT AND SAVE IT TO PNG                         ###############

png("plot2.png", 480, 480)
plot (myPartialData$DateTimeCombined,myPartialData$GAP, type ="l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()







