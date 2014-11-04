dataToRead <- "data/household_power_consumption.txt"
#dataToRead <- "data/power_subset.txt"

print(paste("Loading: ",dataToRead))
inPowerData <- read.table(dataToRead,na.strings="?", sep=";",stringsAsFactors = FALSE,
                     header=TRUE, colClasses=c("character","character",rep("numeric",7)))


print("Converting Date")

inPowerData$Date <- as.Date(inPowerData$Date,format("%d/%m/%Y"))

print("Subsetting Data")

subPowerData <- subset(inPowerData, 
                       Date>=as.Date("2007-02-01","%Y-%m-%d") 
                       & Date<=as.Date("2007-02-02","%Y-%m-%d"))

print("Converting Time")
subPowerData$Time <- strptime(paste(subPowerData$Date,subPowerData$Time),"%d/%m/%Y %H:%M:%S")

print("Saving Subset Data")
save(subPowerData, file = "data/subPowerData.RData")
