#   plot1.R
#
#   Create first assignment plot

#   Execute R Script common to all plots used to create Power Data Subset
#   Please see the script ReadPowerData.R included in this repository
#   The script will create a data.frame called SubPowerData which is the input data to this plot 
source("ReadPowerData.R")

##  Optionally and more efficiently, Load Power Subset data previously created by ReadPowerData.R
#   load("data/subPowerData.RData")  

#   open PNG graphic device
png(filename="plot1.png",width=480,height = 480)

#   generate plot
#   subPowerData is the data.frame created by  R script ReadPowerData.R
hist(subPowerData$Global_active_power,main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",col="red")

#   Save PNG graphic file and close Graphic Device
dev.off()
