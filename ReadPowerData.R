#   ReadPowerData.R
#   Utility script to read, convert,  extract and save a subset of data from
#   a large master power consumption text file
#   Called by each plot R script to generate subset of Power Data used to generate plots
#   Also saves converted data to allow data to be loaded by plot scripts vs regenerating each time


dataToRead <- "data/household_power_consumption.txt"

# Load  into temporary dataFrame 
print(paste("Loading: ",dataToRead))
inPowerData <- read.table(dataToRead,na.strings="?", sep=";",stringsAsFactors = FALSE,
                          header=TRUE, colClasses=c("character","character",rep("numeric",7)))


# Convert date character field to an R date field that will be used to filter the data
print("Converting Dates")
inPowerData$Date <- as.Date(inPowerData$Date,format("%d/%m/%Y"))

# Extract a subset of the data and saved to new dataFrame
print("Subsetting Data")
subPowerData <- subset(inPowerData, 
                       Date>=as.Date("2007-02-01","%Y-%m-%d") 
                       & Date<=as.Date("2007-02-02","%Y-%m-%d"))

# Convert character time field in input file to an R POSIXlt Time Variable
print("Converting Time")
subPowerData$Time <- 
    strptime(paste(as.character(subPowerData$Date),subPowerData$Time),"%Y-%m-%d %H:%M:%S")

# Save converted and fitered data to an R extract for subsequent loading and manipulation
print("Saving Subset Data for optional loading by plot scripts")
save(subPowerData, file = "data/subPowerData.RData")

# Remove large temporary input dataFrame from local memory
rm(inPowerData)

print("Data Conversion Complete")
