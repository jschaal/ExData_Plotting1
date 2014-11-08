#   plot2.R
#
#   Create second assignment plot

#   Execute R Script common to all plots used to create Power Data Subset
#   Please see the script ReadPowerData.R included in this repository
#   The script will create a data.frame called SubPowerData which is the input data to this plot 
source("ReadPowerData.R")

#   Optionally and more efficiently, Load Power Subset data previously created by ReadPowerData.R
#   load("data/subPowerData.RData")  

#   open PNG graphic device
png(filename="plot2.png",width=480,height = 480)

#   generate plot
#   subPowerData is the data.frame created by  R script ReadPowerData.R
plot(subPowerData$Time,subPowerData$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

#   Save PNG graphic file and close Graphic Device
dev.off()
